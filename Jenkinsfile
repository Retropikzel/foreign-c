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
                    sh 'make test-chibi-docker-jenkins-jenkins'
                }
            }
        }
        stage('Chicken-5') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-chicken-5-docker-jenkins'
                }
            }
        }
        stage('Cyclone') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-cyclone-docker-jenkins'
                }
            }
        }
        stage('Gambit') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-gambit-docker-jenkins'
                }
            }
        }
        stage('Guile') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-guile-docker-jenkins'
                }
            }
        }
        stage('Sagittarius') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-sagittarius-docker-jenkins'
                }
            }
        }
        stage('Racket') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-racket-docker-jenkins'
                }
            }
        }
        stage('Kawa') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-kawa-docker-jenkins'
                }
            }
        }
        stage('STklos') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-stklos-docker-jenkins'
                }
            }
        }
    }

}
