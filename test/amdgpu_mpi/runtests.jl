# https://gist.github.com/luraess/a47931d7fb668bd4348a2c730d5489f4
using MPI
using AMDGPU

const gpu_devices = AMDGPU.devices()
const num_devices = length(gpu_devices)

MPI.Init()
comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)
# select device
comm_l = MPI.Comm_split_type(comm, MPI.COMM_TYPE_SHARED, rank)
rank_l = MPI.Comm_rank(comm_l)
# TODO: Is this robust? We should control how ranks are distributed per node.
device = AMDGPU.device_id!(mod(rank_l, num_devices)+1)
gpu_id = AMDGPU.device_id(AMDGPU.device())
# select device
size = MPI.Comm_size(comm)
dst  = mod(rank+1, size)
src  = mod(rank-1, size)
println("rank=$rank rank_loc=$rank_l (gpu_id=$gpu_id - $device), size=$size, dst=$dst, src=$src")
N = 4
send_mesg = ROCArray{Float64}(undef, N)
recv_mesg = ROCArray{Float64}(undef, N)
fill!(send_mesg, Float64(rank))
AMDGPU.synchronize()
rank==0 && println("start sending...")
MPI.Sendrecv!(send_mesg, dst, 0, recv_mesg, src, 0, comm)
println("recv_mesg on proc $rank: $recv_mesg")
rank==0 && println("done.")
MPI.Finalize()
