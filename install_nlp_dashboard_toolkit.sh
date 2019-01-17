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
sudo apt-get install language-pack-ru-base -y && sudo locale-gen en_US en_US.UTF-8

echo "Install Java 8"

# Deepin
apt-cache search openjdk && sudo apt-get install openjdk-8-jre openjdk-8-jdk && java -version && echo "JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/" >> /etc/environment && source /etc/environment && echo $JAVA_HOME

# Docker
sudo apt-get install software-properties-common && sudo add-apt-repository ppa:webupd8team/java -y && sudo apt-get update && sudo su && echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && exit && sudo apt-get install -y oracle-java8-installer



echo "Install Unzip.."
sudo apt-get install unzip -y

echo "Install pip"
sudo apt install python-pip -y

echo "Install Git"
sudo apt install git -y



############################################### STAP 
echo "Creating a directory to save external nlp tools.."
mkdir -p ~/tool-nlp



############################################### STAP
echo "Install Dependencies FreeLing.."
sudo apt-get install build-essential -y && sudo apt-get install cmake -y && sudo apt-get install swig -y && sudo apt-get install libboost-all-dev -y && sudo apt-get install libicu-dev -y && sudo apt-get install zlib1g-dev -y

cd tool-nlp

echo "Download FreeLing.."
wget https://github.com/TALP-UPC/FreeLing/releases/download/4.1/FreeLing-4.1.tar.gz

echo "Uncompressed file FreeLing.."
tar -vzxf FreeLing-4.1.tar.gz
rm -r FreeLing-4.1.tar.gz

echo "Install FreeLing.."
cd FreeLing-4.1 && mkdir build && cd build && cmake .. -DPYTHON2_API=ON && sudo make -j 4 install



############################################### STAP
echo "Download Stanford CoreNLP.."
cd ~ && cd tool-nlp && wget http://nlp.stanford.edu/software/stanford-corenlp-full-2018-10-05.zip 

echo "Uncompressed file Stanford CoreNLP.."
unzip stanford-corenlp-full-2018-10-05.zip
rm -r stanford-corenlp-full-2018-10-05.zip



############################################### STAP
echo "Download and Install Dependecies SEMAFOR.."
wget https://github.com/Noahs-ARK/semafor/archive/master.zip

echo "Uncompressed SEMAFOR.."
unzip master && mv semafor-master semafor

echo "Config SEMAFOR.."
cd semafor/bin
echo '#!/bin/sh\
        export BASE_DIR="/home/tool-nlp" export SEMAFOR_HOME="${BASE_DIR}/semafor" export CLASSPATH=".:${SEMAFOR_HOME}/target/Semafor-3.0-alpha-04.jar" export JAVA_HOME_BIN="/usr/lib/jvm/java-8-openjdk-amd64/bin" export TURBO_MODEL_DIR="{BASE_DIR}/semafor/models/turbo_20130606" echo "Environment variables:" echo "SEMAFOR_HOME=${SEMAFOR_HOME}" echo "CLASSPATH=${CLASSPATH}" echo "JAVA_HOME_BIN=${JAVA_HOME_BIN}" echo "MALT_MODEL_DIR=${MALT_MODEL_DIR}" ' >> config.sh

echo "Download Models SEMAFOR.."
cd .. && mkdir -p models && wget http://www.ark.cs.cmu.edu/SEMAFOR/semafor_malt_model_20121129.tar.gz && tar -vzxf semafor_malt_model_20121129.tar.gz && rm -r semafor_malt_model_20121129.tar.gz 

echo "install Maven.."
sudo apt install maven -y && mvn -version

echo "SEMAFOR Create Packege Maven.."
mvn package



############################################### STAP
echo "Install Dependencies Python Project Requirements.."
cd ~
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
echo "http://127.0.0.1:5000"
echo "Strop Ctrl+c"
python run_server.py
