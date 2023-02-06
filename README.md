# judo-datasets

This is the git repository of the [dennisschneiderml/judo-datasets](https://hub.docker.com/repository/docker/dennisschneiderml/judo-datasets/general) Docker-File.

It adds a reproducible way to handle datasets.

## Why would I want to use judo-datasets?

If you use datasets in a project, you probably want other researchers to be able to easily reproduce your results, beginning with using the same datasets.
Furthermore, you probably preprocess the data you get and not use the raw datasets as they are available.

## And how does it help me with that?

After finding a dataset you want to use in your project, you add an empty directory in the directory `./data`.
The recommended file-structure for the project is created by running the following command.
```shell
make
```
This results in the following data tree:
```shell
./data
|-- <dataset>/
  |-- original/
  |-- preprocessing/
  |-- preprocess.py
```
In this step you can place the raw data-files in the `original`-subdirectory.
In the following, the datafiles in `original` will be transformed to `preprocessed` through the `process.py`-script.
It conveniently already employs multithreading and splits up the dataset among all CPU-cores. You simply have to implement the preprocessing-logic in the `process`-funtion in the python-script. \
The dataset is processed by running a command which is as simple as it is familiar:
```shell
make
```
The Makefile conveniently detects which datasets need a file-structure and which have unprocessed data. So mass-processing multiple datasets over night is as easy it gets.

## I want to use this without the Docker ... stuff

Sure, just change the following variable at the top of the Makefile:
```Makefile
PROCESSING_SCRIPT=./preprocess.py
```
