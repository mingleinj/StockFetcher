<%@ page language="java" contentType="text/html; charset=GBK"%>     
<html>     
<head>     
<title>Ê¹ÓÃJSON²å¼þ</title>    
<script src="jquery/jquery-1.3.2.min.js" type="text/javascript"></script>    
<link rel="stylesheet" href="css/themes/base/jquery.ui.all.css">
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/ui/jquery.ui.core.js"></script>
<script src="scripts/ui/jquery.ui.widget.js"></script>
<script src="scripts/ui/jquery.ui.mouse.js"></script>
<script src="scripts/ui/jquery.ui.sortable.js"></script>
<script src="scripts/ui/jquery.ui.tabs.js"></script>
<script src="scripts/ui/jquery.ui.position.js"></script>
<script src="scripts/ui/jquery.ui.menu.js"></script>
<script src="scripts/ui/jquery.ui.slider.js"></script>
<script src="scripts/ui/jquery.ui.tooltip.js"></script>
<script language="javascript">
function show(id)
{
	document.getElementById(id).style.display="inline";
}
function hide(id)
{
	document.getElementById(id).style.display="none";
}
</script>
<script>
	var a1;var a2;var a3;var a4;var a5;var a6;var a7;var a8;var a9;var a10;

	$(function() {
			
			$('.slider').each(function(){
				
				var $el = $(this);
				
				$el.slider({
					range: true,
					min: $el.data('min'),
					max: $el.data('max'),
					values: [ $el.data('min'), $el.data('max') ],
					slide: function( event, ui ) {
						var name = $el.data('name');
						if($("#"+name).css("display")=='inline'){
							$( "#"+name+"1" ).val($el.slider( "values", 0 ));
							$( "#"+name+"2" ).val($el.slider( "values", 1 ));
						}else{
							$( "#"+name+"1" ).val($el.data('min'));
							$( "#"+name+"2" ).val($el.data('max'));
						}
						
					},
					change: function(event, ui) {				 		
				 		var data = {};					 		
				 		// build payload
				 		$('.slider').each(function(){
				 			var $el = $(this);
				 			var name = $el.data('name');
							//alert($("#"+name).css("display"));
							if($("#"+name).css("display")=='inline'){
								data[name] = {
				 				1: $el.slider("values", 0 ),
				 				2: $el.slider("values", 1 )
				 				};
							}else{
								data[name] = {
				 				1: $el.data('min'),
				 				2: $el.data('max')
				 				};
							}
				 		});
				 		
				 		jQuery.ajax({
		                    type: 'POST',
		                    url: 'stockInformation',
		                    dataType: 'json',
		                    async:true,
		                    data: data,
		                    //data: 'amount1=' + a1+'&amount2='+a2+'&amount3=' + a3+'&amount4='+a4+'&amount5=' + a5+'&amount6='+a6+'&amount7=' + a7+'&amount8='+a8+'&amount9=' + a9+'&amount10='+a10,
		                    success: function( data, textStatus, jqXHR) {
		                        //our stock code was correct so we have some information to display
		                         if(data.success){
		                             $("#ajaxResponse").html("");
		                             $("#ajaxResponse").append("<table border=\"1\" width=\"100%\">");
		                             $("#ajaxResponse").append("<tr><th>stock ticker</td></th><th>stock pe</th><th>stock marketcap</th><th>stock price</th></tr>");	
		                         
		                             for(var stock in data.stockInfo)
		                             {	 
		                            	$("#ajaxResponse").append("<tr><td width=\"25%\">" + data.stockInfo[stock].ticker + "</td><td width=\"25%\"> " + data.stockInfo[stock].pe + "</td><td width=\"25%\">" + data.stockInfo[stock].marketcap + "</td><td width=\"25%\">" + data.stockInfo[stock].price + "</td></tr>"); 
		                             
		                             	//$("#ajaxResponse").append("<p></p>"); 
		                             }
		                             $("#ajaxResponse").append("</table>");
		                         } 
		                         //display error message
		                         else {
		                             $("#ajaxResponse").html("<div><b>Stock code in Invalid!</b></div>");
		                         }
		                    }
				 		
		                });
			
				 	}
				});
				
				var name = $el.data('name');
				$( "#"+name+"1" ).val($el.slider( 'option', 'min'));
				$( "#"+name+"2" ).val($el.slider( 'option', 'max' ));
				
			});
			
	
	});
		
		
	</script>
	<style>
		.ui-menu { width: 270px; }
	</style>     
</head>     
<body>     
<form id="form1" name="form1" method="post">  
<div><input type="button" name="Submit" value="Add MarketCap" onclick="show('marketcap')" />
<input type="button" name="Submit" value="Add Price" onclick="show('price')" />
<input type="button" name="Submit" value="Add Change" onclick="show('change')" />
<input type="button" name="Submit" value="Add Value" onclick="show('value')" />
</div> 
<table border="0" cellspacing="5" cellpadding="0">
	 <tr id="pe" style="display:inline;">
		<td>PE Value</td><td><input type="text" name="pe1" id="pe1" style="width:80px;text-align:right;border:0; color:#f6931f; font-weight:bold;" /></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="pe" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="pe2" id="pe2" style="width:80px;border:0; color:#f6931f; font-weight:bold;" /></td>
	</tr>
	<tr id="marketcap" style="display:none;">
		<td>MarketCap</td><td><input type="text" name="marketcap1" id="marketcap1" style="width:80px;text-align:right;border:0; color:#f6931f; font-weight:bold;" /></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="marketcap" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="marketcap2" id="marketcap2" style="width:80px;border:0; color:#f6931f; font-weight:bold;" /></td>
		<td><a href='javascript:;' onclick="hide('marketcap')">del</a></td>
	</tr>
	<tr id="price" style="display:none;">
		<td>Price</td><td><input type="text" name="price1" id="price1" style="width:80px;text-align:right;border:0; color:#f6931f; font-weight:bold;" /></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="price" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="price2" id="price2" style="width:80px;border:0; color:#f6931f; font-weight:bold;" /></td>
		<td><a href='javascript:;' onclick="hide('price')">del</a></td>
	</tr>
	<tr id="change" style="display:none;">
		<td>Changes</td><td><input type="text" name="change1" id="change1" style="width:80px;text-align:right;border:0; color:#f6931f; font-weight:bold;" /></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="change" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="change2" id="change2" style="width:80px;border:0; color:#f6931f; font-weight:bold;" /></td>
		<td><a href='javascript:;' onclick="hide('change')">del</a></td>
	</tr>
	<tr id="value" style="display:none;">
		<td>Volume</td><td><input type="text" name="value1" id="value1" style="width:80px;text-align:right;border:0; color:#f6931f; font-weight:bold;" /></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="value" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="value2" id="value2" style="width:80px;border:0; color:#f6931f; font-weight:bold;" /></td>
		<td><a href='javascript:;' onclick="hide('value')">del</a></td>
	</tr>
</table>  
</form>     
<div id="show"> 
</div>  
<div id="anotherSection">
        <fieldset>
            <legend>Stocks from jQuery Ajax Request</legend>
                 <div id="ajaxResponse"></div>
        </fieldset>
    </div>   
</body>     
</html>    
