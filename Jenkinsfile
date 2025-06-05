def tests = ['primitives', 'addressof', 'callback']

pipeline {
    agent any

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('chibi') {
            environment {
                IMPLEMENTATION="${STAGE_NAME}"
            }
            steps {
                script {
                    tests.each { test ->
                        stage("${STAGE_NAME} ${test}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "docker build --build-arg COMPILE_R7RS=${env.IMPLEMENTATION} --tag=r7rs-pffi-test-${env.IMPLEMENTATION} -f Dockerfile.test ."
                                sh "docker run -v ${WORKSPACE}:/workdir -w /workdir -t r7rs-pffi-test-${env.IMPLEMENTATION} sh -c \"make COMPILE_R7RS=${env.IMPLEMENTATION} TESTNAME=primitives test-compile-r7rs\""
                            }
                        }
                    }
                }
            }
        }
    }
}
