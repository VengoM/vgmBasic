package com.vgm.core.user.query;

import org.ljdp.core.db.RoDBQueryParam;

public class RoleDBParam extends RoDBQueryParam {
    private String like_role;

    public String getLike_role() {
        return like_role;
    }

    public void setLike_role(String like_role) {
        this.like_role = like_role;
    }
}