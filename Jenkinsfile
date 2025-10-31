pipeline {
    agent {
        docker {
            label 'docker-x86_64'
            image 'debian'
            args '--user=root --privileged -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    parameters {
        string(name: 'SCHEMES', defaultValue: 'chibi chicken kawa racket sagittarius stklos', description: '')
        string(name: 'R6RS_SCHEMES', defaultValue: 'guile sagittarius mosh ypsilon', description: '')
    }

    stages {
        stage('Init') {
            steps {
                sh "apt-get update && apt-get install -y make docker.io git"
            }
        }

        stage('Tests R7RS x86_64 Debian') {
            steps {
                script {
                    params.SCHEMES.split().each { SCHEME ->
                        def IMG="${SCHEME}:head"
                        if("${SCHEME}" == "chicken") {
                            IMG="${SCHEME}:5"
                        }
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make SCHEME=${SCHEME} test-docker"
                            }
                        }
                    }
                }
            }
        }

        stage('Tests R6RS x86_64 Debian') {
            steps {
                script {
                    params.R6RS_SCHEMES.split().each { SCHEME ->
                        def IMG="${SCHEME}:head"
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make SCHEME=${SCHEME} test-r6rs-docker"
                            }
                        }
                    }
                }
            }
        }

    }
}
