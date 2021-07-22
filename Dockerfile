# An example of extension of the jupyter stack 'datascience-notebook'
# with pip modules ('pip install ...') and their system dependancies ('apt-get install -y ...')
FROM jupyter/datascience-notebook
USER root
RUN apt-get update
RUN apt-get install -y python3-pyqt5 pyqt5-dev-tools qttools5-dev-tools
RUN pip install PyQt5 ete3 owlready2 pyproteinsExt ipympl jupyterlab


#Adding dedicated kernel
RUN pip install bash_kernel
RUN python3 -m bash_kernel.install

#Install for non-specific ONT 
RUN apt-get install -y unzip seqtk wget build-essential cmake git-all tar gzip

#Dedicated install to ONT analyses, packed
RUN apt-get install -y minimap2 sniffles seqtk assemblytics bandage
RUN conda install -c bioconda raven-assembler
RUN conda install -c bioconda survivor
RUN conda install -c bioconda ragtag
RUN conda install -c bioconda flye
RUN conda install -c bioconda mummer 
RUN pip install NanoPlot NanoComp

#Dedicated install to ONT analyses, manual

## RACON
RUN cd /opt
RUN git clone --recursive https://github.com/lbcb-sci/racon.git racon
RUN cd racon
RUN mkdir build
RUN cd build
RUN cmake -DCMAKE_BUILD_TYPE=Release ..
RUN make
RUN make install


## Assembly-Stats
RUN cd /opt
RUN git clone https://github.com/sanger-pathogens/assembly-stats.git
RUN cd assembly-stats
RUN mkdir build
RUN cd build
RUN cmake ..
RUN make
RUN make install


