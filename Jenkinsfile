pipeline {
    agent any
    stages {
        stage('Test amd64') {
            steps {
                sh 'make test-amd64-wine'
            }
        }
        stage('Test amd64 wine') {
            steps {
                sh 'make test-amd64-wine'
            }
        }
        stage('Test arm64') {
            steps {
                sh 'make test-arm64'
            }
        }
    }
}
