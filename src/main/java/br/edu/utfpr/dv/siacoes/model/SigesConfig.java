﻿package br.edu.utfpr.dv.siacoes.model;

import br.edu.utfpr.dv.siacoes.model.SigetConfig.SupervisorFilter;

public class SigesConfig {
	
	public Department department;
	public double minimumScore;
	public double supervisorPonderosity;
	public double companySupervisorPonderosity;
	private boolean showGradesToStudent;
	private SupervisorFilter supervisorFilter;
	
	public SigesConfig(){
		this.setDepartment(new Department());
		this.setMinimumScore(6);
		this.setSupervisorPonderosity(1);
		this.setCompanySupervisorPonderosity(1);
		this.setShowGradesToStudent(false);
		this.setSupervisorFilter(SupervisorFilter.DEPARTMENT);
	}
	
	public Department getDepartment() {
		return department;
	}
	public void setDepartment(Department department) {
		this.department = department;
	}
	public double getMinimumScore() {
		return minimumScore;
	}
	public void setMinimumScore(double minimumScore) {
		this.minimumScore = minimumScore;
	}
	public double getSupervisorPonderosity() {
		return supervisorPonderosity;
	}
	public void setSupervisorPonderosity(double supervisorPonderosity) {
		this.supervisorPonderosity = supervisorPonderosity;
	}
	public double getCompanySupervisorPonderosity() {
		return companySupervisorPonderosity;
	}
	public void setCompanySupervisorPonderosity(double companySupervisorPonderosity) {
		this.companySupervisorPonderosity = companySupervisorPonderosity;
	}
	public boolean isShowGradesToStudent() {
		return showGradesToStudent;
	}
	public void setShowGradesToStudent(boolean showGradesToStudent) {
		this.showGradesToStudent = showGradesToStudent;
	}
	public SupervisorFilter getSupervisorFilter() {
		return supervisorFilter;
	}
	public void setSupervisorFilter(SupervisorFilter supervisorFilter) {
		this.supervisorFilter = supervisorFilter;
	}
	
}
