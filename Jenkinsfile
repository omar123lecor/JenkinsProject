pipeline {
    agent any

    stages {

        stage('Start Services') {
            steps {
                sh 'docker compose up -d --build'
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

    post {
        always {
            sh 'docker compose down'
        }
    }
}
