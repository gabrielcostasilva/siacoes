﻿package br.edu.utfpr.dv.siacoes.window;

import java.util.logging.Level;
import java.util.logging.Logger;

import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.Notification;
import com.vaadin.ui.TextField;

import br.edu.utfpr.dv.siacoes.bo.StateBO;
import br.edu.utfpr.dv.siacoes.components.CountryComboBox;
import br.edu.utfpr.dv.siacoes.model.State;
import br.edu.utfpr.dv.siacoes.view.ListView;

public class EditStateWindow extends EditWindow {

	private final State state;
	
	private final CountryComboBox comboCountry;
	private final TextField textName;
	private final TextField textInitials;
	
	public EditStateWindow(State state, ListView parentView){
		super("Editar Estado", parentView);
		
		if(state == null){
			this.state = new State();
		}else{
			this.state = state;
		}
		
		this.comboCountry = new CountryComboBox();
		
		this.textName = new TextField("Estado");
		this.textName.setWidth("300px");
		this.textName.setMaxLength(100);
		
		this.textInitials = new TextField("Sigla");
		this.textInitials.setWidth("75px");
		this.textInitials.setMaxLength(2);
		
		this.addField(this.comboCountry);
		this.addField(new HorizontalLayout(this.textName, this.textInitials));
		
		this.loadState();
		this.comboCountry.focus();
	}
	
	private void loadState(){
		this.comboCountry.setCountry(this.state.getCountry());
		this.textName.setValue(this.state.getName());
		this.textInitials.setValue(this.state.getInitials());
	}

	@Override
	public void save() {
		try{
			StateBO bo = new StateBO();
			
			this.state.setCountry(this.comboCountry.getCountry());
			this.state.setName(this.textName.getValue());
			this.state.setInitials(this.textInitials.getValue());
			
			bo.save(this.state);
			
			Notification.show("Salvar Estado", "Estado salvo com sucesso.", Notification.Type.HUMANIZED_MESSAGE);
			
			this.parentViewRefreshGrid();
			this.close();
		}catch(Exception e){
			Logger.getGlobal().log(Level.SEVERE, e.getMessage(), e);
			
			Notification.show("Salvar Estado", e.getMessage(), Notification.Type.ERROR_MESSAGE);
		}
	}
	
}
