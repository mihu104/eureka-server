pipeline {
    agent none
    stages {
        stage('Build') {
		agent {
        docker {
            image 'huxiaofeng/maven:1.2'
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
		options { timeout(time: 10, unit: 'SECONDS')}
	
       
	   agent {label 'deploy-slave'}
        options { skipDefaultCheckout() }

            steps {
				script {
input "确认要部署到测试环境吗？"
}				
				sh "docker pull huxiaofeng/${proname}:${prover}"
				sh "docker run -d --name ${proname} -p 8761:8761 huxiaofeng/${proname}:${prover}"
				
            }
        
		}
		
    }
	
}