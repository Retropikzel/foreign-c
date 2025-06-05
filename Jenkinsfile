def tests = ['primitives']

pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile.jenkins'
            args '--user=root -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

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
