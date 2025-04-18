pipeline {
    agent any

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('Chibi') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make COMPILE_R7RS=chibi test-compile-r7rs-docker'
                }
            }
        }
        stage('Build Chibi libraries') {
            agent {
                dockerfile {
                    filename 'dockerfiles/build-chibi'
                }
            }
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make cbibi'
                }
            }
        }
        stage('chibi script') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=chibi test-script-docker'
                }
            }
        }
        stage('chicken script') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=chicken test-script-docker'
                }
            }
        }
        stage('guile script') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=guile test-script-docker'
                }
            }
        }
        stage('kawa script') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=kawa test-script-docker'
                }
            }
        }
        stage('mosh script') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=mosh test-script-docker'
                }
            }
        }
        stage('racket script') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=racket test-script-docker'
                }
            }
        }
        stage('sagittarius script') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=sagittarius test-script-docker'
                }
            }
        }
        stage('stklos script') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=stklos test-script-docker'
                }
            }
        }
        stage('ypsilon script') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=ypsilon test-script-docker'
                }
            }
        }
        stage('chicken compile') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=chicken test-compile-docker'
                }
            }
        }
        stage('cyclone compile') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=cyclone test-compile-docker'
                }
            }
        }
        stage('gambit compile') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=gambit test-compile-docker'
                }
            }
        }
        stage('kawa compile') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=kawa test-compile-docker'
                }
            }
        }
        stage('racket compile') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=racket test-compile-docker'
                }
            }
        }
    }
}
