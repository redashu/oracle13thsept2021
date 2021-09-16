FROM alpine
LABEL name=ashutoshh
RUN  apk add python3 
# in alpine line software installer is apk 
# like OL : yum and Ubuntu : apt 
RUN  mkdir  /pycodes
ADD https://raw.githubusercontent.com/redashu/pythonLang/main/while.py /pycodes/
# ADD is similar to COPY but add can take data from URL also 
ENTRYPOINT python3 /pycodes/while.py 
# like CMD we do have ENTRYPOINT also 
