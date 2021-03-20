

IMPORTANTE:
----------
* MICROSERVICIO Dummy para pruebas, que devuelve información básica de CLIENTES.
* VERSION: 3.0 

Los LINKs del 'MICROSERVICIO' son:
---------------------------------

  1. Las 'URI' de tipo [GET] son:
     ---------------------------
  
     - consultarClientes [NODE-PORT]: 
	   $ curl http://localhost:8080/dummy-micro-cliente/get/clientes
  
     - consultarClientesPorId [NODE-PORT]:  
	   $ curl http://localhost:8080/dummy-micro-cliente/get/clientes/{id}
	 
	 
	   
     - consultarClientes [CLUSTER-IP]: 
	   $ curl http://my-cliente-service-ci:8080/dummy-micro-cliente/get/clientes
	   
     - consultarClientesPorId [CLUSTER-IP]: 
	   $ curl http://my-cliente-service-ci:8080/dummy-micro-cliente/get/clientes/{id}
 
 
DETALLE:
------- 
* Para INFORMACIÓN interna del MICROSERVICIO, apoyarse en ACTUATOR ingresando a: 'http://localhost:8080/actuator'


BANNERs:
-------
* http://www.patorjk.com/software/taag

