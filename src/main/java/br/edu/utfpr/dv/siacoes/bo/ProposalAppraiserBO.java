package br.edu.utfpr.dv.siacoes.bo;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import br.edu.utfpr.dv.siacoes.dao.ProposalAppraiserDAO;
import br.edu.utfpr.dv.siacoes.model.EmailMessageEntry;
import br.edu.utfpr.dv.siacoes.model.Proposal;
import br.edu.utfpr.dv.siacoes.model.ProposalAppraiser;
import br.edu.utfpr.dv.siacoes.model.User;
import br.edu.utfpr.dv.siacoes.model.ProposalAppraiser.ProposalFeedback;
import br.edu.utfpr.dv.siacoes.model.EmailMessage.MessageType;
import br.edu.utfpr.dv.siacoes.model.Module.SystemModule;

public class ProposalAppraiserBO {

	public List<ProposalAppraiser> listAppraisers(int idProposal) throws Exception{
		try {
			ProposalAppraiserDAO dao = new ProposalAppraiserDAO();
			
			return dao.listAppraisers(idProposal);
		} catch (SQLException e) {
			Logger.getGlobal().log(Level.SEVERE, e.getMessage(), e);
			
			throw new Exception(e.getMessage());
		}
	}
	
	public ProposalAppraiser findById(int id) throws Exception{
		try {
			ProposalAppraiserDAO dao = new ProposalAppraiserDAO();
			
			return dao.findById(id);
		} catch (SQLException e) {
			Logger.getGlobal().log(Level.SEVERE, e.getMessage(), e);
			
			throw new Exception(e.getMessage());
		}
	}
	
	public ProposalAppraiser findByAppraiser(int idProposal, int idAppraiser) throws Exception{
		try {
			ProposalAppraiserDAO dao = new ProposalAppraiserDAO();
			
			return dao.findByAppraiser(idProposal, idAppraiser);
		} catch (SQLException e) {
			Logger.getGlobal().log(Level.SEVERE, e.getMessage(), e);
			
			throw new Exception(e.getMessage());
		}
	}
	
	public int save(ProposalAppraiser appraiser) throws Exception{
		int ret = 0;
		boolean isInsert = (appraiser.getIdProposalAppraiser() == 0);
		ProposalFeedback oldFeedback = ProposalFeedback.NONE;
		ProposalAppraiserDAO dao = new ProposalAppraiserDAO();
		
		if(!isInsert){
			try {
				oldFeedback = dao.findFeedback(appraiser.getIdProposalAppraiser());
			} catch (SQLException e) {
				oldFeedback = ProposalFeedback.NONE;
			}	
		}
		
		try {
			if((appraiser.getProposal() == null) || (appraiser.getProposal().getIdProposal() == 0)){
				throw new Exception("Informe a proposta.");
			}
			if((appraiser.getAppraiser() == null) || (appraiser.getAppraiser().getIdUser() == 0)){
				throw new Exception("Informe o avaliador.");
			}
			
			ret = dao.save(appraiser);
		} catch (SQLException e) {
			Logger.getGlobal().log(Level.SEVERE, e.getMessage(), e);
			
			throw new Exception(e.getMessage());
		}
		
		if(!isInsert && (oldFeedback != appraiser.getFeedback())){
			try{
				ProposalBO pbo = new ProposalBO();
				Proposal proposal = pbo.findById(appraiser.getProposal().getIdProposal());
				
				UserBO ubo = new UserBO();
				User user = ubo.findManager(proposal.getDepartment().getIdDepartment(), SystemModule.SIGET);
				
				if(user != null){
					EmailMessageBO bo = new EmailMessageBO();
					List<EmailMessageEntry<String, String>> keys = new ArrayList<EmailMessageEntry<String, String>>();
					
					keys.add(new EmailMessageEntry<String, String>("student", proposal.getStudent().getName()));
					keys.add(new EmailMessageEntry<String, String>("supervisor", proposal.getSupervisor().getName()));
					if(proposal.getCosupervisor() == null){
						keys.add(new EmailMessageEntry<String, String>("cosupervisor", ""));
					}else{
						keys.add(new EmailMessageEntry<String, String>("cosupervisor", proposal.getCosupervisor().getName()));	
					}
					keys.add(new EmailMessageEntry<String, String>("title", proposal.getTitle()));
					keys.add(new EmailMessageEntry<String, String>("subarea", proposal.getSubarea()));
					keys.add(new EmailMessageEntry<String, String>("appraiser", appraiser.getAppraiser().getName()));
					keys.add(new EmailMessageEntry<String, String>("feedback", appraiser.getFeedback().toString()));
					keys.add(new EmailMessageEntry<String, String>("comments", appraiser.getComments()));
					keys.add(new EmailMessageEntry<String, String>("manager", user.getName()));
					
					bo.sendEmail(user.getIdUser(), MessageType.PROPOSALAPPRAISERFEEDBACK, keys);
				}
			}catch(Exception e){
				Logger.getGlobal().log(Level.SEVERE, e.getMessage(), e);
			}
		}
		
		return ret;
	}
	
}
