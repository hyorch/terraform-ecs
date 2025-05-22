# variable version
VERSION=0.0.2
# construir el contenedor
build:
	docker build -t nginx-show-env:${VERSION} .
# ejecutar el contenedor
run:
	docker run --env DB=postgresql --rm -d --name nginx-show-env -p 8080:80 nginx-show-env:${VERSION} 

# detener el contenedor
stop:
	docker stop nginx-show-env
# eliminar el contenedor

# login en dockerhub
login:
	docker login -u hyorch

#subir el contenedor a docherhub
push:
	docker tag nginx-show-env:${VERSION} hyorch/nginx-show-env:${VERSION}
	docker push hyorch/nginx-show-env:${VERSION}
	
#docker push hyorch/nginx-show-env:tagname
