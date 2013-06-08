<%@ page language="java" contentType="text/html; charset=GBK"%>     
<html>     
<head>     
<title>股票筛选器-标签页版</title>    
<script src="jquery/jquery-1.3.2.min.js" type="text/javascript"></script>    
<link rel="stylesheet" href="css/themes/base/jquery.ui.all.css">
<link rel="stylesheet" href="css/css.css">
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
// 选项卡
$(function(){
	$(".tab dl dt>a:first").addClass("tabActive");
	$(".tab dl dd ul").not(":first").hide();
	$(".tab dl dt>a").unbind("click").bind("click", function(){
		$(this).siblings("a").removeClass("tabActive").end().addClass("tabActive");
		var index = $(".tab dl dt>a").index( $(this) );
		$(".tab dl dd ul").eq(index).siblings(".tab dl dd ul").hide().end().fadeIn("slow");
   });
});
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
	<style type="text/css">
	/* 选项卡 */
	.tab{width:100%;border:#ccc 1px solid;margin:0px;}
	.tab dl dt{ border-bottom:#ccc 1px solid;height:25px;background:#f1f1f1; margin-bottom:-1px;}
	.tab dl dt a{float:left;display:block;cursor:pointer;width:80px;height:25px;line-height:25px;text-align:center;background:#f1f1f1;color:#000;}
	.tab dl dt a.tabActive{background:#fff;color:#333;font-weight:bold;border-bottom:1px solid #fff;position:relative;border-right:1px solid #ccc;border-left:1px solid #ccc;}
	.tab dl dd{padding:2px; clear:both;}
	</style>   
</head>     
<body>    

<form id="form1" name="form1" method="post"> 
<div class="tab">
	<dl>
    <dt><a>VALUATION</a><a>FINANCIAL</a><a>OWNERSHIP</a><a>PERFORMANCE</a></dt>
		<dd>
            <ul>Explain Something...
            <table border="0" cellspacing="5" cellpadding="0">
	 <tr id="pe" style="display:inline;">
		<td>P/E Value</td><td><input type="text" name="pe1" id="pe1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="pe" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="pe2" id="pe2" class="input_slider"/></td>
	 </tr>
	 <tr id="fwdpe" style="display:inline;">	
		<td>FWD P/E</td><td><input type="text" name="fwdpe1" id="fwdpe1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="fwdpe" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="fwdpe2" id="fwdpe2" class="input_slider"/></td>
	</tr>
	<tr id="peg" style="display:inline;">	
		<td>PEG VALUE</td><td><input type="text" name="peg1" id="peg1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="peg" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="peg2" id="peg2" class="input_slider"/></td>
	</tr>
	<tr id="ps" style="display:inline;">
		<td>P/S Value</td><td><input type="text" name="ps1" id="ps1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="ps" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="ps2" id="ps2" class="input_slider"/></td>
	 </tr>
	 <tr id="pb" style="display:inline;">	
		<td>P/B Value</td><td><input type="text" name="pb1" id="pb1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="pb" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="pb2" id="pb2" class="input_slider"/></td>
	</tr>
	<tr id="pc" style="display:inline;">	
		<td>P/C VALUE</td><td><input type="text" name="pc1" id="pc1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="pc" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="pc2" id="pc2" class="input_slider"/></td>
	</tr>
	<tr id="pfcf" style="display:inline;">	
		<td>P/FCF VALUE</td><td><input type="text" name="pfcf1" id="pfcf1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="pfcf" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="pfcf2" id="pfcf2" class="input_slider"/></td>
	</tr>
	<tr id="epsthisy" style="display:inline;">	
		<td>EPS this Y</td><td><input type="text" name="epsthisy1" id="epsthisy1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="epsthisy" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="epsthisy2" id="epsthisy2" class="input_slider"/></td>
	</tr>
	<tr id="epsnexty" style="display:inline;">	
		<td>EPS next Y</td><td><input type="text" name="epsnexty1" id="epsnexty1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="epsnexty" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="epsnexty2" id="epsnexty2" class="input_slider"/></td>
	</tr>
	<tr id="epspast5y" style="display:inline;">	
		<td>EPS past 5Y</td><td><input type="text" name="epspast5y1" id="epspast5y1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="epspast5y" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="epspast5y2" id="epspast5y2" class="input_slider"/></td>
	</tr>
	<tr id="epsnext5y" style="display:inline;">	
		<td>EPS next 5Y</td><td><input type="text" name="epsnext5y1" id="epsnext5y1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="epsnext5y" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="epsnext5y2" id="epsnext5y2" class="input_slider"/></td>
	</tr>
	<tr id="salespast5y" style="display:inline;">	
		<td>Sales past 5Y</td><td><input type="text" name="salespast5y1" id="salespast5y1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="salespast5y" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="salespast5y2" id="salespast5y2" class="input_slider"/></td>
	</tr>
</table></ul>
            <ul>Explain Something...
  <table border="0" cellspacing="5" cellpadding="0">
	 <tr id="dividend" style="display:inline;">
		<td>Dividend</td><td><input type="text" name="dividend1" id="dividend1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="dividend" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="dividend2" id="dividend2" class="input_slider"/></td>
	 </tr>
	 <tr id="roa" style="display:inline;">	
		<td>ROA VALUE</td><td><input type="text" name="roa1" id="roa1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="roa" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="roa2" id="roa2" class="input_slider"/></td>
	</tr>
	<tr id="roe" style="display:inline;">	
		<td>ROE VALUE</td><td><input type="text" name="roe1" id="roe1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="roe" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="roe2" id="roe2" class="input_slider"/></td>
	</tr>
	<tr id="roi" style="display:inline;">
		<td>ROI Value</td><td><input type="text" name="roi1" id="roi1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="roi" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="roi2" id="roi2" class="input_slider"/></td>
	 </tr>
	 <tr id="currr" style="display:inline;">	
		<td>Curr R</td><td><input type="text" name="currr1" id="currr1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="currr" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="currr2" id="currr2" class="input_slider"/></td>
	</tr>
	<tr id="quickr" style="display:inline;">	
		<td>Quick R</td><td><input type="text" name="quickr1" id="quickr1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="quickr" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="quickr2" id="quickr2" class="input_slider"/></td>
	</tr>
	<tr id="ltdebt" style="display:inline;">	
		<td>LTDebt/Eq</td><td><input type="text" name="ltdebt1" id="ltdebt1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="ltdebt" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="ltdebt2" id="ltdebt2" class="input_slider"/></td>
	</tr>
	<tr id="debt" style="display:inline;">	
		<td>Debt/Eq</td><td><input type="text" name="debt1" id="debt1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="debt" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="debt2" id="debt2" class="input_slider"/></td>
	</tr>
	<tr id="gross" style="display:inline;">	
		<td>Gross MARGIN</td><td><input type="text" name="gross1" id="gross1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="gross" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="gross2" id="gross2" class="input_slider"/></td>
	</tr>
	<tr id="operation" style="display:inline;">	
		<td>Operation MARGIN</td><td><input type="text" name="operation1" id="operation1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="operation" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="operation2" id="operation2" class="input_slider"/></td>
	</tr>
	<tr id="profit" style="display:inline;">	
		<td>Profit MARGIN</td><td><input type="text" name="profit1" id="profit1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="profit" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="profit2" id="profit2" class="input_slider"/></td>
	</tr>
	<tr id="earnings" style="display:inline;">	
		<td>Earnings</td><td><input type="text" name="earnings1" id="earnings1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="earnings" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="earnings2" id="earnings2" class="input_slider"/></td>
	</tr>
</table>
            </ul>
            
<ul>Explain Something...
  <table border="0" cellspacing="5" cellpadding="0">
	 <tr id="outstanding" style="display:inline;">
		<td>Outstanding</td><td><input type="text" name="outstanding1" id="outstanding1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="outstanding" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="outstanding2" id="outstanding2" class="input_slider"/></td>
	 </tr>
	 <tr id="float" style="display:inline;">	
		<td>Float</td><td><input type="text" name="float1" id="float1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="float" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="float2" id="float2" class="input_slider"/></td>
	</tr>
	<tr id="insiderown" style="display:inline;">
		<td>Insider Own</td><td><input type="text" name="insiderown1" id="insiderown1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="insiderown" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="insiderown2" id="insiderown2" class="input_slider"/></td>
	 </tr>
	 <tr id="insidertrans" style="display:inline;">	
		<td>Insider Trans</td><td><input type="text" name="insidertrans1" id="insidertrans1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="insidertrans" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="insidertrans2" id="insidertrans2" class="input_slider"/></td>
	</tr>
	<tr id="instiown" style="display:inline;">	
		<td>Institution Own</td><td><input type="text" name="instiown1" id="instiown1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="instiown" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="instiown2" id="instiown2" class="input_slider"/></td>
	</tr>
	<tr id="institrans" style="display:inline;">	
		<td>Institution Trans</td><td><input type="text" name="institrans1" id="institrans1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="institrans" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="institrans2" id="institrans2" class="input_slider"/></td>
	</tr>
	<tr id="floatshort" style="display:inline;">	
		<td>Float Short</td><td><input type="text" name="floatshort1" id="floatshort1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="floatshort" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="floatshort2" id="floatshort2" class="input_slider"/></td>
	</tr>
	<tr id="shortratio" style="display:inline;">	
		<td>Short Ratio</td><td><input type="text" name="shortratio1" id="shortratio1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="shortratio" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="shortratio2" id="shortratio2" class="input_slider"/></td>
	</tr>
</table>
</ul>
            <ul>Explain Something...
  <table border="0" cellspacing="5" cellpadding="0">
	 <tr id="perfweek" style="display:inline;">
		<td>Perf Week</td><td><input type="text" name="perfweek1" id="perfweek1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="perfweek" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="perfweek2" id="perfweek2" class="input_slider"/></td>
	 </tr>
	 <tr id="perfmonth" style="display:inline;">	
		<td>Perf Month</td><td><input type="text" name="perfmonth1" id="perfmonth1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="perfmonth" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="perfmonth2" id="perfmonth2" class="input_slider"/></td>
	</tr>
	<tr id="perfquart" style="display:inline;">	
		<td>Perf Quart</td><td><input type="text" name="perfquart1" id="perfquart1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="perfquart" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="perfquart2" id="perfquart2" class="input_slider"/></td>
	</tr>
	<tr id="perfhalf" style="display:inline;">
		<td>Perf Half</td><td><input type="text" name="perfhalf1" id="perfhalf1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="perfhalf" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="perfhalf2" id="perfhalf2" class="input_slider"/></td>
	 </tr>
	 <tr id="perfyear" style="display:inline;">	
		<td>Perf Year</td><td><input type="text" name="perfyear1" id="perfyear1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="perfyear" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="perfyear2" id="perfyear2" class="input_slider"/></td>
	</tr>
	<tr id="perfytd" style="display:inline;">	
		<td>Perf YTD</td><td><input type="text" name="perfytd1" id="perfytd1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="perfytd" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="perfytd2" id="perfytd2" class="input_slider"/></td>
	</tr>
	<tr id="volatilityw" style="display:inline;">	
		<td>Volatility W</td><td><input type="text" name="volatilityw1" id="volatilityw1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="volatilityw" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="volatilityw2" id="volatilityw2" class="input_slider"/></td>
	</tr>
	<tr id="volatilitym" style="display:inline;">	
		<td>Volatility M</td><td><input type="text" name="volatilitym1" id="volatilitym1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="volatilitym" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="volatilitym2" id="volatilitym2" class="input_slider"/></td>
	</tr>
	<tr id="reco" style="display:inline;">	
		<td>Recommendation</td><td><input type="text" name="reco1" id="reco1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="reco" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="reco2" id="reco2" class="input_slider"/></td>
	</tr>
	<tr id="avgvolume" style="display:inline;">	
		<td>Avg Volume</td><td><input type="text" name="avgvolume1" id="avgvolume1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="avgvolume" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="avgvolume2" id="avgvolume2" class="input_slider"/></td>
	</tr>
	<tr id="relvolume" style="display:inline;">	
		<td>Rel Volume</td><td><input type="text" name="relvolume1" id="relvolume1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="relvolume" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="relvolume2" id="relvolume2" class="input_slider"/></td>
	</tr>
	<tr id="price" style="display:inline;">	
		<td>Price</td><td><input type="text" name="price1" id="price1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="price" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="price2" id="price2" class="input_slider"/></td>
	</tr>
	<tr id="change" style="display:inline;">	
		<td>Change</td><td><input type="text" name="change1" id="change1" class="input_slider"/></td>
		<td width=200><label for="amount"></label><div class="slider" data-name="change" data-min="0" data-max="100"></div></td>
		<td><input type="text" name="change2" id="change2" class="input_slider"/></td>
	</tr>
</table>
            </ul>
         </dd>
         	
	</dl>
</div>
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
