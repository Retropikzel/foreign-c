def implementations = ['chibi', 'sagittarius']
def tests = ['primitives']

pipeline {
    agent any

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    stages {
        stage('Testing') {
            steps {
                script {
                    implementations.each { implementation ->
                        agent {
                            dockerfile {
                                filename 'Dockerfile.test'
                                    args '--user=root'
                                    additionalBuildArgs "--build-arg COMPILE_R7RS=${implementation}"
                            }
                        }
                        stage("${implementation} primitives") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                echo "hello"
                            }
                        }
                    }
                }
            }
        }
    }
}
