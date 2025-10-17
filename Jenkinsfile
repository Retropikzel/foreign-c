pipeline {
    agent {
        docker {
            label 'docker-x86_64'
            image 'retropikzel1/compile-r7rs'
            args '--user=root --privileged -v /var/run/docker.socket:/var/run/docker.socket'
        }
    }

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    parameters {
        //string(name: 'SCHEMES', defaultValue: 'chibi chicken gauche kawa racket sagittarius stklos', description: '')
        string(name: 'SCHEMES', defaultValue: 'sagittarius', description: '')
    }

    stages {
        stage('Build compile-r7rs') {
            docker {
                image "schemers/chicken:5"
                label "docker-x86_64"
            }
            steps {
                sh "git clone https://gitea.scheme.org/Retropikzel/compile-r7rs.git"
                dir("compile-r7rs") {
                    sh "make build-chicken"
                }
            }
        }

        stage('Tests x86_64 Debian') {
            steps {
                script {
                    params.SCHEMES.split().each { SCHEME ->
                        def IMG="${SCHEME}:head"
                        if("${SCHEME}" == "chicken") {
                            IMG="${SCHEME}:5"
                        }
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make SCHEME=${SCHEME} test-in-docker"
                            }
                        }
                    }
                }
            }
        }

    }
}
