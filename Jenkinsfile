pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
                sh 'ls -R .'
            }
        }

        stage('Run ETL') {
            steps {
                sh 'docker compose run --rm etl'
            }
        }

        stage('Run dbt Transformations') {
            steps {
                sh 'docker compose run --rm dbt run'
            }
        }

        stage('Run dbt Tests') {
            steps {
                sh 'docker compose run --rm dbt test'
            }
        }
    }
}
