pipeline {
    agent any

    triggers {
      pollSCM("")
    }

    parameters {
      string(name: 'PHASE', defaultValue: 'DEPLOY', description: 'Build Stage to Execute')
    }
    
    stages {
      stage('Initialization') {
        steps {
          sh 'env | sort'
          withCredentials([usernamePassword(
                credentialsId: 'awsplatkeys', passwordVariable: 'aws_secret_key', usernameVariable: 'aws_access_key')]) {
                sh '''
                	sed -i -e "s:env_aws_access_key:$aws_access_key:" -e "s:env_aws_secret_key:$aws_secret_key:" services/variables.tf
                '''
                }          	  
            }
        }

      stage ('Deploy: Master') {
        when {
          expression { return "${params.PHASE}" =~ /.*DEPLOY/ }
        }
        steps {
          branch "master"
          sh '''
          		#!/bin/bash

          		unzip terraform.zip
          		./terraform destroy --force
          		./terraform apply services/.
          		ls -lah
          		ls -lah services/
          		./terraform show
          		git add .
          		git commit -m "updated the platform state"
          		git push -u origin master
          '''
        }
      }

	}
}
