pipeline {
    agent {
        dockerfile {
            label 'docker-x86_64'
            filename 'Dockerfile.jenkins'
            args '--user=root --privileged -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    parameters {
        string(name: 'R6RS_SCHEMES', defaultValue: 'chezscheme guile ikarus ironscheme mosh racket sagittarius', description: '')
        string(name: 'R7RS_SCHEMES', defaultValue: 'chibi chicken gauche guile mosh racket sagittarius stklos ypsilon', description: '')
    }

    stages {
        stage('Tests') {
            parallel {
                stage('R6RS x86_64 Debian') {
                    steps {
                        script {
                            params.R6RS_SCHEMES.split().each { SCHEME ->
                                stage("${SCHEME}") {
                                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                        sh "timeout 6000 make SCHEME=${SCHEME} test-r6rs-docker"
                                    }
                                }
                            }
                        }
                    }
                }
                stage('R7RS x86_64 Debian') {
                    steps {
                        script {
                            params.R7RS_SCHEMES.split().each { SCHEME ->
                                stage("${SCHEME}") {
                                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                        sh "timeout 6000 make SCHEME=${SCHEME} test-r7rs-docker"
                                    }
                                }
                            }
                        }
                    }
                }

            }
        }

    }
}
