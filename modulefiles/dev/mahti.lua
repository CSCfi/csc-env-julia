setenv("CSC_SYSTEM_NAME", "mahti")
setenv("CSC_APPL_DIR", "/appl")
prepend_path("MODULEPATH", pathJoin(os.getenv("PWD"), "modulefiles", "mahti"))
