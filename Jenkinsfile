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
          		./terraform destroy --force -state=/tmp/terraform.tfstate services/.
          		./terraform apply -state=/tmp/terraform.tfstate -refresh=true services/.
          		ls -lah
          		ls -lah services/
          		./terraform show /tmp/terraform.tfstate
          '''
        }
      }

	}
}
