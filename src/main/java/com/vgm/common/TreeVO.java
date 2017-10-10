package com.vgm.common;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by VGM on 2017/8/8.
 */
public class TreeVO {
    private String id;
    private String text;
    private Object attributes;
    private List nodes = new ArrayList<>();
    private String parentId;
    private Boolean isRoot = true;
    private Boolean available;

    public TreeVO() {
    }

    public TreeVO(String id, String text, Object attributes, String parentId) {
        this.id = id;
        this.text = text;
        this.attributes = attributes;
        this.parentId = parentId;
    }

    public TreeVO(String id, String text, Object attributes, String parentId, Boolean available) {
        this.id = id;
        this.text = text;
        this.attributes = attributes;
        this.parentId = parentId;
        this.available = available;
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

    public List getNodes() {
        return nodes;
    }

    public void setNodes(List nodes) {
        this.nodes = nodes;
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

    public Boolean getAvailable() {
        return available;
    }

    public void setAvailable(Boolean available) {
        this.available = available;
    }

    public static List build(List<TreeVO> list){
        for(int i = 0; i < list.size(); i++ ) {
            for(int j = i+1; j < list.size(); j++ ) {
                if (list.get(j).getId().equals(list.get(i).getParentId())) {
                    list.get(j).getNodes().add(list.get(i));
                    list.get(i).setIsRoot(false);
                } else if (list.get(i).getId().equals(list.get(j).getParentId())) {
                    list.get(i).getNodes().add(list.get(j));
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
