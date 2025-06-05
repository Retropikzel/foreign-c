def implementations = ['chibi']
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
        stage('Testing') {
            steps {
                script {
                    implementations.each { implementations ->
                        stage("Testing to ${implementation}") {
                            echo "Testing"
                        }
                    }
                }
            }
        }
    }
}
