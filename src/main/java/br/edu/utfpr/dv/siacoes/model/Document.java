﻿package br.edu.utfpr.dv.siacoes.model;

import br.edu.utfpr.dv.siacoes.model.Module.SystemModule;

public class Document {
	
	public enum DocumentType{
		UNDEFINED(0), PDF(1), DOC(2), DOCX(3), ZIP(4), ODT(5), PPT(6), PPTX(7);
		
		private final int value; 
		DocumentType(int value){ 
			this.value = value; 
		}
		
		public int getValue(){ 
			return value;
		}
		
		public String getExtension(){
			switch(this){
			case PDF:
				return ".pdf";
			case DOC:
				return ".doc";
			case DOCX:
				return ".docx";
			case ZIP:
				return ".zip";
			case ODT:
				return ".odt";
			case PPT:
				return ".ppt";
			case PPTX:
				return ".pptx";
			default:
				return "";
			}
		}
		
		public static DocumentType fromMimeType(String mimeType){
			if(mimeType.equals("application/pdf")){
				return DocumentType.PDF;
			}else if(mimeType.equals("application/msword")){
				return DocumentType.DOC;
			}else if(mimeType.equals("application/vnd.openxmlformats-officedocument.wordprocessingml.document")){
				return DocumentType.DOCX;
			}else if(mimeType.contains("application/zip") || mimeType.contains("application/octet-stream") || mimeType.equals("application/x-zip-compressed")){
				return DocumentType.ZIP;
			}else if(mimeType.equals("application/vnd.oasis.opendocument.text")){
				return DocumentType.ODT;
			}else if(mimeType.equals("application/vnd.ms-powerpoint")){
				return DocumentType.PPT;
			}else if(mimeType.equals("application/vnd.openxmlformats-officedocument.presentationml.presentation")){
				return DocumentType.PPTX;
			}else{
				return DocumentType.UNDEFINED;
			}
		}
		
		public static DocumentType valueOf(int value){
			for(DocumentType d : DocumentType.values()){
				if(d.getValue() == value){
					return d;
				}
			}
			
			return null;
		}
	}
	
	private int idDocument;
	private String name;
	private DocumentType type;
	private byte[] file;
	private int sequence;
	private Department department;
	private SystemModule module;
	
	public Document(){
		this.setIdDocument(0);
		this.setName("");
		this.setType(DocumentType.UNDEFINED);
		this.setSequence(0);
		this.setDepartment(new Department());
		this.setModule(SystemModule.GENERAL);
	}
	
	public int getIdDocument() {
		return idDocument;
	}
	public void setIdDocument(int idDocument) {
		this.idDocument = idDocument;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public DocumentType getType() {
		return type;
	}
	public void setType(DocumentType type) {
		this.type = type;
	}
	public byte[] getFile() {
		return file;
	}
	public void setFile(byte[] file) {
		this.file = file;
	}
	public int getSequence() {
		return sequence;
	}
	public void setSequence(int sequence) {
		this.sequence = sequence;
	}
	public void setDepartment(Department department){
		this.department = department;
	}
	public Department getDepartment(){
		return department;
	}
	public void setModule(SystemModule module){
		this.module = module;
	}
	public SystemModule getModule(){
		return module;
	}
	
}
