<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/series-label.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<title>PetMeeting - 관리자</title>
<style type="text/css">
div.todaySales {
	text-align: center;
	font-size: 30px;
	font-weight: 600;
	background: #f0f0f0;
	padding: 20px 0;
	margin: 50px 0;
	border-radius: 10px;
}
div#monthly-sales, div#product-Top5 {
	margin-bottom: 100px;
}
</style>
</head>
<body>
<div id="right-panel" class="right-panel">
	<!--::header part start::-->
		<jsp:include page="/admin_resources/admincss/templates/adminheader.jsp" flush="false"/>
	<!-- Header part end-->
	<!-- Content -->
	<div class="content">
		<div class="container">
			<div class="todaySales">
				오늘의 매출 : <fmt:formatNumber value="${todaySales }" pattern="#,###"/>원
			</div>
			<div id="monthly-sales"></div>
			<div id="product-Top5"></div>
		</div>
	</div>
</div>
<script type="text/javascript">
Highcharts.chart('monthly-sales', {

    title: {
        text: '2019년도 월별 매출'
    },
	 xAxis: {
	     categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
	         'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
	 },
 
    yAxis: {
        title: {
            text: '매출액(원)'
        }
    },
    legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'middle'
    },

    series: [{
        name: '총 합계',
        data: ${jsonTotal }
    }, {
        name: '의류',
        data: ${jsonCloth }
    }, {
        name: '악세사리',
        data: ${jsonAcce }
    }, {
        name: '반려용품',
        data: ${jsonPet }
    }, {
        name: '기타',
        data: ${jsonEtc }
    }],

    responsive: {
        rules: [{
            condition: {
                maxWidth: 500
            },
            chartOptions: {
                legend: {
                    layout: 'horizontal',
                    align: 'center',
                    verticalAlign: 'bottom'
                }
            }
        }]
    }

});
 
Highcharts.chart('product-Top5', {
    chart: {
        type: 'column'
    },
    title: {
        text: '제품별 매출액'
    },
    xAxis: {
        type: 'category'
    },
    yAxis: {
        title: {
            text: '매출액(원)'
        }

    },
    legend: {
        enabled: false
    },
    plotOptions: {
        series: {
            borderWidth: 0,
            dataLabels: {
                enabled: true,
            }
        }
    },
    series: [
        {
            name: "Sales",
            colorByPoint: true,
            data: ${json }
        }
    ]
});
</script>
</body>
</html>