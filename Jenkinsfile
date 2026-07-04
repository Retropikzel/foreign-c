pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile.jenkins'
            label 'docker-x86_64'
            args '-t --user=root --privileged -v /var/run/docker.sock:/var/run/docker.sock'
            additionalBuildArgs "--build-arg timestamp=${currentBuild.startTimeInMillis}"
            reuseNode true
        }
    }

    triggers {
      GenericTrigger(
        genericVariables: [[key: 'ref', value: '$.ref']],
        causeString: 'Triggered on $ref',
        printContributedVariables: true,
        printPostContent: true,
        silentResponse: false,
        shouldNotFlatten: false,
        regexpFilterText: '$ref',
        regexpFilterExpression: 'refs/heads/' + BRANCH_NAME
      )
    }

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
    }

    environment {
        R6RS_SCHEMES="capyscheme chezscheme ikarus ironscheme mosh racket sagittarius ypsilon"
        R7RS_SCHEMES="capyscheme chibi chicken gauche kawa mosh racket sagittarius stklos ypsilon"
        TESTS="main call-with-address-of callback"
        PWD="${WORKSPACE}"
    }

    stages {
        stage('Parallel') {
            parallel {
                stage('R6RS Debian') {
                    steps {
                        script {
                            env.R6RS_SCHEMES.split().each { SCHEME ->
                            stage("${SCHEME}") {
                                    env.TESTS.split().each { TEST ->
                                        stage("${TEST}") {
                                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                                sh "make RNRS=r6rs SCHEME=${SCHEME} TEST=${TEST} test-docker"
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                stage('R7RS Debian') {
                    steps {
                        script {
                            env.R7RS_SCHEMES.split().each { SCHEME ->
                                stage("${SCHEME}") {
                                    env.TESTS.split().each { TEST ->
                                        stage("${TEST}") {
                                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                                sh "make RNRS=r7rs SCHEME=${SCHEME} TEST=${TEST} test-docker"
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
