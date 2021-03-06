﻿package br.edu.utfpr.dv.siacoes.window;

import java.util.logging.Level;
import java.util.logging.Logger;

import com.vaadin.ui.DateField;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.Notification;

import br.edu.utfpr.dv.siacoes.Session;
import br.edu.utfpr.dv.siacoes.bo.SemesterBO;
import br.edu.utfpr.dv.siacoes.components.CampusComboBox;
import br.edu.utfpr.dv.siacoes.components.SemesterComboBox;
import br.edu.utfpr.dv.siacoes.components.YearField;
import br.edu.utfpr.dv.siacoes.model.Semester;
import br.edu.utfpr.dv.siacoes.view.ListView;

public class EditSemesterWindow extends EditWindow {
	
	private final Semester semester;
	
	private final CampusComboBox comboCampus;
	private final SemesterComboBox comboSemester;
	private final YearField textYear;
	private final DateField textStartDate;
	private final DateField textEndDate;
	
	public EditSemesterWindow(Semester semester, ListView parentView){
		super("Editar Semestre", parentView);
		
		if(semester == null){
			this.semester = new Semester();
			this.semester.setCampus(Session.getUser().getDepartment().getCampus());
		}else{
			this.semester = semester;
		}
		
		this.comboCampus = new CampusComboBox();
		this.comboCampus.setEnabled(false);
		
		this.comboSemester = new SemesterComboBox();
		
		this.textYear = new YearField();
		
		this.textStartDate = new DateField("Data de Início");
		this.textStartDate.setDateFormat("dd/MM/yyyy");
		
		this.textEndDate = new DateField("Data de Término");
		this.textEndDate.setDateFormat("dd/MM/yyyy");
		
		this.addField(this.comboCampus);
		this.addField(new HorizontalLayout(this.comboSemester, this.textYear));
		this.addField(new HorizontalLayout(this.textStartDate, this.textEndDate));
		
		this.loadSemester();
		this.comboSemester.focus();
	}
	
	private void loadSemester(){
		this.comboCampus.setCampus(this.semester.getCampus());
		this.comboSemester.setSemester(this.semester.getSemester());
		this.textYear.setYear(this.semester.getYear());
		this.textStartDate.setValue(this.semester.getStartDate());
		this.textEndDate.setValue(this.semester.getEndDate());
	}

	@Override
	public void save() {
		try{
			SemesterBO bo = new SemesterBO();
			
			this.semester.setCampus(this.comboCampus.getCampus());
			this.semester.setSemester(this.comboSemester.getSemester());
			this.semester.setYear(this.textYear.getYear());
			this.semester.setStartDate(this.textStartDate.getValue());
			this.semester.setEndDate(this.textEndDate.getValue());
			
			bo.save(semester);
			
			Notification.show("Salvar Semestre", "Semestre salvo com sucesso.", Notification.Type.HUMANIZED_MESSAGE);
			
			this.parentViewRefreshGrid();
			this.close();
		}catch(Exception e){
			Logger.getGlobal().log(Level.SEVERE, e.getMessage(), e);
			
			Notification.show("Salvar Semestre", e.getMessage(), Notification.Type.ERROR_MESSAGE);
		}
	}

}
