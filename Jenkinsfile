def implementations = ['chibi', 'chicken']

pipeline {
    agent any
    stages {
        stage('Testing') {
            steps {
                script {
                    implementations.each { implementation ->
                        stage("Test ${implementation} primitives") {
                            agent {
                                dockerfile {
                                    filename 'Dockerfile.test'
                                    args '--user=root'
                                    additionalBuildArgs '--build-arg COMPILE_R7RS=${implementation}'
                                }
                            }
                            steps {
                                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                    sh 'make test-compile-r7rs COMPILE_R7RS=chibi TESTNAME=primitives'
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
