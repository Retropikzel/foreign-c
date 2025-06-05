def implementations = ['chibi', 'chicken']

pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile.jenkins'
            args '--user=root'
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
                    implementations.each { implementation ->
                        stage("Test ${implementation} primitives") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh 'make test-compile-r7rs-docker COMPILE_R7RS=chibi TESTNAME=primitives'
                            }
                        }
                    }
                }
            }
        }
    }
}
