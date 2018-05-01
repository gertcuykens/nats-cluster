build:
	env GOOS=linux go build
	docker build -t gertcuykens/nats:routez .
	docker push gertcuykens/nats:routez

run:
	docker run --rm gertcuykens/nats:routez $(CMD)

test:
# gnatsd -config ../nats.conf -D
	go run main.go

kube:
	-kubectl delete -f nats-routez.yaml
	kubectl apply -f nats-routez.yaml
# kubectl logs -f nats-routez-...
