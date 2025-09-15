def tests = ['primitives', 'array', 'struct', 'addressof', 'callback']

pipeline {
    agent {
        label 'docker-x86_64'
    }

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {

        stage('Cache warmup') {
            steps {
                sh "docker build --build-arg IMAGE=chibi:head --build-arg SCHEME=chibi --tag=foreign-c-test-chibi -f Dockerfile.test ."
            }
        }

        stage('Tests') {
            steps {
                script {
                    //def implementations = sh(script: 'docker run retropikzel1/compile-r7rs sh -c "compile-r7rs --list-r7rs-schemes"', returnStdout: true).split()
                    def implementations = "chibi chicken gauche guile kawa mosh racket sagittarius stklos ypsilon".split()

                    parallel implementations.collectEntries { implementation ->
                        [(implementation): {
                                tests.each { test ->
                                    stage("${implementation} ${test}") {
                                        catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                            def DOCKERIMG="${implementation}:head"
                                            if("${implementation}" == "chicken") {
                                                DOCKERIMG="chicken:5"
                                            }
                                            sh "docker build --build-arg IMAGE=${DOCKERIMG} --build-arg SCHEME=${implementation} --tag=foreign-c-test-${implementation} -f Dockerfile.test ."
                                            sh "docker run -v ${WORKSPACE}:/workdir -w /workdir -t foreign-c-test-${implementation} sh -c \"make SCHEME=${implementation} TEST=${test} SNOW_CHIBI_ARGS=--always-yes clean install test\""
                                        }
                                    }
                                }
                            }
                        ]
                    }
                }
            }
        }
    }
}
