pipeline {
    agent none
    stages {
	    stage('checkout') {
		 agent {label 'maven-slave'}
		steps {
        echo "1.下载代码"
        checkout scm
		  }
		  }
        stage('Build') {
		agent {
        docker {
            image 'huxiaofeng/maven:1.2'
            args '-v /var/run/docker.sock:/var/run/docker.sock -v /home/jenkins:/home/jenkins -v /home/jenkins/.dockercfg:/home/jenkins/.dockercfg'
        }
    }
            steps {
				sh "cd code && mvn package docker:build -Dmaven.test.skip=true"
				script {
				prover=sh(returnStdout: true, script: "cd code && mvn -q -N -Dexec.executable='echo'  -Dexec.args='\${project.version}'  org.codehaus.mojo:exec-maven-plugin:1.3.1:exec").trim()
      		    proname=sh(returnStdout: true, script: "cd code && mvn -q -N -Dexec.executable='echo'  -Dexec.args='\${project.artifactId}'  org.codehaus.mojo:exec-maven-plugin:1.3.1:exec").trim()

	             }
                sh "docker push huxiaofeng/${proname}:${prover}"
				
            }
        }
		stage('deploy') {
	   agent {label 'deploy-slave'}
	
            steps {
				sh "docker pull huxiaofeng/${proname}:${prover}"
				sh "docker run -d huxiaofeng/${proname}:${prover}"
				
            }
        
		}
		
    }
	
}