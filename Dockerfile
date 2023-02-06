FROM jupyter/scipy-notebook

WORKDIR /home/jovyan/work

COPY preprocess.py /usr/share/judo/preprocess.py

# Setup functionality in working directory.
COPY Makefile .
RUN mkdir data

