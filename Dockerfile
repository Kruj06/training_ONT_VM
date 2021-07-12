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
RUN apt-get install -y unzip seqtk wget build-essential cmake git-all tar

#Dedicated install to ONT analyses, packed
RUN apt-get install -y minimap2 sniffles seqtk assemblytics bandage
RUN conda install -c bioconda raven-assembler
RUN conda install -c bioconda survivor
RUN conda install -c bioconda ragtag
RUN conda install -c bioconda flye
RUN pip install NanoPlot

#Dedicated install to ONT analyses, manual

## MUMMER
RUN cd /opt
RUN wget https://github.com/mummer4/mummer/releases/download/v4.0.0rc1/mummer-4.0.0rc1.tar.gz
RUN tar xvzf v4.0.0rc1.zip
RUN cd mummer-4.0.0rc1/
RUN ./configure
RUN make
RUN make install

## RACON
RUN cd /opt
RUN git clone --recursive https://github.com/lbcb-sci/racon.git racon
RUN cd racon
RUN mkdir build
RUN cd build
RUN cmake -DCMAKE_BUILD_TYPE=Release ..
RUN make
RUN make install

## RaGOO
RUN cd /opt
RUN git clone https://github.com/malonge/RaGOO.git
RUN cd RaGOO
RUN python3 setup.py install

## Assembly-Stats
RUN cd /opt
RUN git clone https://github.com/sanger-pathogens/assembly-stats.git
RUN cd assembly-stats
RUN mkdir build
RUN cd build
RUN cmake ..
RUN make
RUN make install


