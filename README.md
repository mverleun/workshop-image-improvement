# Workshop

Bekijk de Dockerfile. Deze is redelijk eenvoudig. Het neemt een bestaand python image en voegt daar een eenvoudige applicatie aan toe.

Deze applicatie is straks te benaderen op <http://localhost/hello> en <http://localhost/healthz>

## 0 Cross platform

macOS gebruikers hebben mogelijk een arm processor ipv een amd/intel. Op zich geen probleem voor deze workshop. Maar als je expliciet amd64 images wilt gebruiken kan dat door de `docker build` commando's aan te passen. Zo'n commando zou er als volgt uit kunnen zien: `docker buildx build --platform linux/amd64 -t workshop:1.0.0 -f Dockerfile-1 .`

## 1 Maak het image en start deze

Hiervoor heb je twee terminals nodig.

In terminal 1 voer je de volgende commando's uit:

```bash
docker build -t workshop:1.0.0 -f Dockerfile-1 .

docker run -e HELLO_NAME=Phippy2 --name workshop --rm -p 80:80 workshop:1.0.0
```

(Phippy2 is de broer van Phippy <https://www.cncf.io/phippy/>)

Kijk in een browser of <http://localhost/hello> het doet. Kijk ook naar de logging van de pod.


## 2 Inspecteer de container

Log in een tweede terminal in in de draaiende container en bekijk verschillende aspecten:

```bash
docker exec -it workshop bash
# inside container
id
apt update
ps -ef
touch /test
exit
```

En wat vind je er van?
Stop de container in terminal 1.

## 3 Hoe maken we dit veiliger?

Suggesties?

Probeer eens het volgende in terminal 1:

```bash
diff Dockerfile-1 Dockerfile-2

docker build -t workshop:1.2.0 -f Dockerfile-2 .

docker run -e HELLO_NAME=Phippy2 --user 500 --name workshop --rm -p 80:8000 workshop:1.2.0
```

(We schakelen over naar poort 8000 omdat op een *nix systeem poort 80 bijzonder is. Wie weet wat er bijzonder aan is?)

En in terminal 2:

```bash
docker exec -it workshop bash
# inside container
id
apt update
ps -ef
touch /test
exit
```

Stop de container in terminal 1

## 4 Upload image in minikube

Lokale images zijn niet direct beschikbaar in minikube. Iedere keer als we een nieuwe versie maken moeten we deze uploaden.

```bash
docker image ls
minikube image load workshop:1.0.0
minikube image ls
```

## 5 Deploy de manifest file, gebaseerd op de helm chart in de directory helm

Als je Lens hebt geinstalleerd is dit een mooi moment om deze te starten.

```bash
minikube kubectl -- get nodes
minikube kubectl -- create -f rendered-chart.yaml
```

Controleer of de deployment werkt:

In een terminal start een portforwarding:

```bash
# Poort 8000 op de host, port 80 in minikube
minikube kubectl port-forward svc/workshop 8000:80
```

Open nu de link <http://localhost:8000/hello>.
Hoe veilig is deze eigenlijk?

## 6 Inspecteer de POD

```bash
minikube kubectl -- get pods
NAME                        READY   STATUS    RESTARTS   AGE
workshop-6c7bc5c754-ngq9n   1/1     Running   0          7m28s
# Get Pod name and use it below
minikube kubectl -- exec workshop-6c7bc5c754-ngq9n -it -- bash

# inside container
id
apt update
ps -ef
touch /test
exit
```

We hebben nog steeds dezelfde issue als met Dockerfile-1

Kunnen we iets doen:

- A in de Dockerfile?
- B in de manifest file?
- C C'est la via, mon ami.

Wat dachten jullie van:

- <https://kubernetes.io/docs/tasks/configure-pod-container/security-context/>
- <https://docs.docker.com/engine/reference/builder/#user>

## 7 Wat is er nog meer mis?

In terminal 1:

```bash
grype workshop:1.2.0
```

Ai, dat is schrikken...

En nu dan?

```bash

docker build -t workshop:1.3.0 .

grype workshop:1.3.0

docker image ls
```

Welke issues zijn er opgelost?

```bash
diff <(grype workshop:1.0.0) <(grype workshop:1.3.0)
```


## 8 Zijn we er nu?

Wat kan nog meer beter?

- Resources?
- Probes?
- Replicacount?

Hoe kunnen we resources inschatten?

(Indien de metrics api niet is ingeschakeld: `minikube addons enable metrics-server` )

```bash
minikube kubectl -- top pod
```

En hoe kunnen we ons laten adviseren?

Voer het volgende commando in als je Polaris hebt geinstalleerd:

```bash
polaris dashboard
```

Open nu <http://localhost:8080/> in een browser en kijk naar de mening van een ander.
Polaris kan heel erg getuned worden, dit zijn de default settings.
