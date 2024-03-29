<!DOCTYPE html>
<html lang="esS" >
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrapValidator.js"></script>
<script type="text/javascript" src="js/global.js"></script>

<link rel="stylesheet" href="css/bootstrap.css"/>
<link rel="stylesheet" href="css/bootstrapValidator.css"/>
<title>Ejemplos de CIBERTEC - Jorge Jacinto </title>
</head>
<body>

<div class="container">
<h3>Registra Proveedor</h3>
	
	<form  id="id_form" method="post"> 
	 <div class="col-md-12" style="margin-top: 2%">
			<div class="row">
				<div class="form-group col-md-6">
					<label class="control-label" for="id_nombre">Nombre</label>
					<input class="form-control" type="text" id="id_nombre" name="nombre" placeholder="Ingrese el nombre">
				</div>
				<div class="form-group col-md-6">
					<label class="control-label" for="id_dni">DNI</label>
					<input class="form-control" id="id_dni" name="dni" placeholder="Ingrese el DNI" type="text" maxlength="8"/>
				</div>
				<div class="form-group  col-sm-6">
				
			</div>
			</div>
			<div class="row">
				<div class="form-group col-md-6">
					<label class="control-label" for="id_tipo">Tipo</label>
					<select id="id_tipo" name="tipo.idTipo" class='form-control'>
						<option value=" " >[Seleccione]</option>    
					</select>
			    </div>
			    <div class="form-group col-md-6">
					<label class="control-label" for="id_pais">Pais</label>
					<select id="id_pais" name="pais.idPais" class='form-control'>
						<option value=" ">[Seleccione]</option>    
					</select>
			    </div>
			    
				
		    </div>
		    <div class="row">
				<div class="form-group col-md-12" align="center">
					<button id="id_registrar" type="button" class="btn btn-primary" >Registra</button>
				</div>
			</div>
	</div>
	</form>
	
</div>

<script type="text/javascript">
/*Obtener JSON */
$.getJSON		("listaTipo", {}, function(data){
	/*Bucle For*/
	$.each(data, function(index,item){
		$("#id_tipo").append("<option value="+item.idTipo +">"+ item.descripcion +"</option>");
	});
});
/*Obtener JSON */
$.getJSON		("listaPais", {}, function(data){
	/*Bucle For*/
	$.each(data, function(index,item){
		$("#id_pais").append("<option value="+item.idPais +">"+ item.nombre +"</option>");
	});
});

$("#id_registrar").click(function (){ 

	var validator = $('#id_form').data('bootstrapValidator');
	validator.validate();

	if (validator.isValid()){
		$.ajax({
			type: 'POST',  
			data: $("#id_form").serialize(),
			url: 'registraProveedor',
			success: function(data){
				mostrarMensaje(data.MENSAJE);
				limpiar();
				validator.resetForm();
			},
			error: function(){
				mostrarMensaje(MSG_ERROR);
			}
		});
	}
});

function limpiar(){
	$("#id_nombre").val('');
	$("#id_dni").val('');
	$("#id_tipo").val('');
	$("#id_pais").val('');
}

$('#id_form').bootstrapValidator({
    message: 'This value is not valid',
    feedbackIcons: {
        valid: 'glyphicon glyphicon-ok',
        invalid: 'glyphicon glyphicon-remove',
        validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
    	nombre: {
    		selector : '#id_nombre',
            validators: {
                notEmpty: {
                    message: 'El nombre es un campo obligatorio'
                },
                stringLength :{
                	message:'El nombre es de 3 a 100 caracteres',
                	min : 3,
                	max : 100
                },
                remote : {
                	delay: 1000, /*Desde que se escribe pasa 1 seg. y manda una respuesta*/
                	url: 'buscaPorNombreProveedor',
                	message: 'El nombre ya existe'
                },
            }
        },
        dni: {
    		selector : '#id_dni',
            validators: {
                notEmpty: {
                    message: 'DNI es un campo obligatorio'
                },
                stringLength :{
                	message:'El DNI es de 8 caracteres',
                	max : 8
                },
                remote : {
                	delay: 1000, /*Desde que se escribe pasa 1 seg. y manda una respuesta*/
                	url: 'buscaPorDniProveedor',
                	message: 'El DNI ya existe'
                },
                regexp: {
                    regexp: /^[0-9]+$/,
                    message: 'Ingresar DNI con caracteres num&eacute;ricos'
                }
            }
        },
        tipo: {
    		selector : '#id_tipo',
            validators: {
            	notEmpty: {
                    message: 'Tipo es un campo obligatorio'
                },
            } 
        },
        pais: {
    		selector : '#id_pais',
            validators: {
            	notEmpty: {
                    message: 'País es un campo obligatorio'
                },
            }
        },
    	
    }   
});
</script>
</body>
</html>
