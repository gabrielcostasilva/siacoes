﻿package br.edu.utfpr.dv.siacoes.model;

public class ProposalAppraiser {

	public enum ProposalFeedback{
		NONE(0), APPROVED(1), APPROVEDWITHRESERVATIONS(2), DISAPPROVED(3);
		
		private final int value; 
		ProposalFeedback(int value){ 
			this.value = value; 
		}
		
		public int getValue(){ 
			return value;
		}
		
		public static ProposalFeedback valueOf(int value){
			for(ProposalFeedback p : ProposalFeedback.values()){
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
				return "Aprovada";
			case APPROVEDWITHRESERVATIONS:
				return "Aprovada com ressalvas";
			case DISAPPROVED:
				return "Reprovada";
			default:
				return "";
			}
		}
	}
	
	private int idProposalAppraiser;
	private Proposal proposal;
	private User appraiser;
	private ProposalFeedback feedback;
	private String comments;
	private boolean allowEditing;
	
	public ProposalAppraiser(){
		this.setIdProposalAppraiser(0);
		this.setProposal(new Proposal());
		this.setAppraiser(new User());
		this.setFeedback(ProposalFeedback.NONE);
		this.setComments("");
		this.setAllowEditing(true);
	}

	public int getIdProposalAppraiser() {
		return idProposalAppraiser;
	}

	public void setIdProposalAppraiser(int idProposalAppraiser) {
		this.idProposalAppraiser = idProposalAppraiser;
	}

	public Proposal getProposal() {
		return proposal;
	}

	public void setProposal(Proposal proposal) {
		this.proposal = proposal;
	}

	public User getAppraiser() {
		return appraiser;
	}

	public void setAppraiser(User appraiser) {
		this.appraiser = appraiser;
	}

	public ProposalFeedback getFeedback() {
		return feedback;
	}

	public void setFeedback(ProposalFeedback feedback) {
		this.feedback = feedback;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public boolean isAllowEditing() {
		return allowEditing;
	}

	public void setAllowEditing(boolean allowEditing) {
		this.allowEditing = allowEditing;
	}
		
}
