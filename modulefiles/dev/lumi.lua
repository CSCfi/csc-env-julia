setenv("CSC_SYSTEM_NAME", "lumi")
setenv("CSC_APPL_DIR", "/appl/local/csc")
prepend_path("MODULEPATH", pathJoin(os.getenv("PWD"), "modulefiles", "lumi"))
