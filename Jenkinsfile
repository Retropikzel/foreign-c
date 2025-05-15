pipeline {
    agent any

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('Chibi primitives') {
            agent {
                dockerfile {
                    filename 'dockerfiles/test'
                    additionalBuildArgs '--build-arg COMPILE_R7RS=chibi'
                }
            }
            environment {
                COMPILE_R7RS = "chibi"
            }
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-compile-r7rs COMPILE_R7RS=chibi TESTNAME=primitives'
                }
            }
        }
    }
}
