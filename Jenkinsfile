pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile.jenkins'
            dir '.'
            args '--privileged -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        DOCKER=docker run -v ${PWD}:/workdir
    }

    options {
            buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('Chibi') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-chibi-docker'
                }
            }
        }
        stage('Chicken-5') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-chicken-5-docker'
                }
            }
        }
        stage('Cyclone') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-cyclone-docker'
                }
            }
        }
        stage('Gambit') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-gambit-docker'
                }
            }
        }
        stage('Guile') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-guile-docker'
                }
            }
        }
        stage('Sagittarius') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-sagittarius-docer'
                }
            }
        }
        stage('Racket') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-racket-docker'
                }
            }
        }
        stage('Kawa') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-kawa-docker'
                }
            }
        }
        stage('STklos') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-stklos-docker'
                }
            }
        }
    }

}
