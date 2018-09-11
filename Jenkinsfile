pipeline {
    agent {
        docker {
            image 'maven:3-alpine'
            args '-v /var/run/docker.sock:/var/run/docker.sock -v /home/jenkins:/home/jenkins -v /home/jenkins/.dockercfg:/home/jenkins/.dockercfg'
        }
    }
    stages {
        stage('Build') {
            steps {
                sh 'prover=$(mvn -q -N -Dexec.executable="echo"  -Dexec.args="${project.version}"  org.codehaus.mojo:exec-maven-plugin:1.3.1:exec)'
				sh 'proname=$(mvn -q -N -Dexec.executable="echo"  -Dexec.args="${project.artifactId}"  org.codehaus.mojo:exec-maven-plugin:1.3.1:exec)'
				sh 'mvn package docker:build -Dmaven.test.skip=true'
                sh 'docker push huxiaofeng/eureka-server:0.0.1-SNAPSHOT'
            }
        }
    }
}