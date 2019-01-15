docker build -t calvincolton/fibonacci-client:latest -t calvincolton/fibonacci-client:$SHA -f ./client/Dockerfile ./client
docker build -t calvincolton/fibonacci-server:latest -t calvincolton/fibonacci-server:$SHA -f ./server/Dockerfile ./server
docker build -t calvincolton/fibonacci-worker:latest -t calvincolton/fibonacci-worker:$SHA -f ./worker/Dockerfile ./worker

docker push calvincolton/fibonacci-client:latest
docker push calvincolton/fibonacci-server:latest
docker push calvincolton/fibonacci-worker:latest

docker push calvincolton/fibonacci-client:$SHA
docker push calvincolton/fibonacci-server:$SHA
docker push calvincolton/fibonacci-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=calvincolton/fibonacci-server:$SHA
kubectl set image deployments/client-deployment client=calvincolton/fibonacci-client:$SHA
kubectl set image deployments/worker-deployment worker=calvincolton/fibonacci-worker:$SHA
