<%@ page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>


<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
#wrapper {
	width: auto;
	height: auto;
	float: left;
}

#content-wrapper {
	width: 700px;
	height: auto;
	margin: 5px 0px 0px 5px;
	background-color: #fff;
	float: left;
	padding-bottom: 10px;
}

.error-information {
	width: auto;
	height: auto;
	border-bottom: 1px solid #d9d9d9;
	float: left;
	margin: 5px 5px 0px 5px;
	padding-bottom: 5px;
	cursor: pointer;
}

.info {
	float: left;
	margin: 0px 20px 0px 0px;
}

.errorid, .status, .department {
	width: 100px;
}

.resolution {
	width: 200px;
}

#form-wrapper {
	width: 640px;
	background-color: #fff;
	margin: 20px 0px 0px 5px;
	float: left;
	display: none;
}

.label-title {
	margin-right: 15px;
}

.textfield input {
	width: 200px
}

.label-title {
	width: 150px;
	float: left;
}

.form-style-1 {
	margin: 10px auto;
	max-width: 400px;
	padding: 20px 12px 10px 20px;
	font: 13px "Lucida Sans Unicode", "Lucida Grande", sans-serif;
}

.form-style-1 li {
	padding: 0;
	display: block;
	list-style: none;
	margin: 10px 0 0 0;
}

.form-style-1 label {
	margin: 0 0 3px 0;
	padding: 0px;
	display: block;
	font-weight: bold;
}

.form-style-1 input[type=text], .form-style-1 input[type=date],
	.form-style-1 input[type=datetime], .form-style-1 input[type=number],
	.form-style-1 input[type=search], .form-style-1 input[type=time],
	.form-style-1 input[type=url], .form-style-1 input[type=email],
	textarea, select {
	box-sizing: border-box;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	border: 1px solid #BEBEBE;
	padding: 7px;
	margin: 0px;
	-webkit-transition: all 0.30s ease-in-out;
	-moz-transition: all 0.30s ease-in-out;
	-ms-transition: all 0.30s ease-in-out;
	-o-transition: all 0.30s ease-in-out;
	outline: none;
}

.form-style-1 input[type=text]:focus, .form-style-1 input[type=date]:focus,
	.form-style-1 input[type=datetime]:focus, .form-style-1 input[type=number]:focus,
	.form-style-1 input[type=search]:focus, .form-style-1 input[type=time]:focus,
	.form-style-1 input[type=url]:focus, .form-style-1 input[type=email]:focus,
	.form-style-1 textarea:focus, .form-style-1 select:focus {
	-moz-box-shadow: 0 0 8px #88D5E9;
	-webkit-box-shadow: 0 0 8px #88D5E9;
	box-shadow: 0 0 8px #88D5E9;
	border: 1px solid #88D5E9;
}

.form-style-1 .field-divided {
	width: 49%;
}

.form-style-1 .field-long {
	width: 100%;
}

.form-style-1 .field-select {
	width: 100%;
}

.form-style-1 .field-textarea {
	height: 100px;
}

.form-style-1 input[type=submit], .form-style-1 input[type=button] {
	background: #4B99AD;
	padding: 8px 15px 8px 15px;
	border: none;
	color: #fff;
}

.form-style-1 input[type=submit]:hover, .form-style-1 input[type=button]:hover
	{
	background: #4691A4;
	box-shadow: none;
	-moz-box-shadow: none;
	-webkit-box-shadow: none;
}

.form-style-1 .required {
	color: red;
}
</style>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>


<!--////////////////////////////////////////////////////////////////////////////////// -->

<script type="text/javascript" charset="utf-8">
//---------------------------------------------------------------
//-------------------Turkiye Adres Listesi Save------------------
//--Mehmet ÜLKER-------------------------------------------------



$(document).ready(function() {  
$.ajax({
         // url:'https://turkiye-adress-api.herokuapp.com/trCity',
	  	   url:'/trCity',
        type: 'GET',  // http method
        success: function (data) {
          var html = '';
          var len = data.length;
          html += '<option value="0">İl Seçiniz..</option>';
          for (var i = 1; i < len; i++) {
           html += '<option value="' + data[i].il + '">'
           + data[i].il
           + '</option>'; }
           html += '</option>';
           $('#city').html(html);
           
         },
         error : function(e) {
           alert(e);
         }
       });
});


//ilçe
$(document).ready(function() {
$("#city").change(function() {
 var city = $(this).find(":selected").val();
 // alert(city);
 $.ajax({
     // url:'https:/turkiye-adress-api.herokuapp.com/trTown',
 	 url:'/trTown',
      type: 'POST',  // http method
      data: {city:city},
      success: function (data) {
       $(town).html("");
       $(district).html("");
       $(neighborhoods).html("");
       document.getElementById('postcode').value = "";
       
       
       var html = '';
       var len = data.length;
       html += '<option value="0">İlçe Seçiniz..</option>';
       for (var i = 0; i < len; i++) {
         html += '<option value="' + data[i].ilce+ '">'
         + data[i].ilce
         + '</option>';
       }
       html += '</option>';
       $('#town').html(html);
       
     },
     error : function(e) {
       alert(e);
     }
   });
});
});


//Semt
$(document).ready(function() {
$("#town").change(function() {
 var town = $(this).find(":selected").val();
// alert(town);
 $.ajax({
 	 url:'/trDistrict', 
      type: 'POST',  // http method
      data: {town:town},
      success: function (data) {
        $(district).html("");   		  
        $(neighborhoods).html("");
        document.getElementById('postcode').value = "";

        
        var html = '';
        var len = data.length;
        html += '<option value="0">Semt Seçiniz..</option>';
        for (var i = 0; i < len; i++) {
         html += '<option value="' + data[i].semt + '">'
         + data[i].semt
         + '</option>';
       }
       html += '</option>';
       $('#district').html(html);
       
     },
     error : function(e) {
       alert(e);
     }
   });
});
});

//Mahalle
$(document).ready(function() {
$("#district").change(function() {
 var district = $(this).find(":selected").val();
// alert(district);
 $.ajax({
 	 url:'/trNeighborhoods',
      type: 'POST',  // http method
      data: {district:district},
      success: function (data) {

       $(neighborhoods).html("");   		 
       document.getElementById('postcode').value = "";
       
       var html = '';
       var len = data.length; 
       html += '<option value="0">Mahalle Seçiniz..</option>';
       for (var i = 0; i < len; i++) {
         html += '<option value="' + data[i].mahalle + '">'
         + data[i].mahalle
         + '</option>';
       }
       html += '</option>';
       $('#neighborhoods').html(html);
       
     },
     error : function(e) {
       alert(e);
     }
   });
});
});

//Posta Kodu
$(document).ready(function() {
$("#neighborhoods").change(function() {
 var neighborhoods = $(this).find(":selected").val();
 var district = $('#district').val();
 
 // alert(district);
 $.ajax({
      url:'/trZipcode', 
      type: 'POST',  // http method
      data: {district:district,neighborhoods:neighborhoods},
      success: function (data) {
        // alert(data[0].postakodu );
        $('#postcode').val(data[0].postakodu );
        
      },
      error : function(e) {
       alert(e);
     }
   });
});
});



//---------------------------------------------------------------
//-------------------Turkiye Adres Listesi Save------------------
//--Mehmet ÜLKER-------------------------------------------------



</script>


</head>

<body>

	<!--AdresSave-->
	<div class="modal" id="u1">
		<div class="modal-dialog modal-adres">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title">Adres Bilgileri</h4>
				</div>
				<div class="modal-body">


					<ul class="form-style-1">
						<li><label>Adres adı<span class="required"></span></label> <input
							type="text" name="useradresname" " id="adressname"
							class="field-long" placeholder="Örnek Evim,İşim vb." /></li>
						<li><b>Adı</b>&emsp; &emsp; &emsp; &emsp; &emsp; &emsp;&emsp;
							&emsp; &emsp; &emsp; &emsp;<b>Soyadı</b> <br> <input
							type="text" name="name" id="name" class="field-divided"
							placeholder="Adınızı giriniz." /> <input type="text"
							name="surname" id="surname" class="field-divided"
							placeholder="Soyadınızı giriniz." /></li>
						<li><label>Şirket <span class="required"></span></label> <input
							type="text" name="companyname" id="companyname"
							class="field-long"
							placeholder="Şirket Adına alınıyor ise şirket isimini giriniz." />
						</li>
						<li><label>İL</label> <select name="city" id="city"
							class="field-select">



						</select></li>
						<li><label>İlçe</label> <select name="town" id="town"
							class="field-select">
						</select> </select></li>
						<li><label>Semt</label> <select name="district" id="district"
							class="field-select">
						</select> </select></li>
						<li><label>Mahalle</label> <select name="neighborhoods"
							id="neighborhoods" class="field-select">
						</select>
						<li><b>Posta Kodu</b>&emsp; &emsp; &emsp; &emsp; &emsp;
							&emsp; &emsp; &emsp;<b>Telefon</b> <br> <input type="text"
							name="postcode" id="postcode" name="postcode"
							class="field-divided" placeholder="Posta kodunu giriniz" /> <input
							type="text" name="phone" id="phone" class="field-divided"
							placeholder="Telefon numaranızı giriniz." /></li>
						<li>
						<li><label>Sipariş notunu giriniz<span
								class="required"></span></label> <textarea name="ordernote"
								id="ordernote" class="field-long field-textarea"
								placeholder="Posta kodunu giriniz" /> </textarea></li>
						<button class="btn btn-primary" onclick="save();">KAYDET</button>

					</ul>

				</div>
			</div>
		</div>
	</div>
	<!--AdresSave Popup Close -->




</body>
</html>