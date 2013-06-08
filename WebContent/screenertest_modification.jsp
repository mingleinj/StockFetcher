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
	<script>
	var a1;var a2;var a3;var a4;var a5;var a6;var a7;var a8;var a9;var a10;
	/* var amount = [{ "name": "pe", "minimum":"0","maximum": "99999.999" },
	               { "name": "marketcap", "minimum": "0", "maximum":"425976.39" },
	               { "name": "price", "minimum": "0", "maximum":"147086.19" },
	               { "name": "change", "minimum": "0", "maximum":"583.67" },
	               { "name": "volume", "minimum": "-28", "maximum":"159684480" }];
 */
	$(function() {
		
			/* $( "#sr1" ).slider({
				range: true,
				min: 0,
				max: 99999.999,
				values: [ 0, 99999.999 ],
				slide: function( event, ui ) {
					$( "#amount1" ).val($( "#sr1" ).slider( "values", 0 ));
					$( "#amount2" ).val($( "#sr1" ).slider( "values", 1 ));
					a1=$( "#sr1" ).slider( "values", 0 );
					a2=$( "#sr1" ).slider( "values", 1 );	
				}
			});
			$( "#sr2" ).slider({
				range: true,
				min: 0,
				max: 425976.39,
				values: [ 0, 425976.39 ],
				slide: function( event, ui ) {
					$( "#amount3" ).val($( "#sr2" ).slider( "values", 0 ));
					$( "#amount4" ).val($( "#sr2" ).slider( "values", 1 ));
					a3=$( "#sr2" ).slider( "values", 0 );
					a4=$( "#sr2" ).slider( "values", 1 );	
				}
			});
			$( "#sr3" ).slider({
				range: true,
				min: 0,
				max: 147086.19,
				values: [ 0, 147086.19 ],
				slide: function( event, ui ) {
					$( "#amount5" ).val($( "#sr3" ).slider( "values", 0 ));
					$( "#amount6" ).val($( "#sr3" ).slider( "values", 1 ));
					a5=$( "#sr3" ).slider( "values", 0 );
					a6=$( "#sr3" ).slider( "values", 1 );	
				}
			});
			$( "#sr4" ).slider({
				range: true,
				min: -44,
				max: 583.67,
				values: [ -44, 583.67 ],
				slide: function( event, ui ) {
					$( "#amount7" ).val($( "#sr4" ).slider( "values", 0 ));
					$( "#amount8" ).val($( "#sr4" ).slider( "values", 1 ));
					a7=$( "#sr4" ).slider( "values", 0 );
					a8=$( "#sr4" ).slider( "values", 1 );	
				}
			});
			$( "#sr5" ).slider({
				range: true,
				min: -28,
				max: 159684480,
				values: [ -28, 159684480 ],
				slide: function( event, ui ) {
					$( "#amount9" ).val($( "#sr5" ).slider( "values", 0 ));
					$( "#amount10" ).val($( "#sr5" ).slider( "values", 1 ));
					a9=ui.values[ 0 ];
					a10=ui.values[ 1 ];
					//alert(a9);
				}
			}); */
 
			/*$( "#amount1" ).val($("#sr1").slider("option", "min"));
			$( "#amount2" ).val($("#sr1").slider("option", "max"));
			$( "#amount3" ).val($("#sr2").slider("option", "min"));
			$( "#amount4" ).val($("#sr2").slider("option", "max"));
			$( "#amount5" ).val($("#sr3").slider("option", "min"));
			$( "#amount6" ).val($("#sr3").slider("option", "max"));
			$( "#amount7" ).val($("#sr4").slider("option", "min"));
			$( "#amount8" ).val($("#sr4").slider("option", "max"));
			$( "#amount9" ).val($("#sr5").slider("option", "min"));
			$( "#amount10" ).val($("#sr5").slider("option", "max")); */
			
			/* a1=$("#sr1").slider("option", "min");
			a2=$("#sr1").slider("option", "max");
			a3=$("#sr2").slider("option", "min");
			a4=$("#sr2").slider("option", "max");
			a5=$("#sr3").slider("option", "min");
			a6=$("#sr3").slider("option", "max");
			a7=$("#sr4").slider("option", "min");
			a8=$("#sr4").slider("option", "max");
			a9=$("#sr5").slider("option", "min");
			a10=$("#sr5").slider("option", "max"); */
			
			$('.slider').each(function(){
				
				var $el = $(this);
				
				$el.slider({
					range: true,
					min: $el.data('min'),
					max: $el.data('max'),
					values: [ $el.data('min'), $el.data('max') ],
					slide: function( event, ui ) {
						/* console.log(arguments); */
						$( "#amountLeft" ).val($el.slider( "values", 0 ));
						$( "#amountRight" ).val($el.slider( "values", 1 ));
						a1=$( $el.slider( "values", 0 ));
						a2=$( $el.slider( "values", 1 ));	
					},
					change: function(event, ui) {
				 		
				 		var data = {};
				 		
				 		// build payload
				 		$('.slider').each(function(){
				 			var $el = $(this);
				 			var name = $el.data('name');
				 			data[name] = {
				 				min: $el.slider('option', 'min'),
				 				max: $el.slider('option', 'max')
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
				
			});
			
			/* $( "#sr2" ).slider({
			 	change: function(event, ui) {
			 		jQuery.ajax({
	                    type: 'POST',
	                    url: 'stockInformation',
	                    dataType: 'json',
	                    async:true, 
	                    data: 'amount1=' + a1+'&amount2='+a2+'&amount3=' + a3+'&amount4='+a4+'&amount5=' + a5+'&amount6='+a6+'&amount7=' + a7+'&amount8='+a8+'&amount9=' + a9+'&amount10='+a10,
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
			$( "#sr3" ).slider({
			 	change: function(event, ui) {
			 		jQuery.ajax({
	                    type: 'POST',
	                    url: 'stockInformation',
	                    dataType: 'json',
	                    async:true, 
	                    data: 'amount1=' + a1+'&amount2='+a2+'&amount3=' + a3+'&amount4='+a4+'&amount5=' + a5+'&amount6='+a6+'&amount7=' + a7+'&amount8='+a8+'&amount9=' + a9+'&amount10='+a10,
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
			$( "#sr4" ).slider({
			 	change: function(event, ui) {
			 		jQuery.ajax({
	                    type: 'POST',
	                    url: 'stockInformation',
	                    dataType: 'json',
	                    async:true, 
	                    data: 'amount1=' + a1+'&amount2='+a2+'&amount3=' + a3+'&amount4='+a4+'&amount5=' + a5+'&amount6='+a6+'&amount7=' + a7+'&amount8='+a8+'&amount9=' + a9+'&amount10='+a10,
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
			$( "#sr5" ).slider({
			 	change: function(event, ui) {
			 		jQuery.ajax({
	                    type: 'POST',
	                    url: 'stockInformation',
	                    dataType: 'json',
	                    async:true, 
	                    data: 'amount1=' + a1+'&amount2='+a2+'&amount3=' + a3+'&amount4='+a4+'&amount5=' + a5+'&amount6='+a6+'&amount7=' + a7+'&amount8='+a8+'&amount9=' + a9+'&amount10='+a10,
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
			});	 */
	});
		
		
	</script>
	<style>
		.ui-menu { width: 270px; }
	</style>     
</head>     
<body>     
<form id="form1" name="form1" method="post">   
<table border="0" cellspacing="5" cellpadding="0">
	 <tr>
		<td>PE Value</td><td><input type="text" name="amount1" id="amount1" style="width:80px;text-align:right;border:0; color:#f6931f; font-weight:bold;" /></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="pe" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="amount2" id="amount2" style="width:80px;border:0; color:#f6931f; font-weight:bold;" /></td>
	</tr>
	<tr>
		<td>MarketCap</td><td><input type="text" name="amount3" id="amount3" style="width:80px;text-align:right;border:0; color:#f6931f; font-weight:bold;" /></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="marketcap" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="amount4" id="amount4" style="width:80px;border:0; color:#f6931f; font-weight:bold;" /></td>
	</tr>
	<tr>
		<td>Price</td><td><input type="text" name="amount5" id="amount5" style="width:80px;text-align:right;border:0; color:#f6931f; font-weight:bold;" /></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="price" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="amount6" id="amount6" style="width:80px;border:0; color:#f6931f; font-weight:bold;" /></td>
	</tr>
	<tr>
		<td>Changes</td><td><input type="text" name="amount7" id="amount7" style="width:80px;text-align:right;border:0; color:#f6931f; font-weight:bold;" /></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="change" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="amount8" id="amount8" style="width:80px;border:0; color:#f6931f; font-weight:bold;" /></td>
	</tr>
	<tr>
		<td>Volume</td><td><input type="text" name="amount9" id="amount9" style="width:80px;text-align:right;border:0; color:#f6931f; font-weight:bold;" /></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="value" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="amount10" id="amount10" style="width:80px;border:0; color:#f6931f; font-weight:bold;" /></td>
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
