if os.getenv("USER") == "kuu-akka" then
    setenv("SBATCH_ACCOUNT", "project_2000197")
else
    setenv("SBATCH_ACCOUNT", "project_2001659")
end
