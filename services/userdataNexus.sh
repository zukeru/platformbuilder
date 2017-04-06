#!/bin/bash
sudo yum update -y
sudo mkdir /app && cd /app
sudo wget https://sonatype-download.global.ssl.fastly.net/nexus/3/nexus-3.0.2-02-unix.tar.gz
sudo tar -xvf nexus-3.0.2-02-unix.tar.gz
sudo mv nexus-3.0.2-02 nexus
sudo adduser nexus
sudo chown -R nexus:nexus /app/nexus
sudo echo 'run_as_user="nexus"' >> /app/nexus/bin/nexus.rc
sudo echo "-Xms1200M" >> /app/nexus/bin/nexus.vmoptions
sudo echo "-Xmx1200M" >> /app/nexus/bin/nexus.vmoptions
sudo echo "-XX:+UnlockDiagnosticVMOptions" >> /app/nexus/bin/nexus.vmoptions
sudo echo "-XX:+UnsyncloadClass" >> /app/nexus/bin/nexus.vmoptions
sudo echo "-Djava.net.preferIPv4Stack=truer" >> /app/nexus/bin/nexus.vmoptions
sudo echo "-Dkaraf.home=." >> /app/nexus/bin/nexus.vmoptions
sudo echo "-Dkaraf.base=." >> /app/nexus/bin/nexus.vmoptions
sudo echo "-Dkaraf.etc=etc" >> /app/nexus/bin/nexus.vmoptions
sudo echo "-Djava.util.logging.config.file=etc/java.util.logging.properties" >> /app/nexus/bin/nexus.vmoptions
sudo echo "-Dkaraf.data=/app/nexus/nexus-data" >> /app/nexus/bin/nexus.vmoptions
sudo echo "-Djava.io.tmpdir=/app/nexus/data/tmp" >> /app/nexus/bin/nexus.vmoptions
sudo echo "-Dkaraf.startLocalConsole=false" >> /app/nexus/bin/nexus.vmoptions
sudo yum install java-1.8.0-openjdk.x86_64 -y
sudo ln -s /app/nexus/bin/nexus /etc/init.d/nexus
sudo chkconfig --add nexus
sudo chkconfig --levels 345 nexus on
sudo service nexus start