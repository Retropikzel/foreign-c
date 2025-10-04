pipeline {
    agent {
        docker {
            image 'retropikzel1/snow-test'
            label 'docker-x86_64'
            args '--user=root --privileged -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    parameters {
        string(name: 'SCHEMES', defaultValue: 'chibi chicken gauche kawa racket sagittarius stklos', description: '')
    }

    stages {
        stage('Tests x86_64 Debian') {
            steps {
                script {
                    schemes.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make SCHEME=${SCHEME} test"
                            }
                        }
                    }
                }
            }
        }

    }
}
