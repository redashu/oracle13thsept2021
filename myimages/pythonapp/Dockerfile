FROM python
# pre define docker image 
LABEL   email="ashutoshh@linux.com"
RUN mkdir  /mycode
COPY  hello.py  /mycode/
CMD ["python","/mycode/hello.py"]
# to define default parent process
#  docker run -it --name x1  img1  
# CMD can be overwrite during container creation time 
# docker run -itd  --name x1 img ping fb.com 