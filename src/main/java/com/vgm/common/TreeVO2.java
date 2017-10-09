package com.vgm.common;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by VGM on 2017/8/8.
 */
public class TreeVO2 {
    private String id;
    private String text;
    private Object attributes;
    private List children = new ArrayList<>();
    private String parentId;
    private Boolean isRoot = true;

    public TreeVO2() {
    }

    public TreeVO2(String id, String text, Object attributes, String parentId) {
        this.id = id;
        this.text = text;
        this.attributes = attributes;
        this.parentId = parentId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Object getAttributes() {
        return attributes;
    }

    public void setAttributes(Object attributes) {
        this.attributes = attributes;
    }

    public List getChildren() {
        return children;
    }

    public void setChildren(List children) {
        this.children = children;
    }

    public Boolean isRoot() {
        return isRoot;
    }

    public void setIsRoot(Boolean isRoot) {
        this.isRoot = isRoot;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public static List build(List<TreeVO2> list){
        for(int i = 0; i < list.size(); i++ ) {
            for(int j = i+1; j < list.size(); j++ ) {
                if (list.get(j).getId().equals(list.get(i).getParentId())) {
                    list.get(j).getChildren().add(list.get(i));
                    list.get(i).setIsRoot(false);
                } else if (list.get(i).getId().equals(list.get(j).getParentId())) {
                    list.get(i).getChildren().add(list.get(j));
                    list.get(j).setIsRoot(false);
                }
            }

        }

        for(int i = 0; i < list.size(); i++ ) {
            if (!list.get(i).isRoot()) {
                list.remove(i--);
            }
        }

        return list;
    }
}
