pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile.jenkins'
            label 'docker-x86_64'
            args '--user=root --privileged -v /var/run/docker.sock:/var/run/docker.sock'
            reuseNode true
        }
    }

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    parameters {
        string(name: 'R6RS_SCHEMES', defaultValue: 'chezscheme ikarus ironscheme racket sagittarius ypsilon', description: '')
        string(name: 'R7RS_SCHEMES', defaultValue: 'chibi chicken kawa mosh racket sagittarius stklos ypsilon', description: '')
    }

    stages {
        stage('Test R6RS Debian') {
            steps {
                script {
                    params.R6RS_SCHEMES.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make RNRS=r6rs SCHEME=${SCHEME} test-docker"
                            }
                        }
                    }
                }
            }
        }
        stage('Test R6RS Alpine') {
            steps {
                script {
                    params.R6RS_SCHEMES.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make LINUX=alpine RNRS=r6rs SCHEME=${SCHEME} test-docker"
                            }
                        }
                    }
                }
            }
        }
        stage('Test R7RS Debian') {
            steps {
                script {
                    params.R7RS_SCHEMES.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make RNRS=r7rs SCHEME=${SCHEME} test-docker"
                            }
                        }
                    }
                }
            }
        }
        stage('Test R7RS Alpine') {
            steps {
                script {
                    params.R7RS_SCHEMES.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make LINUX=alpine RNRS=r7rs SCHEME=${SCHEME} test-docker"
                            }
                        }
                    }
                }
            }
        }
    }
}
