if os.getenv("USER") == "kuu-akka" then
    pushenv("SBATCH_ACCOUNT", "project_2000197")
else
    pushenv("SBATCH_ACCOUNT", "project_2001659")
end
