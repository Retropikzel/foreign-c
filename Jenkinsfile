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
                            sh "make test-compile-r7rs-docker COMPILE_R7RS=${implementation} TESTNAME=primitives"
                        }
                    }
                }
            }
        }
    }
}
