FROM oraclelinux:8.4
LABEL email=ashutoshh@linux.com
ENV  customer1=\

# to create env var and some value in docker image during image build time 
RUN dnf  install  httpd -y 
# OL 8 is new software installer called dnf instead of yum 
RUN mkdir  /allapps  /allapps/app1  /allapps/app2  /allapps/app3 
COPY webapp1  /allapps/app1/
COPY webapp2  /allapps/app2/
COPY  webapp3  /allapps/app3/
COPY  deploy.sh /allapps/
WORKDIR  /allapps
# to change directory like cd command persistently 
# during image build time 
RUN chmod +x deploy.sh 
EXPOSE 80 
# to let container engine about default app port optional field these days
ENTRYPOINT  ["./deploy.sh"]