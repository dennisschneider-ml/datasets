FROM jupyter/scipy-notebook

WORKDIR /home/jovyan/work

COPY ./src/preprocess.py /usr/local/share/judo/preprocess.py
COPY ./src/install_judo-datasets.sh /usr/local/bin/start-notebook.d/
COPY ./src/Makefile /tmp/
