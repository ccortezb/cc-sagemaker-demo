FROM ccortez/cxrockerapi
MAINTAINER Carlos Cortez <ccortez@aws.pe>

#RUN apt-get update -qq && apt-get install -y procps curl openssl
#RUN apt-get install -y --no-install-recommends \
#    wget \
#    r-base \
#    r-base-dev \
#    ca-certificates

RUN R -e "if(!require('devtools')) install.packages('devtools')"
RUN R -e "install.packages('plumber')"
RUN R -e "install.packages('optparse',repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('jsonlite',repos='http://cran.rstudio.com/')"
RUN R -e "library('plumber')"

#RUN R -e "install.packages(c('plumber', 'optparse', 'jsonlite'), repos='https://cloud.r-project.org')"
COPY marathon_model.RData /opt/ml/marathon_model.RData
COPY main.R /opt/ml/main.R
COPY plumber.R /opt/ml/plumber.R

WORKDIR /opt/ml

ENTRYPOINT ["/usr/bin/Rscript", "main.R", "--no-save"]
