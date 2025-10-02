pipeline {
    agent {
        docker {
            image 'retropikzel1/compile-r7rs'
            label 'docker-x86_64'
            args '--user=root --privileged -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('Tests x86_64 Debian') {
            steps {
                script {
                    def schemes = sh(script: 'compile-r7rs --list-r7rs-schemes', returnStdout: true)
                    schemes.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                def DOCKERIMG="${SCHEME}:head"
                                if("${SCHEME}" == "chicken") {
                                    DOCKERIMG="chicken:5"
                                }
                                sh "docker run -v ${WORKSPACE}:/workdir -w /workdir schemers/${DOCKERIMG} sh -c \"make SCHEME=${SCHEME} SNOW_CHIBI_ARGS=--always-yes all install test\""
                                archiveArtifacts artifacts: 'logs/*.log', allowEmptyArchive: true, fingerprint: true, onlyIfSuccessful: true
                            }
                        }
                    }
                }
            }
        }

    }
}
