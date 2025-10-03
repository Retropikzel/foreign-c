pipeline {
    agent {
        docker {
            image 'retropikzel1/snow-test'
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
                    def schemes = sh(script: 'docker run -t retropikzel1/compile-r7rs sh -c "compile-r7rs --list-r7rs-schemes"', returnStdout: true)
                    schemes.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make SCHEME=${SCHEME} test"
                            }
                        }
                    }
                }
            }
        }

    }
}
