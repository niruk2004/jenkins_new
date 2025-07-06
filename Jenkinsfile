pipeline {
    agent any

    environment {
        VENV_DIR = "venv"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/niruk2004/jenkins_new', branch: 'main'
            }
        }

        stage('Set Up Python Environment') {
            steps {
                sh '''
                    python3 -m venv ${VENV_DIR}
                    . ${VENV_DIR}/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Build - Syntax Check') {
            steps {
                sh '''
                    . ${VENV_DIR}/bin/activate
                    python -m py_compile sources/add2vals.py sources/calc.py
                '''
            }
        }

        stage('Test') {
            steps {
                sh '''
                    . ${VENV_DIR}/bin/activate
                    mkdir -p test-reports
                    pytest --verbose --junit-xml=test-reports/results.xml sources/test_calc.py
                '''
            }
        }

        stage('Deliver - PyInstaller Build') {
            steps {
                sh '''
                    . ${VENV_DIR}/bin/activate
                    pyinstaller --onefile sources/add2vals.py
                '''
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'dist/add2vals', onlyIfSuccessful: true
            junit 'test-reports/results.xml'
        }
    }
}
