#/bin/bash

apt-get update

#Descargar Java

## Descomprimir java

mkdir -p /usr/lib/jvm

scp frodo@192.168.8.130:/home/frodo/jdk-8u211-linux-x64.tar.gz .

tar xvzf jdk-8u211-linux-x64.tar.gz

cp -r jdk1.8.0_211 /usr/lib/jvm/

update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0_211/bin/java 4

update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.8.0_211/bin/javac 4

update-alternatives --config java




## Repositorios
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list

apt-get update

echo "Instalacion Elasticsearch"

sleep 3

apt-get install elasticsearch -y

scp frodo@vivasgonzalez.ddns.net:/home/frodo/ELK/elastic/elasticsearch.yml /etc/elasticsearch/.

#nano /etc/elasticsearch/elasticsearch.yml

systemctl start elasticsearch

systemctl enable elasticsearch

curl localhost:9200

sleep 5

## Instalación Kibana

echo "Instalacion Kibana"

sleep 3

apt-get install kibana -y

systemctl enable kibana

systemclt start kibana

## Instalación nginx

echo "Instalacion Nginx"

sleep 3

apt-get install nginx apache2-utils -y

htpasswd -c /etc/nginx/htpasswd.kibana kibanaadmin

scp frodo@vivasgonzalez.ddns.net:/home/frodo/ELK/nginx/default /etc/nginx/sites-enabled/default

nginx -t

sleep 2

echo "Reinicio Nginx"

systemctl restart nginx

## Instalacion Logstash

apt-get install logstash -y

scp frodo@vivasgonzalez.ddns.net:/home/frodo/ELK/logstash/* /etc/logstash/conf.d/.


