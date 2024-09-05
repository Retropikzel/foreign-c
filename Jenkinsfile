pipeline {
    agent any
    stages {
        stage('Tier 1 - Chicken') {
            steps {
                sh 'make test-chicken'
            }
        }
        stage('Tier 1 - Guile') {
            steps {
                sh 'make test-guile'
            }
        }
        stage('Tier 1 - Kawa') {
            steps {
                sh 'make test-kawa'
            }
        }
        stage('Tier 1 - Sagittarius') {
            steps {
                sh 'make test-sagittarius'
            }
        }
        stage('Tier 1 - Racket') {
            steps {
                sh 'make test-racket'
            }
        }
        stage('Tier 2 - Cyclone') {
            steps {
                sh 'make test-cyclone'
            }
        }
        stage('Tier 2 - Gambit') {
            steps {
                sh 'make test-gambit'
            }
        }
        stage('Tier 2 - STklos') {
            steps {
                sh 'make test-stklos'
            }
        }
    }

}
