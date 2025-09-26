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
                dockerfile {
                    label 'docker-x86_64'
                    filename 'Dockerfile.jenkins'
                    args '--user=root --privileged -v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                script {
                    //def implementations = sh(script: 'docker run retropikzel1/compile-r7rs sh -c "compile-r7rs --list-r7rs-schemes"', returnStdout: true).split()
                    def schemes = "chibi chicken gauche guile kawa mosh racket sagittarius stklos ypsilon".split()

                    schemes.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "test-r7s test.scm"
                            }
                        }
                    }
                }
            }
        }

    }
}
