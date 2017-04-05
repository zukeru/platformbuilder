
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
          sh '''
          		./terraform apply .
          		./terraform show 
          	 '''
        }s
      }

	}
}
