package org.ljdp.core.pojo;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * Created by VGM on 2016/12/6.
 */
public abstract class BaseVO {
    public BaseVO() {
    }

    public String toString() {
        return ReflectionToStringBuilder.toString(this);
    }

    public String toStringMultiLine() {
        return ReflectionToStringBuilder.toString(this, ToStringStyle.MULTI_LINE_STYLE);
    }

    public String toStringShortPrefix() {
        return ReflectionToStringBuilder.toString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }

    public String toStringSimple() {
        return ReflectionToStringBuilder.toString(this, ToStringStyle.SIMPLE_STYLE);
    }
}