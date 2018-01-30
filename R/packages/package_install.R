pkg_file <- read.csv("./drees_indicateur_viz/R/packages.csv", sep=";")

packages_list <- pkg_file[pkg_file$installed_by %in% c("custom", "notebook"),]$pkgname
for (pkg in packages_list){
  # print(paste0("check: ",pkg))
  if(!require(pkg,character.only = T)){
    print(paste0("need to install: ",pkg))
    install.packages(pkg)
  }
}

devtools::install_github("dgrtwo/gganimate")
devtools::install_github("hadley/ggplot2", force = TRUE)