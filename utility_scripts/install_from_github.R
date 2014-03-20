#These two lines will install the development version of tabularmanifest from GitLab.
install.packages("devtools")
# devtools::install_git(repo="internal/tabularmanifest",  ??How does this work for GitLab??) 
devtools::install_git(git_url="git@git.insightresults.com:internal/tabularmanifest.git")
