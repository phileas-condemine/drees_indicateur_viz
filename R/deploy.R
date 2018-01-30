##https://www.shinyapps.io/admin/#/dashboard
# install.packages('rsconnect')
# rsconnect::setAccountInfo(name='drees',
                          # token='B72B47EA95B0670889990CDAC12557E3',
                          # secret='<SECRET>')

library(rsconnect)
rsconnect::deployApp('.',appName = "bhd_indicVQS")
