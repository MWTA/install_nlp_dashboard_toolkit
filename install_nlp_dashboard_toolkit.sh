#!/bin/sh

# Maintainer: RodriguesFAS <franciscosouzaacer@gmail.com>
# Description: WebServer
# Date: 16/01/2019


############################################### STAP 01
echo "Update Package.."
sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get clean -y



############################################### STAP 02
echo "Install Dependencies.."

echo "Install Lang"
sudo apt-get install language-pack-ru-base -y && locale-gen en_US en_US.UTF-8

echo "Install Java 8"
sudo apt-get install -y  software-properties-common && add-apt-repository ppa:webupd8team/java -y && sudo apt-get update && echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && sudo apt-get install -y oracle-java8-installer && sudo apt-get clean -y

echo "Install Unzip.."
sudo apt-get install unzip -y && sudo apt-get clean -y

echo "Install pip"
apt install python-pip -y

echo "Install Git"
apt install git -y



############################################### STAP 
echo "Creating a directory to save external nlp tools.."
mkdir -p ~/tool-nlp



############################################### STAP
echo "Install Dependencies FreeLing.."
sudo apt-get install build-essential -y && sudo apt-get install cmake -y && sudo apt-get install swig -y && sudo apt-get install libboost-all-dev -y && sudo apt-get install libicu-dev -y && sudo apt-get install zlib1g-dev -y && sudo apt-get clean -y

cd tool-nlp

echo "Download FreeLing.."
wget https://github.com/TALP-UPC/FreeLing/releases/download/4.1/FreeLing-4.1.tar.gz

echo "Uncompressed file FreeLing.."
tar -vzxf FreeLing-4.1.tar.gz

echo "Install FreeLing.."
cd FreeLing-4.1 && mkdir build && cd build && cmake .. -DPYTHON2_API=ON && make -j 4 install
cd ~ && rm FreeLing-4.1.tar.gz


############################################### STAP
echo "Download Stanford CoreNLP.."
cd ~ && cd tool-nlp && wget http://nlp.stanford.edu/software/stanford-corenlp-full-2018-10-05.zip && \

echo "Uncompressed file Stanford CoreNLP.."
unzip stanford-corenlp-full-2018-10-05.zip



############################################### STAP
echo "Download SEMAFOR.."
wget https://github.com/Noahs-ARK/semafor/archive/master.zip

echo "Uncompressed SEMAFOR.."
unzip master && mv semafor-master semafor

echo "Config SEMAFOR.."
cd semafor/bin
echo '#!/bin/sh\
        export BASE_DIR="/home/tool-nlp" export SEMAFOR_HOME="${BASE_DIR}/semafor" export CLASSPATH=".:${SEMAFOR_HOME}/target/Semafor-3.0-alpha-04.jar" export JAVA_HOME_BIN="/usr/lib/jvm/java-8-oracle/bin" export TURBO_MODEL_DIR="{BASE_DIR}/semafor/models/turbo_20130606" echo "Environment variables:" echo "SEMAFOR_HOME=${SEMAFOR_HOME}" echo "CLASSPATH=${CLASSPATH}" echo "JAVA_HOME_BIN=${JAVA_HOME_BIN}" echo "MALT_MODEL_DIR=${MALT_MODEL_DIR}" ' >> config.sh



############################################### STAP
echo "Install Dependencies Python Project Requirements.."
pip install spacy && python -m spacy download en && pip install pathlib && pip install xmlformatter && pip install flask_socketio && pip install nltk && python -c "import nltk; nltk.download('all')" && pip install stanfordcorenlp && pip install spacy && pip install supwsd



############################################### STAP
echo "Clean Install.."
sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get clean -y



############################################### STAP
echo "Download NLP DashBoard ToolKit.."
mkdir -p ~/dash-nlp && cd dash-nlp
git clone https://RodriguesFAS@bitbucket.org/RodriguesFAS/dash-cnlp.git


############################################### STAP
echo "Install Completed!"



############################################### STAP
echo "Run WebServer"
cd dash-nlp
python run_server.py
echo "http://127.0.0.1:5000"


