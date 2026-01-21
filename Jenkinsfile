pipeline {
  agent any

  environment {
    GITHUB_REPO = "samukaoliveira/SNFin"
    GITHUB_REF  = "master"
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Aguardar GitHub Actions') {
        steps {
          withCredentials([string(credentialsId: 'github-actions-token', variable: 'GITHUB_TOKEN')]) {
            sh '''
              set -e
      
              COMMIT_SHA=$(git rev-parse HEAD)
              echo "Commit: $COMMIT_SHA"
      
              MAX_ATTEMPTS=30
              SLEEP_TIME=20
              ATTEMPT=1
      
              while [ $ATTEMPT -le $MAX_ATTEMPTS ]; do
                echo "⏳ Tentativa $ATTEMPT/$MAX_ATTEMPTS"
      
                RESPONSE=$(curl -s \
                  -H "Authorization: Bearer $GITHUB_TOKEN" \
                  -H "Accept: application/vnd.github+json" \
                  https://api.github.com/repos/samukaoliveira/SNFin/actions/runs?head_sha=$COMMIT_SHA)
      
                STATUS=$(echo "$RESPONSE" | jq -r '.workflow_runs[0].conclusion')
      
                echo "Status atual: $STATUS"
      
                if [ "$STATUS" = "success" ]; then
                  echo "✅ GitHub Actions finalizou com sucesso"
                  exit 0
                fi
      
                if [ "$STATUS" = "failure" ] || [ "$STATUS" = "cancelled" ]; then
                  echo "❌ GitHub Actions falhou"
                  exit 1
                fi
      
                sleep $SLEEP_TIME
                ATTEMPT=$((ATTEMPT+1))
              done
      
              echo "❌ Timeout aguardando GitHub Actions"
              exit 1
            '''
          }
        }
      }



    stage('Build / Deploy') {
      steps {
        echo "🚀 Build autorizado — GitHub Actions OK"
        // aqui entra deploy, docker, etc
      }
    }
  }

  post {
    success {
      echo "✅ Pipeline finalizada com sucesso"
    }
    failure {
      echo "❌ Pipeline falhou (GitHub Actions)"
    }
  }
}
