package com.vgm.core.user.query;

import org.ljdp.core.db.RoDBQueryParam;

public class UserDBParam extends RoDBQueryParam {
	private String eq_username;

	public String getEq_username() {
		return eq_username;
	}

	public void setEq_username(String eq_username) {
		this.eq_username = eq_username;
	}
}