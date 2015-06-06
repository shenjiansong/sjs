<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>表管理</title>
		<%@ include file="/common/meta.jsp"%>
		<link rel="stylesheet" href="${ctx}/styles/css/style.css" type="text/css" media="all" />
		<script src="${ctx}/styles/js/jquery-1.8.3.min.js" type="text/javascript"></script>
		<script src="${ctx}/styles/js/table.js" type="text/javascript"></script>
	</head>

	<body>
	<form id="mainForm" action="${ctx}/config/dbtable" method="get">
		<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo}"/>
		<input type="hidden" name="orderBy" id="orderBy" value="${page.orderBy}"/>
		<input type="hidden" name="order" id="order" value="${page.order}"/>
		<table width="100%" border="0" align="center" cellpadding="0"
				class="table_all_border" cellspacing="0" style="margin-bottom: 0px;border-bottom: 0px">
			<tr>
				<td class="td_table_top" align="center">
					表管理
				</td>
			</tr>
		</table>
		<table class="table_all" align="center" border="0" cellpadding="0"
			cellspacing="0" style="margin-top: 0px">
			<tr>
				<td class="td_table_1">
					<span>表名：</span>
				</td>
				<td class="td_table_2" >
					<input type="text" class="input_240" name="name" value="${name }"/>
				</td>
				<td class="td_table_2" colspan="2">
					<input type='submit' class='button_70px' value='查询'/>
				</td>
			</tr>
		</table>
		<table class="table_all" align="center" border="0" cellpadding="0"
			cellspacing="0">
			<tr>
				<td align=center width=20% class="td_list_1" nowrap>
					表名
				</td>
				<td align=center width=20% class="td_list_1" nowrap>
					备注
				</td>
				<td align=center width=20% class="td_list_1" nowrap>
					类别
				</td>	
				<td align=center width=20% class="td_list_1" nowrap>
					创建人
				</td>
				<td align=center width=20% class="td_list_1" nowrap>
					创建时间
				</td>
				<td align=center width=20% class="td_list_1" nowrap>
					操作
				</td>	
			</tr>
			<c:forEach items="${page.result}" var="form">
				<tr>
					<td class="td_list_2" align=left nowrap>
						tbl_${form.name}&nbsp;
					</td>
					<td class="td_list_2" align=left nowrap>
						${form.displayName}&nbsp;
					</td>
					<td class="td_list_2" align=left nowrap>
					<frame:select name="type" type="select" configName="formType" displayType="1" value="${form.type}" />&nbsp;
					</td>
					<td class="td_list_2" align=left nowrap>
						${form.creator}&nbsp;
					</td>
					<td class="td_list_2" align=left nowrap>
						${form.createTime}&nbsp;
					</td>
					<td class="td_list_2" align=left nowrap>
						<a href="dbtable/${form.id}" >结构管理</a>  |  <a href="dbtable/template/${form.id}" >数据管理</a>
					</td>
				</tr>
			</c:forEach>
			<frame:page curPage="${page.pageNo}" totalPages="${page.totalPages }" totalRecords="${page.totalCount }" lookup="${lookup }"/>
		</table>
	</form>
    <script>
        function confirmForm(formId) {
            window.returnValue = formId;
            window.close();
        }
    </script>
	</body>
</html>
