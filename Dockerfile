FROM python:2.7.9
RUN echo "Hello World!" > index.html
EXPOSE 8080
CMD python -m SimpleHTTPServer 8080
