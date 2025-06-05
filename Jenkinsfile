def tests = ['primitives']

pipeline {
    agent any

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('chibi') {
            steps {
                script {
                    for (int i = 0; i < tests.size(); ++i) {
                        echo "Testing the ${test[i]}"
                    }
                }
            }
        }
    }
}
