def tests = ['primitives']

pipeline {
    agent any

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('chibi') {
            steps {
                script {
                    tests.each { test ->
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "docker build --build-arg COMPILE_R7RS=${STAGE_NAME} --tag=r7rs-pffi-test-${STAGE_NAME} -f Dockerfile.test ."
                                sh "docker run -v ${WORKSPACE}:/workdir -w /workdir -t r7rs-pffi-test-${STAGE_NAME} sh -c \"make COMPILE_R7RS=${STAGE_NAME} TESTNAME=primitives test-compile-r7rs\""
                            }
                    }
                }
            }
        }
    }
}
