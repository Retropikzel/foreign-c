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
        stage('Chicken') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-chicken'
                }
            }
        }
        stage('Guile') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-guile'
                }
            }
        }
        stage('Kawa') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-kawa'
                }
            }
        }
        stage('Sagittarius') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-sagittarius'
                }
            }
        }
        stage('Racket') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-racket'
                }
            }
        }
        stage('Cyclone') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-cyclone'
                }
            }
        }
        stage('Gambit') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-gambit'
                }
            }
        }
        stage('STklos') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-stklos'
                }
            }
        }
    }

}
