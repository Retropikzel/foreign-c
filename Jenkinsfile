pipeline {
    agent {
        dockerfile {
            filename 'dockerfiles/jenkins'
            args '--user=root'
        }
    }

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('Chibi primitives') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-compile-r7rs-docker COMPILE_R7RS=chibi TESTNAME=primitives'
                }
            }
        }
        stage('Chibi addressof') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-compile-r7rs-docker COMPILE_R7RS=chibi TESTNAME=addressof'
                }
            }
        }
    }
}
