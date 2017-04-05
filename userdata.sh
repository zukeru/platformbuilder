#!/bin/bash
sudo yum install nginx -y
sudo echo "$TIMESTAMP" > /home/ec2-user/startup.log
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install jenkins -y
sudo yum remove java -y
sudo yum install java-1.7.0-openjdk-devel -y
sudo chkconfig jenkins on
sudo service jenkins start
sudo echo "THE-AUTOMATION-IS-DONE"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword > /home/ec2-user/jenkinspwd