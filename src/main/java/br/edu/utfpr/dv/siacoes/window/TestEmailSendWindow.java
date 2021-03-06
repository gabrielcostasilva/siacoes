﻿package br.edu.utfpr.dv.siacoes.window;

import com.vaadin.ui.Button;
import com.vaadin.ui.Notification;
import com.vaadin.ui.TextField;
import com.vaadin.ui.VerticalLayout;
import com.vaadin.ui.Window;
import com.vaadin.ui.Button.ClickEvent;

import br.edu.utfpr.dv.siacoes.bo.EmailMessageBO;
import br.edu.utfpr.dv.siacoes.model.EmailMessage;

public class TestEmailSendWindow extends Window {
	
	private final TextField textTo;
	private final Button buttonSend;
	
	public TestEmailSendWindow(){
		this.setCaption("Testar Envio de E-mails");
		
		this.textTo = new TextField("Destinatário");
		this.textTo.setWidth("400px");
		
		this.buttonSend = new Button("Enviar", new Button.ClickListener() {
            @Override
            public void buttonClick(ClickEvent event) {
            	sendEmail();
            }
        });
		this.buttonSend.setWidth("150px");
		
		VerticalLayout vl = new VerticalLayout(this.textTo, this.buttonSend);
		vl.setSpacing(true);
		vl.setMargin(true);
		
		this.setContent(vl);
		
		this.setModal(true);
        this.center();
        this.setResizable(false);
	}
	
	private void sendEmail(){
		EmailMessageBO bo = new EmailMessageBO();
		EmailMessage message = new EmailMessage();
		
		message.setSubject("Teste de Envio");
		message.setMessage("Teste de envio de e-mail.");
		
		try {
			bo.sendEmailNoThread(new String[] { this.textTo.getValue() }, message, null);
			
			Notification.show("Enviar E-mail", "Envio realizado com sucesso.", Notification.Type.HUMANIZED_MESSAGE);
		} catch (Exception e) {
			e.printStackTrace();
			
			Notification.show("Enviar E-mail", e.getMessage(), Notification.Type.ERROR_MESSAGE);
		}
	}

}
