﻿package br.edu.utfpr.dv.siacoes.model;

import java.util.Date;

public class FinalDocument {
	
	public enum DocumentFeedback{
		NONE(0), APPROVED(1), DISAPPROVED(2);
		
		private final int value; 
		DocumentFeedback(int value){ 
			this.value = value; 
		}
		
		public int getValue(){ 
			return value;
		}
		
		public static DocumentFeedback valueOf(int value){
			for(DocumentFeedback p : DocumentFeedback.values()){
				if(p.getValue() == value){
					return p;
				}
			}
			
			return null;
		}
		
		public String toString(){
			switch(this){
			case NONE:
				return "Nenhum";
			case APPROVED:
				return "Aprovado";
			case DISAPPROVED:
				return "Reprovado";
			default:
				return "";
			}
		}
	}
	
	private int idFinalDocument;
	private Project project;
	private Thesis thesis;
	private String title;
	private Date submissionDate;
	private byte[] file;
	private boolean _private;
	private boolean companyInfo;
	private boolean patent;
	private Date supervisorFeedbackDate;
	private DocumentFeedback supervisorFeedback;
	private String comments;
	
	public FinalDocument(){
		this.setIdFinalDocument(0);
		this.setProject(new Project());
		this.setThesis(new Thesis());
		this.setTitle("");
		this.setSubmissionDate(new Date());
		this.setFile(null);
		this.setPrivate(false);
		this.setCompanyInfo(false);
		this.setPatent(false);
		this.setSupervisorFeedbackDate(null);
		this.setSupervisorFeedback(DocumentFeedback.NONE);
		this.setComments("");
	}
	
	public int getIdFinalDocument() {
		return idFinalDocument;
	}
	public void setIdFinalDocument(int idFinalDocument) {
		this.idFinalDocument = idFinalDocument;
	}
	public Project getProject(){
		return project;
	}
	public void setProject(Project project){
		this.project = project;
	}
	public Thesis getThesis() {
		return thesis;
	}
	public void setThesis(Thesis thesis) {
		this.thesis = thesis;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getSubmissionDate() {
		return submissionDate;
	}
	public void setSubmissionDate(Date submissionDate) {
		this.submissionDate = submissionDate;
	}
	public byte[] getFile() {
		return file;
	}
	public void setFile(byte[] file) {
		this.file = file;
	}
	public boolean isPrivate() {
		return _private;
	}
	public void setPrivate(boolean _private) {
		this._private = _private;
	}
	public Date getSupervisorFeedbackDate() {
		return supervisorFeedbackDate;
	}
	public void setSupervisorFeedbackDate(Date supervisorFeedbackDate) {
		this.supervisorFeedbackDate = supervisorFeedbackDate;
	}
	public DocumentFeedback getSupervisorFeedback() {
		return supervisorFeedback;
	}
	public void setSupervisorFeedback(DocumentFeedback supervisorFeedback) {
		this.supervisorFeedback = supervisorFeedback;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public boolean isCompanyInfo() {
		return companyInfo;
	}
	public void setCompanyInfo(boolean companyInfo) {
		this.companyInfo = companyInfo;
	}
	public boolean isPatent() {
		return patent;
	}
	public void setPatent(boolean patent) {
		this.patent = patent;
	}
	public int getStage(){
		if((this.getThesis() != null) && (this.getThesis().getIdThesis() != 0))
			return 2;
		else
			return 1;
	}

}
