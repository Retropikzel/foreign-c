pipeline {
    agent any

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('Chibi primitives') {
            environment {
                COMPILE_R7RS = "chibi"
                TESTNAME = "primitives"
            }
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'docker build --build-arg COMPILE_R7RS=${COMPILE_R7RS} --tag=r7rs-pffi-test-${COMPILE_R7RS} -f dockerfiles/test .'
                    sh 'docker run -v "${PWD}":/workdir -w /workdir -t r7rs-pffi-test-${COMPILE_R7RS} sh -c "make COMPILE_R7RS=${COMPILE_R7RS} test-compile-r7rs"'
                }
            }
        }
        stage('Chibi addressof') {
            environment {
                COMPILE_R7RS = "chibi"
                TESTNAME = "addressof"
            }
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'docker build --build-arg COMPILE_R7RS=${COMPILE_R7RS} --tag=r7rs-pffi-test-${COMPILE_R7RS} -f dockerfiles/test .'
                    sh 'docker run -v "${PWD}":/workdir -w /workdir -t r7rs-pffi-test-${COMPILE_R7RS} sh -c "make COMPILE_R7RS=${COMPILE_R7RS} test-compile-r7rs"'
                }
            }
        }
    }
}
