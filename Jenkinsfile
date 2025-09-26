def tests = ['primitives', 'array', 'struct', 'addressof', 'callback']

pipeline {
    agent {
        label 'linux'
    }

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {

        stage('Tests x86_64 Debian') {
            agent {
                docker {
                    label 'docker-x86_64'
                    image 'retropikzel1/compile-r7rs'
                    args '--user=root --privileged -v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                script {
                    def schemes = "chibi chicken gauche guile kawa mosh racket sagittarius stklos ypsilon"

                    schemes.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "COMPILE_R7RS=${SCHEME} test-r7rs test.scm"
                            }
                        }
                    }
                }
            }
        }

    }
}
