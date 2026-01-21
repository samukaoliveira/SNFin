pipeline {
    agent any

    environment {
        GITHUB_TOKEN = credentials('github-actions-token')
        OWNER = 'samukaoliveira'
        REPO  = 'SNFin'
        WORKFLOW_FILE = 'ci.yml'
        BRANCH = 'master'
    }

    stages {
        stage('Disparar GitHub Actions') {
            steps {
                sh '''
                  curl -s -X POST \
                    -H "Authorization: Bearer $GITHUB_TOKEN" \
                    -H "Accept: application/vnd.github+json" \
                    https://api.github.com/repos/$OWNER/$REPO/actions/workflows/$WORKFLOW_FILE/dispatches \
                    -d '{
                      "ref": "'$BRANCH'",
                      "inputs": {
                        "reason": "triggered by jenkins"
                      }
                    }'
                '''
            }
        }
    }


    post {
        success {
            echo "🚀 GitHub Actions disparado com sucesso"
        }
        failure {
            echo "❌ Falha ao disparar GitHub Actions"
        }
    }
}
