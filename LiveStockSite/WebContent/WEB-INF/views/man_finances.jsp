<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Finances </title>
	<link rel="stylesheet" href="gen.css" />
	<link rel="stylesheet" href="manEmp.css" />
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js">
	</script>
	<script type="text/javascript">

// <!CDATA[
$(document).ready(function(){
	console.log("finances!");	
	$("#finances").addClass('active');

	$('.inputA').click(function(event) {
  	event.stopPropagation();
	});

	// Show the first utility as selected
  $('.current').children('.description').show();

  // Close the current tab on click 
  $('.utility').click(function() {
    $('.utility').removeClass('current');
    $('.description').hide();
  // Open the new current tab
    $(this).addClass('current');
    $(this).children('.description').show();
   });

});

function deleteEmp_onclick() {
    console.log("deleteEmp!");
    javascript:deleteEmployeeForm.submit();
}

function ecYear_onclick() {
    console.log("ecYear!");
    window.open("ecYear","_self");
}

function sales_onclick() {
    console.log("sales!");
    javascript:salesReportForm.submit();
}

function stockRev_onclick() {
    console.log("editEmp!");
    javascript:stockRevenueForm.submit();
}

function stockTypeRev_onclick() {
    console.log("editEmp!");
    javascript:stockTypeRevenueForm.submit();
}

function cusRev_onclick() {
    console.log("editEmp!");
    javascript:customerRevenueForm.submit();
}
// ]]>

	</script>
	
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_man_menu.jsp"></jsp:include>
	<c:set var="me" scope="session" value="${id}"/>
	<div class="body" align="center">
	<h2>Transactions</h2>
	<table border="5" id="accounts">
			<tr>
	          <th style="width: 150px"><span style="font-size: 10pt">Transaction Id</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Order Id</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Fee</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Time</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Price Per Share</span></th>
	        </tr>
			<c:forEach var="trans" items="${transactions}">							
				<tr>
		            <td style="width: 50px"><span style="font-size: 10pt"><c:out value="${trans.id}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${trans.orderId}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${trans.fee}" /></span></td>
		            <td style="width: 200px"><span style="font-size: 10pt"><c:out value="${trans.time}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${trans.pps}" /></span></td>	
		        </tr>	            
		    </c:forEach>
	    </table>
	</div>
	<div class="utilities container">  
      <!-- Utility -->
      <div class="utility current">
        <div class="item row">
          <div class="col-xs-3">
             <h3>Sales Report</h3>
          </div>
        </div>
        <div class="description row">
        <table>          
            <form id="salesReport" name="salesReportForm" action="salesReport" method="post">
            <tr>
            	<td>Month:</td>
            	<td>            		
            		<select name="month" class="inputA">						    
					    <option value="january" selected="selected">January</option>
					    <option value="february">February</option>
					    <option value="march">March</option>
					    <option value="april">April</option>
					    <option value="may">May</option>
					    <option value="june">June</option>
					    <option value="july">July</option>
					    <option value="august">August</option>
					    <option value="september">September</option>
					    <option value="october">October</option>
					    <option value="november">November</option>
					    <option value="december">December</option>
					</select>
            	</td> 
            </tr>
            <tr>
            	<td>Year:</td>
		  		<td><input type="text" name="year" class="inputA" placeholder="yyyy"></td>  
		  	</tr>          	
			</form>  
		</table>    
		<br>
		<button value="sales" class="btn-default" id="sales" onclick="return sales_onclick()">Confirm</button>     
        </div>
      </div>
      <!-- Utility -->
      <div class="utility">
        <div class="item row">
          <div class="col-xs-3">
            <h3>Employee and Customer of the Year</h3>
          </div>
        </div>
        <div class="description row">          
		<button value="ecYear" class="btn-default" id="ecYearButton" onclick="return ecYear_onclick()">Go</button>  
        </div>
      </div>     
      <!-- Utility -->
      <div class="utility">
        <div class="item row">
          <div class="col-xs-3">
            <h3>Summary of Revenue By Stock</h3>
          </div>
        </div>
        <div class="description row">
	        <form id="stockRevenue" name="stockRevenueForm" action="revenueStocks" method="post">
	        <table>
	        	<tr>
	        		<td>Stock Symbol:</td>
	        		<td><select name="stockEdit" class="inputA">
						    <c:forEach var="stock" items="${stocksyms}">
						    <option value="${stock}"><c:out value="${stock}" /></option>
						    </c:forEach>
						</select>
            		</td>
	        	</tr>
	        </table>
	        <input type="hidden" name="selection" value="1" />
	        <button value="stockRev" class="btn-default" id="stockRevButton" onclick="return stockRev_onclick()">Go</button>
			</form>
        </div>
      </div>       
      <!-- Utility -->
      <div class="utility">
        <div class="item row">
          <div class="col-xs-3">
            <h3>Summary of Revenue By Stock Type</h3>
          </div>
        </div>
        <div class="description row">          
		<form id="stockTypeRevenue" name="stockTypeRevenueForm" action="revenueStockTypes" method="post">
	        <table>
	        	<tr>
	        		<td>Stock Type:</td>
	        		<td><select name="typeEdit" class="inputA">
						    <c:forEach var="type" items="${types}">
						    <option value="${type}"><c:out value="${type}" /></option>
						    </c:forEach>
						</select>
            		</td>
	        	</tr>
	        </table>
	        <input type="hidden" name="selection" value="2" />
	        <button value="stockTypeRev" class="btn-default" id="stockTypeRevButton" onclick="return stockTypeRev_onclick()">Go</button>
			</form>
        </div>
      </div>     
      <!-- Utility -->
      <div class="utility">
        <div class="item row">
          <div class="col-xs-3">
            <h3>Summary of Revenue By Customer</h3>
          </div>
        </div>
        <div class="description row">          
		<form id="customerRevenue" name="customerRevenueForm" action="revenueCustomers" method="post">
	        <table>
	        	<tr>
	        		<td>Customer:</td>
	        		<td><select name="cusIdEdit" class="inputA">
						    <c:forEach var="cus" items="${customers}">
						    <option value="${cus.id}"><c:out value="${cus.id}" />: <c:out value="${cus.fname}" /> <c:out value="${cus.lname}" /></option>
						    </c:forEach>
						</select>
            		</td>
	        	</tr>
	        </table>
	        <input type="hidden" name="selection" value="3" />
	        <button value="cusRev" class="btn-default" id="cusRevButton" onclick="return cusRev_onclick()">Go</button>
			</form>  
        </div>
      </div>
    </div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>