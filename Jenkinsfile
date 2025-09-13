def tests = ['primitives', 'array', 'struct', 'addressof', 'callback']

pipeline {
    agent {
        label 'linux'
    }

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('Tests') {
            steps {
                script {
                    def implementations = sh(script: 'docker run retropikzel1/compile-r7rs sh -c "compile-r7rs --list-r7rs-schemes"', returnStdout: true).split()
                    //def implementations = "chibi chicken gauche guile kawa mosh racket sagittarius stklos ypsilon".split()

                    parallel implementations.collectEntries { implementation ->
                        [(implementation): {
                                tests.each { test ->
                                    stage("${implementation} ${test}") {
                                        catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                            if("${implementation}" == "chicken") {
                                                DOCKERIMG="chicken:5"
                                            } else {
                                                DOCKERIMG="${implementation}:head"
                                            }
                                            sh "docker build --build-arg IMAGE=${DOCKERIMG} --build-arg SCHEME=${implementation} --tag=foreign-c-test-${implementation} -f Dockerfile.test ."
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
