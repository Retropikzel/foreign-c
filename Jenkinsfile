def implementations = ['chibi']
def tests = ['primitives']

pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile.jenkins'
                args '--user=root -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    options {
        disableConcurrentBuilds()
            buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('Testing') {
            steps {
                script {
                    implementations.each { implementation ->
                        stage("${implementation} primitives") {
                            sh "docker build --build-arg COMPILE_R7RS=${COMPILE_R7RS} --tag=r7rs-pffi-test-${COMPILE_R7RS} -f Dockerfile.test ."
                            sh "docker run -v ${PWD}:/workdir -w /workdir -t r7rs-pffi-test-${COMPILE_R7RS} sh -c \"make COMPILE_R7RS=${COMPILE_R7RS} TESTNAME=${TESTNAME} test-compile-r7rs\""
                        }
                    }
                }
            }
        }
    }
}
