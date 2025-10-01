pipeline {
    agent {
        label 'linux'
    }

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('Tests x86_64 Debian') {
            steps {
                script {
                    def schemes = "chibi chicken gauche guile kawa mosh racket sagittarius stklos ypsilon"

                    schemes.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                def DOCKERIMG="${SCHEME}:head"
                                sh "docker build --build-arg IMAGE=${DOCKERIMG} --build-arg SCHEME=${SCHEME} --tag=foreign-c-test-${SCHEME} -f Dockerfile.test ."
                                sh "docker run -v ${WORKSPACE}:/workdir -w /workdir -t foreign-c-test-${SCHEME} sh -c \"make SCHEME=${SCHEME} SNOW_CHIBI_ARGS=--always-yes install test\""
                                archiveArtifacts artifacts: '.tmp/test/*.log', allowEmptyArchive: true, fingerprint: true, onlyIfSuccessful: true
                            }
                        }
                    }
                }
            }
        }

    }
}
