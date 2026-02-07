pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile.jenkins'
            label 'docker-x86_64'
            args '--user=root --privileged -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    parameters {
        string(name: 'RNRS', defaultValue: 'r6rs r7rs', description: '')
        string(name: 'SCHEMES', defaultValue: 'chezscheme guile ikarus ironscheme mosh racket sagittarius', description: '')
    }

    stages {
        stage('Tests') {
            steps {
                script {
                    params.RNRS.split().each { RNRS ->
                        params.SCHEMES.split().each { SCHEME ->
                            stage("${RNRS} ${SCHEME}") {
                                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                    sh "make RNRS=${RNRS} SCHEME=${SCHEME} run-test-docker"
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
