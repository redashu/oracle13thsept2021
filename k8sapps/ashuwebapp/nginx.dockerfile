FROM nginx
LABEL email="ashutoshh@linux.com"
WORKDIR  /usr/share/nginx/html/
# changing directory during image build time 
COPY .  . 
#  first . is source last is target current location which is 
EXPOSE 80 
# optional field 
