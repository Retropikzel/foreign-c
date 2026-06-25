pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile.jenkins'
            label 'docker-x86_64'
            args '--user=root --privileged -v /var/run/docker.sock:/var/run/docker.sock'
            reuseNode true
        }
    }

    triggers {
        GenericTrigger(
         genericVariables: [
          [key: 'ref', value: '$.ref']
         ],

         causeString: 'Triggered on $ref',

         printContributedVariables: true,
         printPostContent: true,

         silentResponse: false,
         shouldNotFlatten: false,

         regexpFilterText: '$ref',
         regexpFilterExpression: 'refs/heads/' + BRANCH_NAME
        )
      }

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
    }

    stages {
        stage('Main R6RS Debian') {
            steps {
                script {
                    def schemes = readFile 'tests/test_main_r6rs.txt'
                    schemes.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make RNRS=r6rs SCHEME=${SCHEME} test-docker"
                            }
                        }
                    }
                }
            }
        }
        stage('Callback R6RS Debian') {
            steps {
                script {
                    def schemes = readFile 'tests/test_callback_r6rs.txt'
                    schemes.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make RNRS=r6rs SCHEME=${SCHEME} TEST=callback test-docker"
                            }
                        }
                    }
                }
            }
        }
        stage('Main R7RS Debian') {
            steps {
                script {
                    def schemes = readFile 'tests/test_main_r7rs.txt'
                    params.R7RS_SCHEMES.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make RNRS=r7rs SCHEME=${SCHEME} test-docker"
                            }
                        }
                    }
                }
            }
        }
        stage('Callback R7RS Debian') {
            steps {
                script {
                    def schemes = readFile 'tests/test_callback_r7rs.txt'
                    params.R7RS_SCHEMES.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make RNRS=r7rs SCHEME=${SCHEME} TEST=callback test-docker"
                            }
                        }
                    }
                }
            }
        }
        stage('Main R6RS Alpine') {
            steps {
                script {
                    def schemes = readFile 'tests/test_main_r6rs.txt'
                    schemes.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make LINUX=alpine RNRS=r6rs SCHEME=${SCHEME} test-docker"
                            }
                        }
                    }
                }
            }
        }
        stage('Callback R6RS Alpine') {
            steps {
                script {
                    def schemes = readFile 'tests/test_main_r6rs.txt'
                    schemes.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make LINUX=alpine RNRS=r6rs SCHEME=${SCHEME} TEST=callback test-docker"
                            }
                        }
                    }
                }
            }
        }
        stage('Main R7RS Alpine') {
            steps {
                script {
                    def schemes = readFile 'tests/test_main_r7rs.txt'
                    schemes.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make LINUX=alpine RNRS=r7rs SCHEME=${SCHEME} test-docker"
                            }
                        }
                    }
                }
            }
        }
        stage('Callback R7RS Alpine') {
            steps {
                script {
                    def schemes = readFile 'tests/test_main_r7rs.txt'
                    schemes.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make LINUX=alpine RNRS=r7rs SCHEME=${SCHEME} TEST=callback test-docker"
                            }
                        }
                    }
                }
            }
        }
    }
}
