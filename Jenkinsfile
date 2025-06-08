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
                                    sh "docker build --build-arg COMPILE_R7RS=${implementation} --tag=r7rs-pffi-test-${implementation} -f Dockerfile.test ."
                                    sh "docker run -v ${WORKSPACE}:/workdir -w /workdir -t r7rs-pffi-test-${implementation} sh -c \"make COMPILE_R7RS=${implementation} TESTNAME=primitives test-compile-r7rs\""
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
