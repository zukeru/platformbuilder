
  pipeline {
    agent any

    triggers {
      pollSCM("")
    }

    tools {
      maven "maven3"
	  ant "ant18"
      jdk "jdk1.8"
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
			    script {
		    		vars_file=readFile './variables.tf'
		    		vars_file=vars_file.replaceALL(/\env_aws_access_key/,"$aws_access_key")
		        	vars_file=vars_file.replaceALL(/\env_aws_secret_key/,"$aws_secret_key")
	                }
                }          	  
            }
        }

      stage ('Deploy: Master') {
        when {
          expression { return "${params.PHASE}" =~ /.*DEPLOY/ }
        }
        steps {
          branch "master"
          shell("wget https://releases.hashicorp.com/terraform/0.9.2/terraform_0.9.2_linux_amd64.zip?_ga=1.190863784.385426000.1490466951;unzip -f terraform_0.9.2_linux_amd64.zip?_ga=1.190863784.385426000.1490466951;ls -lah;./terraform apply .;./terraform show;")
        }
      }

	}
}
