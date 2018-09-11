pipeline {
    agent {
        docker {
            image 'huxiaofeng/maven:1.2'
            args '-v /var/run/docker.sock:/var/run/docker.sock -v /home/jenkins:/home/jenkins -v /home/jenkins/.dockercfg:/home/jenkins/.dockercfg'
        }
    }
    stages {
        stage('Build') {
            steps {
				sh "mvn package docker:build -Dmaven.test.skip=true"
                sh "chmod +x push.sh && bash push.sh"
            }
        }
    }
}