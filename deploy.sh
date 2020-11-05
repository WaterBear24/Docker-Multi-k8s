docker build -t wesdeitch24/multi-client:latest -t wesdeitch24/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t wesdeitch24/multi-server:latest -t wesdeitch24/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t wesdeitch24/multi-worker:latest -t wesdeitch24/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push wesdeitch24/multi-client:latest
docker push wesdeitch24/multi-server:latest
docker push wesdeitch24/multi-worker:latest

docker push wesdeitch24/multi-client:$SHA
docker push wesdeitch24/multi-server:$SHA
docker push wesdeitch24/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployments server=wesdeitch24/multi-server:$SHA
kubectl set image deployments/client-deployments client=wesdeitch24/multi-client:$SHA
kubectl set image deployments/worker-deployments worker=wesdeitch24/multi-worker:$SHA