pipeline {
    agent any

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('Chibi primitives') {
            agent { docker { image 'schemers/chibi' } }
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'apt update && apt install -y make'
                    sh 'make test-compile-r7rs-docker COMPILE_R7RS=chibi TESTNAME=primitives'
                }
            }
        }
    }
}
