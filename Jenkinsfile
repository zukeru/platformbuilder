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
                	sed -i 's/env_aws_access_key/'"$aws_access_key"'/g'  variables.tf
                	sed -i 's/env_aws_secret_key/'"$aws_secret_key"'/g'  variables.tf
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
          		wget https://releases.hashicorp.com/terraform/0.9.2/terraform_0.9.2_linux_amd64.zip?_ga=1.190863784.385426000.1490466951
          		unzip -f terraform_0.9.2_linux_amd64.zip?_ga=1.190863784.385426000.1490466951
          		ls -lah

				original_str=env_aws_access_key
				replace_str="$aws_access_key"
				sed "s~$original_str~$replace_str~" variables.tf 
				
				original_str=env_aws_secret_key
				replace_str="$aws_secret_key"
				sed "s~$original_str~$replace_str~" variables.tf 				
				
                 		
          		./terraform apply .
          		./terraform showaa
          '''
        }
      }

	}
}
