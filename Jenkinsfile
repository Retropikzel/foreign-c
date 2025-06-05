def implementations = [
    'chibi',
    'chicken',
    'gauche',
    'guile',
    'kawa',
    'mosh',
    'racket',
    'sagittarius',
    'stklos',
    'ypsilon'
    ]

pipeline {
    agent any

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('Testing') {
            steps {
                script {
                    implementations.each { implementation ->
                        stage("Test ${implementation} primitives") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "docker build --build-arg COMPILE_R7RS=${implementation} --tag=r7rs-pffi-test-${implementation} -f Dockerfile.test ."
                                sh "docker run -v ${PWD}:/workdir -w /workdir -t r7rs-pffi-test-${implementation} sh -c \"make COMPILE_R7RS=${implementation} TESTNAME=primitives test-compile-r7rs\""
                            }
                        }
                    }
                }
            }
        }
    }
}
