pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile.jenkins'
            dir '.'
            args '--privileged -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }


    options {
            buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('Chibi') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make DOCKER=docker run -v ${PWD}:/workdir test-chibi-docker'
                }
            }
        }
        stage('Chicken-5') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make DOCKER=docker run -v ${PWD}:/workdir test-chicken-5-docker'
                }
            }
        }
        stage('Cyclone') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make DOCKER=docker run -v ${PWD}:/workdir test-cyclone-docker'
                }
            }
        }
        stage('Gambit') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make DOCKER=docker run -v ${PWD}:/workdir test-gambit-docker'
                }
            }
        }
        stage('Guile') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make DOCKER=docker run -v ${PWD}:/workdir test-guile-docker'
                }
            }
        }
        stage('Sagittarius') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make DOCKER=docker run -v ${PWD}:/workdir test-sagittarius-docer'
                }
            }
        }
        stage('Racket') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make DOCKER=docker run -v ${PWD}:/workdir test-racket-docker'
                }
            }
        }
        stage('Kawa') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make DOCKER=docker run -v ${PWD}:/workdir test-kawa-docker'
                }
            }
        }
        stage('STklos') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make DOCKER=docker run -v ${PWD}:/workdir test-stklos-docker'
                }
            }
        }
    }

}
