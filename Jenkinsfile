pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile.jenkins'
            label 'docker-x86_64'
            args '--user=root --privileged -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    parameters {
        string(name: 'R6RS_SCHEMES', defaultValue: 'chezscheme guile ikarus ironscheme mosh racket sagittarius ypsilon', description: '')
        string(name: 'R7RS_SCHEMES', defaultValue: 'chibi chicken guile kawa mosh racket sagittarius stklos ypsilon', description: '')
    }

    stages {
        stage('Test R6RS') {
            steps {
                script {
                    params.R6RS_SCHEMES.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make RNRS=${RNRS} SCHEME=${SCHEME} run-test-docker"
                            }
                        }
                    }
                }
            }
        }
        stage('Test R7RS') {
            steps {
                script {
                    params.R7RS_SCHEMES.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make RNRS=${RNRS} SCHEME=${SCHEME} run-test-docker"
                            }
                        }
                    }
                }
            }
        }
    }
}
