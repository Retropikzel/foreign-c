def implementations = [
    'chibi',
    'chicken',
    'gauche',
    'guile',
    'kawa',
    'mosh',
    'racket',
    'sagittarius',
    'stklos',
    'ypsilon'
    ]

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
                    implementations.each { implementation ->
                        stage("Test ${implementation} primitives") {
                            agent {
                                dockerfile {
                                    filename 'Dockerfile.test'
                                    additionalBuildArgs "--build-arg COMPILE_R7RS=${implementation}"
                                    args '--user=root'
                                }
                            }
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make test-compile-r7rs COMPILE_R7RS=${implementation} TESTNAME=primitives"
                            }
                        }
                    }
                }
            }
        }
    }
}
