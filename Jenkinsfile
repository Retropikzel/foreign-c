pipeline {
    agent {
        dockerfile {
            filename 'dockerfiles/jenkins'
            dir '.'
            args '--privileged -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    options {
            buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('chibi') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=chibi test-script-docker'
                }
            }
        }
        stage('chicken') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=chicken test-script-docker'
                }
            }
        }
        stage('cyclone') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=cyclone test-script-docker'
                }
            }
        }
        stage('gambit') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=gambit test-script-docker'
                }
            }
        }
        stage('gauche') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=gauche test-script-docker'
                }
            }
        }
        stage('gerbil') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=gerbil test-script-docker'
                }
            }
        }
        stage('guile') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=guile test-script-docker'
                }
            }
        }
        stage('kawa') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=kawa test-script-docker'
                }
            }
        }
        stage('mosh') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=mosh test-script-docker'
                }
            }
        }
        stage('racket') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=racket test-script-docker'
                }
            }
        }
        stage('racket-wine') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=racket-wine test-script-docker'
                }
            }
        }
        stage('sagittarius') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=sagittarius test-script-docker'
                }
            }
        }
        stage('stklos') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=stklos test-script-docker'
                }
            }
        }
        stage('skint') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=skint test-script-docker'
                }
            }
        }
        stage('tr7i') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=tr7i test-script-docker'
                }
            }
        }
        stage('ypsilon') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=ypsilon test-script-docker'
                }
            }
        }
        stage('chicken') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=chicken test-compile-docker'
                }
            }
        }
        stage('cyclone') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=cyclone test-compile-docker'
                }
            }
        }
        stage('gambit') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=gambit test-compile-docker'
                }
            }
        }
        stage('gauche') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=gauche test-compile-docker'
                }
            }
        }
        stage('gerbil') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=gerbil test-compile-docker'
                }
            }
        }
        stage('kawa') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=kawa test-compile-docker'
                }
            }
        }
        stage('racket') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'make SCHEME=racket test-compile-docker'
                }
            }
        }
    }
}
