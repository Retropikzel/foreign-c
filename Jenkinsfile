def implementations = ['chibi', 'sagittarius']
def tests = ['primitives']

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
                        stage("${implementation} primitives") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "docker build --build-arg COMPILE_R7RS=${implementation} --tag=r7rs-pffi-test-${implementation} -f Dockerfile.test ."
                                sh "docker run --user=root -v ${WORKSPACE}:/workdir -w /workdir -t r7rs-pffi-test-${implementation} sh -c \"make COMPILE_R7RS=${implementation} TESTNAME=primitives test-compile-r7rs\""
                            }
                        }
                    }
                }
            }
        }
    }
}
