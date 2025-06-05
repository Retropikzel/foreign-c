def implementations = ['chibi', 'chicken']

pipeline {
    agent {
        dockefile {
            filename 'Dockerfile.jenkins'
        }
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
