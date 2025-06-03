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

        stage('Gauche primitives') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=gauche' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=gauche TESTNAME=primitives' } }
        }
        stage('Gauche addressof') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=gauche' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=gauche TESTNAME=addressof' } }
        }
        stage('Gauche callback') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=gauche' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=gauche TESTNAME=callback' } }
        }

        stage('Guile primitives') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=guile' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=guile TESTNAME=primitives' } }
        }
        stage('Guile addressof') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=guile' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=guile TESTNAME=addressof' } }
        }
        stage('Guile callback') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=guile' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=guile TESTNAME=callback' } }
        }

        stage('Kawa primitives') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=kawa' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=kawa TESTNAME=primitives' } }
        }
        stage('Kawa addressof') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=kawa' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=kawa TESTNAME=addressof' } }
        }
        stage('Kawa callback') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=kawa' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=kawa TESTNAME=callback' } }
        }

        stage('Mosh primitives') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=mosh' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=mosh TESTNAME=primitives' } }
        }
        stage('Mosh addressof') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=mosh' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=mosh TESTNAME=addressof' } }
        }
        stage('Mosh callback') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=mosh' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=mosh TESTNAME=callback' } }
        }

        stage('Racket primitives') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=racket' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=racket TESTNAME=primitives' } }
        }
        stage('Racket addressof') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=racket' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=racket TESTNAME=addressof' } }
        }
        stage('Racket callback') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=racket' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=racket TESTNAME=callback' } }
        }

        stage('Sagittarius primitives') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=sagittarius' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=sagittarius TESTNAME=primitives' } }
        }
        stage('Sagittarius addressof') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=sagittarius' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=sagittarius TESTNAME=addressof' } }
        }
        stage('Sagittarius callback') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=sagittarius' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=sagittarius TESTNAME=callback' } }
        }

        stage('STklos primitives') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=stklos' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=stklos TESTNAME=primitives' } }
        }
        stage('STklos addressof') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=stklos' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=stklos TESTNAME=addressof' } }
        }
        stage('STklos callback') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=stklos' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=stklos TESTNAME=callback' } }
        }

        stage('Ypsilon primitives') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=ypsilon' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=ypsilon TESTNAME=primitives' } }
        }
        stage('Ypsilon addressof') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=ypsilon' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=ypsilon TESTNAME=addressof' } }
        }
        stage('Ypsilon callback') {
            agent { dockerfile { filename 'Dockerfile.test'; additionalBuildArgs '--build-arg COMPILE_R7RS=ypsilon' } }
            steps { catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') { sh 'make test-compile-r7rs COMPILE_R7RS=ypsilon TESTNAME=callback' } }
        }

    }
}
