package com.vgm.common.util;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;

import java.util.HashSet;
import java.util.Set;

/**
 * 实体工具
 * @author MWH
 */
public class BeanCopyUtils {
	
	/**
	 * copyProperties ignore null
	 * @param target 目标实体
	 * @param source 源实体
	 */
	public static void copyPropertiesIgnoreNull(Object target,Object source){
		BeanWrapper src = new BeanWrapperImpl(source);
		 java.beans.PropertyDescriptor[] pds = src.getPropertyDescriptors();

		 Set<String> emptyNames = new HashSet<String>();
		 for(java.beans.PropertyDescriptor pd : pds) {
		 Object srcValue = src.getPropertyValue(pd.getName());
		 if (srcValue == null) emptyNames.add(pd.getName());
		}
		 String[] result = emptyNames.toArray(new String[emptyNames.size()]);
		 
		 BeanUtils.copyProperties(source, target, result);
	}
	
	/**
	 * copyProperties ignore null
	 * @param target 目标实体
	 * @param source 源实体
	 */
	public static void copyProperties(Object target,Object source,String[] properties){
		BeanWrapper src = new BeanWrapperImpl(source);
		 java.beans.PropertyDescriptor[] pds = src.getPropertyDescriptors();
         String propertiesStr = StringUtils.join(properties, ",");
		 Set<String> emptyNames = new HashSet<String>();
		 for(java.beans.PropertyDescriptor pd : pds) {
//		 Object srcValue = src.getPropertyValue(pd.getName());
//		 if (srcValue == null) emptyNames.add(pd.getName());
			 String propertyName = pd.getName();
			 if (!propertiesStr.contains(propertyName)) emptyNames.add(pd.getName());
		}
		 String[] result = emptyNames.toArray(new String[emptyNames.size()]);
		 
		 BeanUtils.copyProperties(source, target, result);
	}

	/**
	 * copyProperties
	 * @param target 目标实体
	 * @param source 源实体
	 */
	public static void copyProperties(Object target,Object source,String[] ignoreProperties,Boolean copyOrNot){
		BeanWrapper src = new BeanWrapperImpl(source);
		java.beans.PropertyDescriptor[] pds = src.getPropertyDescriptors();
		String propertiesStr = StringUtils.join(ignoreProperties, ",");
		Set<String> emptyNames = new HashSet<String>();
		for(java.beans.PropertyDescriptor pd : pds) {
			String propertyName = pd.getName();
			if (!propertiesStr.contains(propertyName)) emptyNames.add(pd.getName());
		}
		String[] result = emptyNames.toArray(new String[emptyNames.size()]);

		BeanUtils.copyProperties(source, target, result);
	}
}
