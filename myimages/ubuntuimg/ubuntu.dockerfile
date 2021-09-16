FROM ubuntu
# Image will be pulled from Docker hub if not present 
LABEL name="ashutoshh"
LABEL email="ashutoshh@linux.com"
# optional field 
# sharing image team info 
RUN apt update 
# updating ubuntu lib
# to give a virtual shell 
RUN apt install iputils-ping  -y
# net-tools will give ping command 
