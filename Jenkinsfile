def tests = ['primitives', 'addressof', 'callback']

pipeline {
    agent any

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('Tests') {
            steps {
                script {
                    def implementations = sh(script: 'docker run retropikzel1/compile-r7rs:chibi sh -c "compile-r7rs --list-r7rs-schemes"', returnStdout: true).split()

                    implementations.each { implementation->
                        tests.each { test ->
                            stage("${implementation} ${test}") {
                                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                    sh "timeout 600 docker build --build-arg COMPILE_R7RS=${implementation} --tag=r7rs-pffi-test-${implementation} -f dockerfiles/Dockerfile.test ."
                                    sh "timeout 600 docker run -v ${WORKSPACE}:/workdir -w /workdir -t r7rs-pffi-test-${implementation} sh -c \"make SCHEME=${implementation} TEST=${test} clean test\""
                                }
                            }
                        }
                    }
                }
            }
        }
        stage('snow-chibi install tests') {
            steps {
                script {
                    def implementations = sh(script: 'docker run retropikzel1/compile-r7rs:chibi sh -c "compile-r7rs --list-r7rs-schemes"', returnStdout: true).split()

                    implementations.each { implementation->
                        stage("${implementation} snow-chibi install test") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "timeout 600 docker build --build-arg SCHEME=${implementation} --tag=r7rs-pffi-test-${implementation} -f dockerfiles/Dockerfile.snow-chibi-install-test ."
                                sh "timeout 600 docker run -v ${WORKSPACE}:/workdir -w /workdir -t r7rs-pffi-test-${implementation} sh -c \"make build install-jenkins SCHEME=${implementation} && cp tests/hello.scm /tmp/ && cd /tmp && SCHEME=${implementation} compile-r7rs -o hello hello.scm && ./hello\""
                            }
                        }
                    }
                }
            }
        }
    }
}
