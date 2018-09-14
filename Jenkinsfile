pipeline {
    agent none
	parameters{
        booleanParam(name: 'YESORNO', defaultValue: false, description: '是否进行部署')
    }
    stages {
        stage('Build') {
		agent {
        docker {
            image 'huxiaofeng/maven:1.2'
			label 'maven-slave'
            args '-v /var/run/docker.sock:/var/run/docker.sock -v /home/jenkins:/home/jenkins -v /home/jenkins/.dockercfg:/home/jenkins/.dockercfg'
        }
    }
            steps {
				sh "mvn package docker:build -Dmaven.test.skip=true"
				script {
				prover=sh(returnStdout: true, script: "mvn -q -N -Dexec.executable='echo'  -Dexec.args='\${project.version}'  org.codehaus.mojo:exec-maven-plugin:1.3.1:exec").trim()
      		    proname=sh(returnStdout: true, script: "mvn -q -N -Dexec.executable='echo'  -Dexec.args='\${project.artifactId}'  org.codehaus.mojo:exec-maven-plugin:1.3.1:exec").trim()

	             }
                sh "docker push huxiaofeng/${proname}:${prover}"
				
            }
        }
		stage('deploy') {
	
       
	   agent {label 'deploy-slave'}
        options { skipDefaultCheckout()  }
		


            steps {
			  script {
                def input = params.YESORNO
                if (input) {			
				sh "docker pull huxiaofeng/${proname}:${prover}"
				sh " docker ps  -aq --filter name=${proname}-testnew | xargs docker rm  -f >/dev/null 2>&1 && docker run -d --name ${proname}-testnew -p 8761:8761 huxiaofeng/${proname}:${prover}"
				}
				  else {
              echo "本次提交未进行部署"
            }
			}
				
            }
        
		}
		
    }
	
}