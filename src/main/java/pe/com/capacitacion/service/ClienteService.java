package pe.com.capacitacion.service;

import java.util.List;
import javax.ws.rs.core.Response;

/**
 * ClienteService 
 * @author cguerra
 **/
 public class ClienteService{

  	   /**
  	    * procesarService
  	    * @param  listaClientes
  	    * @param  vClientes_01
  	    * @param  vClientes_02
  	    * @param  vClientes_3
  	    * @param  id
  	    * @param  objResponseMsg
  	    * @param  vCadenaReplace
  	    * @return Response
  	    **/
		public javax.ws.rs.core.Response procesarService( List<String> listaClientes, String vClientes_01, String vClientes_02, String vClientes_03, long id, String objResponseMsg, String vCadenaReplace ) {
			
			   listaClientes.add( vClientes_01 );	   
			   listaClientes.add( vClientes_02 );
			   listaClientes.add( vClientes_03 );
			   
			   String vDatoJson = "";
			   for( int i=0; i<listaClientes.size(); i++ ){	        	   
				   if( (i+1) == id ){
					   vDatoJson = listaClientes.get( i ); 
					   break; 
				   }  
			   }
			   
			   objResponseMsg = vDatoJson;				   
			   objResponseMsg = ( objResponseMsg.replaceAll( vCadenaReplace, Response.Status.OK + "" ) ); 
	
			   return Response.ok( objResponseMsg ).build();
			  
			   //Thread.sleep( 1000 * 5 ); //SOLO PARA PRUEBAS
			   //objResponseMsg = "Se encontro el ERROR: [" + Response.Status.INTERNAL_SERVER_ERROR + "]"; 
	
			   //return Response.status( Response.Status.INTERNAL_SERVER_ERROR ).entity( objResponseMsg ).build(); //SOLO PARA PRUEBAS		
		}	
	
 }

