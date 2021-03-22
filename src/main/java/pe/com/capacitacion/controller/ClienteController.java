package pe.com.capacitacion.controller;

import java.util.ArrayList;
import java.util.List;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import lombok.extern.slf4j.Slf4j;
import pe.com.capacitacion.service.ClienteService;
import javax.inject.Inject;

@Slf4j  //Autogenerar LOG4J. 
@Path( "/dummy-micro-cliente" )
public class ClienteController {

    private String vClientes_01 = "{ \"nombre\": \"PAOLO GUERRERO\", \"edad\": 35, \"rol\": \"CONSULTOR\",   \"direccion\": \"Calle. 123 Chorrillos\", \"dni\": \"41816133\", \"version\": \"v1\", \"codigoHttp\": \"XXX\" }";
    private String vClientes_02 = "{ \"nombre\": \"LUIS GUADALUPE\", \"edad\": 40, \"rol\": \"PROGRAMADOR\", \"direccion\": \"Av. 333 Lince\",         \"dni\": \"45886854\", \"version\": \"v1\", \"codigoHttp\": \"XXX\" }"; 
    private String vClientes_03 = "{ \"nombre\": \"PEDRO SALAZAR\",  \"edad\": 30, \"rol\": \"ARQUITECTO\",  \"direccion\": \"Jiron. 123 Lima\",       \"dni\": \"41818956\", \"version\": \"v1\", \"codigoHttp\": \"XXX\" }";
    private String vClientes_04 = "[" + vClientes_01 + "," + vClientes_02 + "," + vClientes_03 + "]";	 
 
    private List<String> listaClientes  = new ArrayList<String>();  
    private String       vCadenaReplace = "XXX";

    @Inject
    private ClienteService clienteService;
    
   /** 
    * consultarClientesPorId	
    * @param  id
    * @return String 
    **/
    @GET
    @Path( "/get/clientes/{id}" )
    @Produces( { MediaType.APPLICATION_JSON } )
	public Response consultarClientesPorId( @PathParam( "id" ) long id ){
		   log.info( "'consultarClientesPorId': id={}", id );

		   String objResponseMsg = "";
		   
		   try{ 
			   Response procesarService = this.clienteService.procesarService( this.listaClientes, this.vClientes_01, this.vClientes_02, this.vClientes_03, id, objResponseMsg, this.vCadenaReplace );			   
			   return procesarService;
		   }
		   catch( Exception e ) { 
			      e.printStackTrace();
			      return Response.status( Response.Status.INTERNAL_SERVER_ERROR ).entity( objResponseMsg ).build();
		   }	
		   catch( Throwable e ) { 
			      e.printStackTrace();
			      return Response.status( Response.Status.INTERNAL_SERVER_ERROR ).entity( objResponseMsg ).build();
		   }		   
	} 
	
   /**
    * consultarClientes	
    * @return String 
    **/
    @GET
    @Path( "/get/clientes" )
    @Produces( { MediaType.APPLICATION_JSON } )
	public String consultarClientes(){
		   log.info( "'consultarClientes'" );

		   String objResponseMsg = vClientes_04;
		   return objResponseMsg; 
	}    
    
  }

