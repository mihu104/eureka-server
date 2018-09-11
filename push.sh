prover=$(mvn -q -N -Dexec.executable='echo'  -Dexec.args='${project.version}'  org.codehaus.mojo:exec-maven-plugin:1.3.1:exec)
proname=$(mvn -q -N -Dexec.executable='echo'  -Dexec.args='${project.artifactId}'  org.codehaus.mojo:exec-maven-plugin:1.3.1:exec)
sh "docker push huxiaofeng/${proname}:${prover}"