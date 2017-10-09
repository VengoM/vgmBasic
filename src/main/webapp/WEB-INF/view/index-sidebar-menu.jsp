<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" scope="request"/>
<c:forEach var="menu" items="${menus}" varStatus="vs">
  <c:set var="hasChild" value="${fn:length(menu.nodes)>0}" />
  <li
          <c:if test="${hasChild}">class="treeview"</c:if>
          >
    <a href="${ctx}${menu.attributes.url}" id="menu-${menu.id}"
       <c:if test="${!hasChild}">onclick="return openTab(this);"</c:if>
            >
      <i class="${menu.attributes.icon}"></i><span>${menu.text}</span>

  <%--pull span --%>
  <c:if test="${hasChild}">
  <span class="pull-right-container">
  <i class="fa fa-angle-left pull-right"></i>
  </span>
  </c:if>

    </a>

    <%--child menu--%>
    <c:if test="${hasChild}" >
    <ul class="treeview-menu">
      <c:set var="menus" value="${menu.nodes}" scope="request" />
      <c:import url="index-sidebar-menu.jsp" />
    </ul>
    </c:if>

  </li>
</c:forEach>

