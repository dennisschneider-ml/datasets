# judo-datasets

This is the git repository of the [dennisschneiderml/judo-datasets](https://hub.docker.com/repository/docker/dennisschneiderml/judo-datasets/general) Docker Image.

It adds a reproducible way to handle datasets.

## Why would I want to use judo-datasets?

If you use datasets in a project, you probably want other researchers to be able to easily reproduce your results, beginning with using the same datasets.
Most research projects provide a step-by-step instruction on how to get these datasets.
But why not encapsule all this into a single command? \
judo-datasets is an extension of the judo project and provides an easy and reproducible way to preprocess datasets by simply invoking the `make` command, generating only these datasets which have not been processed yet, which also makes it suitable for using while continuously adding new datasets to the project.

## Great, so how does it work?

After finding a dataset you want to use in your project, add an empty directory in the `./data` directory.
The recommended file-structure for the dataset is created by running the following command.
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
At this point you can place the raw data-files in the `original`-subdirectory.
By invoking `make` once more, the datafiles in `original` will be transformed to `preprocessed` through the `process.py`-script.
It conveniently already employs multithreading and splits up the dataset among all CPU-cores. You simply have to implement the preprocessing-logic in the `process`-funtion in the python-script. \

The Makefile conveniently detects which datasets need a file-structure and which have unprocessed data. So mass-processing multiple datasets over night is as easy it gets.

## I want to use this without the Docker ... stuff

Sure, for this case, you are only interested in the files in `src/`. 
Simply change the following variable at the top of the Makefile:
```Makefile
PROCESSING_SCRIPT=./preprocess.py
```
