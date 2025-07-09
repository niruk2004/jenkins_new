node {
    stage('Checkout Code') {
        checkout scm
    }

    stage('Set up Python Virtual Environment') {
        sh '''
            python3 -m venv venv
            . venv/bin/activate
            pip install --upgrade pip
            pip install -r requirements.txt
        '''
    }

    stage('Run Python Script') {
        sh '''
            . venv/bin/activate
            python my_script.py
        '''
    }
}
