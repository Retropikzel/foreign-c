pipeline {
    agent any

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('Chibi primitives') {
            environment { SCHEME="chibi" }
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=${env.SCHEME}' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=${env.SCHEME} TESTNAME=primitives' } }
        }
        stage('Chibi addressof') {
            environment { SCHEME="chibi" }
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=${env.SCHEME}' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=${env.SCHEME} TESTNAME=addressof' } }
        }
        stage('Chibi callback') {
            environment { SCHEME="chibi" }
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=${env.SCHEME}' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=${env.SCHEME} TESTNAME=callback' } }
        }
    }
}
