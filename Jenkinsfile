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
            environment {
                COMPILE_R7RS='chibi chicken gauche guile kawa mosh racket sagittarius stklos ypsilon'
            }
            steps {
                sh "test-r7rs test.scm"
            }
        }
    }
}
