nats:
	gnatsd --config local.conf -D

stan:
	nats-streaming-server --config local.conf -ms 8223 -SD

tls:
	openssl genrsa -out tls/ca-key.pem 2048
	openssl req -x509 -new -nodes -key tls/ca-key.pem -days 10000 -out tls/ca.pem -subj "/CN=kube-ca"
	openssl genrsa -out tls/nats-key.pem 2048
	openssl req -new -key tls/nats-key.pem -out tls/nats.csr -subj "/CN=kube-nats" -config tls/tls.cnf
	openssl x509 -req -in tls/nats.csr -CA tls/ca.pem -CAkey tls/ca-key.pem -CAcreateserial -out tls/nats.pem -days 3650 -extensions v3_req -extfile tls/tls.cnf

kubeTLS:
	-kubectl delete secret tls-nats-client
	kubectl create secret generic tls-nats-client --from-file tls/ca.pem
	-kubectl delete secret tls-nats-server
	kubectl create secret generic tls-nats-server --from-file tls/nats.pem --from-file tls/nats-key.pem --from-file tls/ca.pem

kubeCFG:
	-kubectl delete configmap nats-config
	kubectl create configmap nats-config --from-file nats.conf

kubeNTS: kubeCFG
	-kubectl delete -f nats.yaml
	kubectl create -f nats.yaml

kubeSTN: kubeCFG
	-kubectl delete -f stan.yaml
	kubectl create -f stan.yaml

# kubectl logs -f nats-0
# kubectl scale statefulsets nats --replicas 5
# kubectl port-forward nats-0 8222:8222
# kubectl exec -it nats-0 -- /gnatsd -sl quit=1

.PHONY: tls

# openssl req -x509 -out localhost.crt -keyout localhost.key \
#   -newkey rsa:2048 -nodes -sha256 \
#   -subj '/CN=localhost' -extensions EXT -config <( \
#    printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
