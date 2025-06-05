def tests = ['primitives', 'addressof', 'callback']

pipeline {
    agent any

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('chibi') {
            agent {
                dockerfile {
                    filename 'Dockerfile.test'
                        args '--user=root'
                        additionalBuildArgs "--build-arg COMPILE_R7RS=${STAGE_NAME}"
                }
            }
            steps {
                script {
                    tests.each { test ->
                        stage("${STAGE_NAME} ${test}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make test-compile-r7rs COMPILE_R7RS=${ṢTAGE_NAME} TESTNAME=${test}"
                            }
                        }
                    }
                }
            }
        }
    }
}
