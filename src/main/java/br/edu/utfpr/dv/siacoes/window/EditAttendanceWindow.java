﻿package br.edu.utfpr.dv.siacoes.window;

import java.util.logging.Level;
import java.util.logging.Logger;

import org.vaadin.thomas.timefield.TimeField;

import com.vaadin.ui.DateField;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.Notification;
import com.vaadin.ui.TextArea;
import com.vaadin.ui.TextField;

import br.edu.utfpr.dv.siacoes.bo.AttendanceBO;
import br.edu.utfpr.dv.siacoes.components.StageComboBox;
import br.edu.utfpr.dv.siacoes.model.Attendance;
import br.edu.utfpr.dv.siacoes.view.ListView;

public class EditAttendanceWindow extends EditWindow {
	
	private final Attendance attendance;
	
	private final TextField textStudent;
	private final TextField textSupervisor;
	private final TextField textProposal;
	private final DateField textDate;
	private final TimeField textStartTime;
	private final TimeField textEndTime;
	private final TextArea textComments;
	private final TextArea textNextMeeting;
	private final StageComboBox comboStage;
	
	public EditAttendanceWindow(Attendance attendance, ListView parentView){
		super("Registrar Acompanhamento", parentView);
		
		if(attendance == null){
			this.attendance = new Attendance();
		}else{
			this.attendance = attendance;
		}
		
		this.textStudent = new TextField("Acadêmico");
		this.textStudent.setEnabled(false);
		this.textStudent.setWidth("400px");
		
		this.textSupervisor = new TextField("Orientador");
		this.textSupervisor.setEnabled(false);
		this.textSupervisor.setWidth("400px");
		
		this.textProposal = new TextField("Proposta");
		this.textProposal.setEnabled(false);
		this.textProposal.setWidth("810px");
		
		this.comboStage = new StageComboBox();
		
		this.textDate = new DateField("Data");
		this.textDate.setDateFormat("dd/MM/yyyy");
		
		this.textStartTime = new TimeField("Horário Inicial");
		this.textStartTime.set24HourClock(true);
		
		this.textEndTime = new TimeField("Horário Final");
		this.textEndTime.set24HourClock(true);
		
		this.textComments = new TextArea("Observações/Orientações");
		this.textComments.setWidth("810px");
		
		this.textNextMeeting = new TextArea("Atividades previstas para a próxima reunião");
		this.textNextMeeting.setWidth("810px");
		
		HorizontalLayout h1 = new HorizontalLayout(this.textStudent, this.textSupervisor);
		h1.setSpacing(true);
		
		HorizontalLayout layoutDate = new HorizontalLayout(this.comboStage, this.textDate, this.textStartTime, this.textEndTime);
		layoutDate.setSpacing(true);
		
		this.addField(h1);
		this.addField(this.textProposal);
		this.addField(layoutDate);
		this.addField(this.textComments);
		this.addField(this.textNextMeeting);
		
		this.loadAttendance();
		this.comboStage.focus();
	}
	
	private void loadAttendance(){
		this.textStudent.setValue(this.attendance.getStudent().getName());
		this.textSupervisor.setValue(this.attendance.getSupervisor().getName());
		this.textProposal.setValue(this.attendance.getProposal().getTitle());
		this.comboStage.setStage(this.attendance.getStage());
		this.textDate.setValue(this.attendance.getDate());
		this.textStartTime.setValue(this.attendance.getStartTime());
		this.textEndTime.setValue(this.attendance.getEndTime());
		this.textComments.setValue(this.attendance.getComments());
		this.textNextMeeting.setValue(this.attendance.getNextMeeting());
	}

	@Override
	public void save() {
		try{
			AttendanceBO bo = new AttendanceBO();
			
			this.attendance.setStage((int)this.comboStage.getStage());
			this.attendance.setDate(this.textDate.getValue());
			this.attendance.setStartTime(this.textStartTime.getValue());
			this.attendance.setEndTime(this.textEndTime.getValue());
			this.attendance.setComments(this.textComments.getValue());
			this.attendance.setNextMeeting(this.textNextMeeting.getValue());
			
			bo.save(this.attendance);
			
			Notification.show("Salvar Acompanhamento", "Acompanhamento salvo com sucesso.", Notification.Type.HUMANIZED_MESSAGE);
			
			this.parentViewRefreshGrid();
			this.close();
		}catch(Exception e){
			Logger.getGlobal().log(Level.SEVERE, e.getMessage(), e);
			
			Notification.show("Salvar Acompanhamento", e.getMessage(), Notification.Type.ERROR_MESSAGE);
		}
	}

}
