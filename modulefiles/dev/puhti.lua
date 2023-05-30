setenv("CSC_SYSTEM_NAME", "puhti")
setenv("CSC_APPL_DIR", "/appl")
prepend_path("MODULEPATH", pathJoin(os.getenv("PWD"), "modulefiles", "puhti"))
