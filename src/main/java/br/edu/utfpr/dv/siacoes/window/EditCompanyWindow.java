﻿package br.edu.utfpr.dv.siacoes.window;

import java.util.logging.Level;
import java.util.logging.Logger;

import com.vaadin.data.Property.ValueChangeEvent;
import com.vaadin.data.Property.ValueChangeListener;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.Notification;
import com.vaadin.ui.TextField;

import br.edu.utfpr.dv.siacoes.bo.CityBO;
import br.edu.utfpr.dv.siacoes.bo.CompanyBO;
import br.edu.utfpr.dv.siacoes.components.CityComboBox;
import br.edu.utfpr.dv.siacoes.components.CountryComboBox;
import br.edu.utfpr.dv.siacoes.components.StateComboBox;
import br.edu.utfpr.dv.siacoes.model.City;
import br.edu.utfpr.dv.siacoes.model.Company;
import br.edu.utfpr.dv.siacoes.view.ListView;

public class EditCompanyWindow extends EditWindow {

	private final Company company;
	
	private final CountryComboBox comboCountry;
	private final StateComboBox comboState;
	private final CityComboBox comboCity;
	private final TextField textName;
	private final TextField textCnpj;
	private final TextField textPhone;
	private final TextField textEmail;
	private final TextField textAgreement;
	
	public EditCompanyWindow(Company company, ListView parentView){
		super("Editar Empresa", parentView);
		
		if(company == null){
			this.company = new Company();
		}else{
			this.company = company;
		}
		
		this.comboCity = new CityComboBox();
		this.comboCity.setWidth("810px");
		
		this.comboState = new StateComboBox();
		this.comboState.addValueChangeListener(new ValueChangeListener() {
			public void valueChange(ValueChangeEvent event) {
				if(comboState.getStateValue() == null){
					comboCity.setIdState(0);
				}else{
					comboCity.setIdState(comboState.getStateValue().getIdState());	
				}
			}
		});
		
		this.comboCountry = new CountryComboBox();
		this.comboCountry.addValueChangeListener(new ValueChangeListener() {
			public void valueChange(ValueChangeEvent event) {
				if(comboCountry.getCountry() == null){
					comboState.setIdCountry(0);
				}else{
					comboState.setIdCountry(comboCountry.getCountry().getIdCountry());	
				}
			}
		});
		
		this.textName = new TextField("Nome da Empresa");
		this.textName.setWidth("810px");
		this.textName.setMaxLength(100);
		
		this.textCnpj = new TextField("CNPJ");
		this.textCnpj.setWidth("200px");
		this.textCnpj.setMaxLength(14);
		
		this.textPhone = new TextField("Telefone");
		this.textPhone.setWidth("200px");
		this.textPhone.setMaxLength(100);
		
		this.textAgreement = new TextField("Convênio");
		this.textAgreement.setWidth("200px");
		this.textAgreement.setMaxLength(50);
		
		this.textEmail = new TextField("E-mail");
		this.textEmail.setWidth("810px");
		this.textEmail.setMaxLength(100);
		
		this.addField(this.textName);
		this.addField(new HorizontalLayout(this.comboCountry, this.comboState));
		this.addField(this.comboCity);
		this.addField(new HorizontalLayout(this.textCnpj, this.textPhone, this.textAgreement));
		this.addField(this.textEmail);
		
		this.loadCompany();
		this.textName.focus();
	}
	
	private void loadCompany(){
		try {
			CityBO bo = new CityBO();
			City city = bo.findById(this.company.getCity().getIdCity());
			
			this.comboCountry.setCountry(city.getState().getCountry());
			this.comboState.setIdCountry(city.getState().getCountry().getIdCountry());
			this.comboState.setState(city.getState());
			this.comboCity.setIdState(city.getState().getIdState());
			this.comboCity.setCity(city);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		this.textName.setValue(this.company.getName());
		this.textCnpj.setValue(this.company.getCnpj());
		this.textPhone.setValue(this.company.getPhone());
		this.textEmail.setValue(this.company.getEmail());
		this.textAgreement.setValue(this.company.getAgreement());
	}
	
	@Override
	public void save() {
		try{
			CompanyBO bo = new CompanyBO();
			
			this.company.setName(this.textName.getValue());
			this.company.setCity(this.comboCity.getCity());
			this.company.setCnpj(this.textCnpj.getValue());
			this.company.setPhone(this.textPhone.getValue());
			this.company.setEmail(this.textEmail.getValue());
			this.company.setAgreement(this.textAgreement.getValue());
			
			bo.save(this.company);
			
			Notification.show("Salvar Empresa", "Empresa salva com sucesso.", Notification.Type.HUMANIZED_MESSAGE);
			
			this.parentViewRefreshGrid();
			this.close();
		}catch(Exception e){
			Logger.getGlobal().log(Level.SEVERE, e.getMessage(), e);
			
			Notification.show("Salvar Empresa", e.getMessage(), Notification.Type.ERROR_MESSAGE);
		}
	}

}
