#!/bin/bash
sudo yum update -y
sudo yum install java-1.8.0-openjdk.x86_64
sudo mkdir /app && cd /app
sudo wget https://sonatype-download.global.ssl.fastly.net/nexus/3/nexus-3.0.2-02-unix.tar.gz
sudo tar -xvf nexus-3.0.2-02-unix.tar.gz
sudo mv nexus-3.0.2-02 nexus
sudo adduser nexus
sudo chown -R nexus:nexus /app/nexus
echo 'run_as_user="nexus"' >> /app/nexus/bin/nexus.rc
echo "-Xms1200M" >> /app/nexus/bin/nexus.vmoptions
echo "-Xmx1200M" >> /app/nexus/bin/nexus.vmoptions
echo "-XX:+UnlockDiagnosticVMOptions" >> /app/nexus/bin/nexus.vmoptions
echo "-XX:+UnsyncloadClass" >> /app/nexus/bin/nexus.vmoptions
echo "-Djava.net.preferIPv4Stack=truer" >> /app/nexus/bin/nexus.vmoptions
echo "-Dkaraf.home=." >> /app/nexus/bin/nexus.vmoptions
echo "-Dkaraf.base=." >> /app/nexus/bin/nexus.vmoptions
echo "-Dkaraf.etc=etc" >> /app/nexus/bin/nexus.vmoptions
echo "-Djava.util.logging.config.file=etc/java.util.logging.properties" >> /app/nexus/bin/nexus.vmoptions
echo "-Dkaraf.data=/nexus/nexus-data" >> /app/nexus/bin/nexus.vmoptions
echo "-Djava.io.tmpdir=data/tmp" >> /app/nexus/bin/nexus.vmoptions
echo "-Dkaraf.startLocalConsole=false" >> /app/nexus/bin/nexus.vmoptions

sudo ln -s /app/nexus/bin/nexus /etc/init.d/nexus
sudo chkconfig --add nexus
sudo chkconfig --levels 345 nexus on
sudo service nexus start