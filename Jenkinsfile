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
                	sed -i -e "s:env_aws_access_key:$aws_access_key:" -e "s:env_aws_secret_key:$aws_secret_key:" variables.tf
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
          		ls -lah
          		unzip terraform.zip
          		cat services/variables.tf
          		services/terraform apply .
          		services/terraform show
          '''
        }
      }

	}
}
