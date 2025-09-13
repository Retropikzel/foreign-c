def tests = ['primitives', 'array', 'struct', 'addressof', 'callback']

pipeline {
    agent any

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('Package') {
            steps {
                sh "docker build --build-arg IMAGE=chibi:head --build-arg SCHEME=chibi --tag=foreign-c-test-chibi -f dockerfiles/Dockerfile.snow-chibi-install-test ."
                sh "docker run -v ${WORKSPACE}:/workdir -w /workdir -t foreign-c-test-chibi sh -c \"timeout 120 make clean all\""
            }
        }

        stage('Tests') {
            steps {
                script {
                    def implementations = sh(script: 'docker run retropikzel1/compile-r7rs:chibi sh -c "compile-r7rs --list-r7rs-schemes"', returnStdout: true).split()
                    //def implementations = "chibi chicken gauche guile kawa mosh racket sagittarius stklos ypsilon".split()

                    parallel implementations.collectEntries { implementation ->
                        [(implementation): {
                                stage("${implementation} test install") {
                                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                        if("${implementation}" == "chicken") {
                                            DOCKERIMG="chicken:5"
                                        } else {
                                            DOCKERIMG="${implementation}:head"
                                        }
                                        sh "docker build --build-arg IMAGE=${DOCKERIMG} --build-arg SCHEME=${implementation} --tag=foreign-c-test-${implementation} -f dockerfiles/Dockerfile.snow-chibi-install-test ."
                                            sh "docker run -v ${WORKSPACE}:/workdir -w /workdir -t foreign-c-test-${implementation} sh -c \"timeout 120 make SCHEME=${implementation} SNOW_CHIBI_ARGS=\"--always-yes\" clean install && cp tests/hello.scm /tmp/ && cd /tmp && COMPILE_R7RS=${implementation} printf \"\\n\" | timeout 120 compile-r7rs -o hello hello.scm && printf \"\\n\" | timeout 120 ./hello\""
                                    }
                                }
                                tests.each { test ->
                                    stage("${implementation} ${test}") {
                                        catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                            if("${implementation}" == "chicken") {
                                                DOCKERIMG="chicken:5"
                                            } else {
                                                DOCKERIMG="${implementation}:head"
                                            }
                                            sh "docker build --build-arg IMAGE=${DOCKERIMG} --build-arg SCHEME=${implementation} --tag=foreign-c-test-${implementation} -f dockerfiles/Dockerfile.test ."
                                                sh "docker run -v ${WORKSPACE}:/workdir -w /workdir -t foreign-c-test-${implementation} sh -c \"timeout 120 make SCHEME=${implementation} TEST=${test} clean test\""
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
