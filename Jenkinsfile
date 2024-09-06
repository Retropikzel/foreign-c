pipeline {
    agent any

    options {
            buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('Tier 1 - Chicken') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-chicken'
                }
            }
        }
        stage('Tier 1 - Guile') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-guile'
                }
            }
        }
        stage('Tier 1 - Kawa') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-kawa'
                }
            }
        }
        stage('Tier 1 - Sagittarius') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-sagittarius'
                }
            }
        }
        stage('Tier 1 - Racket') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-racket'
                }
            }
        }
        stage('Tier 2 - Cyclone') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-cyclone'
                }
            }
        }
        stage('Tier 2 - Gambit') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-gambit'
                }
            }
        }
        stage('Tier 2 - STklos') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make test-stklos'
                }
            }
        }
    }

}
