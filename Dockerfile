FROM python:3.7 
RUN mkdir /app 
WORKDIR /app 
COPY . /app 
  
RUN pip3 install -r requirements.txt 
  
  
  
  
CMD ["python3", "hello.py"]
