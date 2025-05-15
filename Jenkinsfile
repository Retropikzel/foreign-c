pipeline {
    agent any

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('Chibi primitives') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=chibi' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=chibi TESTNAME=primitives' } }
        }
        stage('Chibi addressof') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=chibi' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=chibi TESTNAME=addressof' } }
        }
        stage('Chibi callback') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=chibi' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=chibi TESTNAME=callback' } }
        }
        stage('Chicken primitives') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=chicken' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=chicken TESTNAME=primitives' } }
        }
        stage('Chicken addressof') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=chicken' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=chicken TESTNAME=addressof' } }
        }
        stage('Chicken callback') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=chicken' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=chicken TESTNAME=callback' } }
        }
    }
}
