def tests = ['primitives']

pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile.jenkins'
            args '--user=root -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('Chibi') {
            agent { dockerfile { filename 'Dockerfile.test'; args '--user=root' additionalBuildArgs "--build-arg COMPILE_R7RS=${STAGE_NAME}" } }
            steps {
                script {
                    tests.each { test ->
                        stage("Test ${ṢTAGE_NAME} primitives") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make test-compile-r7rs COMPILE_R7RS=${STAGE_NAME} TESTNAME=${test}"
                            }
                        }
                    }
                }
            }
        }
    }
}
