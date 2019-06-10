#/bin/bash

apt-get update

#Descargar Java

## Descomprimir java

mkdir -p /usr/lib/jvm

wget http://185.8.245.158/jdk-8u211-linux-x64.tar.gz

cp jdk-8u211-linux-x64.tar.gz /usr/lib/jvm/

tar xvzf /usr/lib/jvm/jdk-8u211-linux-x64.tar.gz

#cp -r jdk1.8.0_211 /usr/lib/jvm/

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

#scp frodo@vivasgonzalez.ddns.net:/home/frodo/ELK/elastic/elasticsearch.yml /etc/elasticsearch/.

cp /elastic/elasticsearch.yml /etc/elasticsearch/.

sleep 2

systemctl start elasticsearch && echo "Iniciando el servicio de Elastic"

sleep 2

systemctl enable elasticsearch && echo "Configurando el servicio para que arranque con el sistema"

sleep 2

echo "Comprobacion de elastic"

sleep 1

curl localhost:9200

sleep 1

## Instalación Kibana

echo "Instalacion Kibana"

sleep 2

apt-get install kibana -y

systemctl enable kibana && echo "Activando el servicio en el arranque"

sleep 2

systemclt start kibana && echo "Iniciando el servicio"

sleep 1

## Instalación nginx

echo "Instalacion Nginx"

sleep 2

apt-get install nginx apache2-utils -y

htpasswd -c /etc/nginx/htpasswd.kibana kibanaadmin

#scp frodo@vivasgonzalez.ddns.net:/home/frodo/ELK/nginx/default /etc/nginx/sites-enabled/default

cp /nginx/default /etc/nginx/sites-enabled/default

nginx -t

echo "Comprobacion de la sintaxis de Nginx"

sleep 2

echo "Reinicio Nginx"

systemctl restart nginx

## Instalacion Logstash

echo "Instalacion de Logstash"

apt-get install logstash -y

#scp frodo@vivasgonzalez.ddns.net:/home/frodo/ELK/logstash/* /etc/logstash/conf.d/.

sleep 2

echo "Copiando archivos de configuracion de ejemplo para monitorizar logs"

echo "- Archivos para logs de Failtoban"

echo "- Archivos para logs de Nginx/Apache"

cp /logstash/* /etc/logstash/conf.d/.


