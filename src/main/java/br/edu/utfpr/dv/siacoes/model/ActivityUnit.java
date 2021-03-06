﻿package br.edu.utfpr.dv.siacoes.model;

public class ActivityUnit {
	
	private int idActivityUnit;
	private String description;
	private boolean fillAmount;
	
	public ActivityUnit(){
		this.setIdActivityUnit(0);
		this.setDescription("");
		this.setFillAmount(false);
	}
	
	public int getIdActivityUnit() {
		return idActivityUnit;
	}
	public void setIdActivityUnit(int idActivityUnit) {
		this.idActivityUnit = idActivityUnit;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public boolean isFillAmount() {
		return fillAmount;
	}
	public void setFillAmount(boolean fillAmount) {
		this.fillAmount = fillAmount;
	}
	
	public String toString(){
		return this.getDescription();
	}
	
	@Override
    public int hashCode() {
        return this.getIdActivityUnit();
    }
	
	@Override
    public boolean equals(final Object object) {
        if (!(object instanceof ActivityUnit)) {
            return false;
        }else if(this.getIdActivityUnit() == ((ActivityUnit)object).getIdActivityUnit()){
        	return true;
        }else{
        	return false;
        }
    }

}
