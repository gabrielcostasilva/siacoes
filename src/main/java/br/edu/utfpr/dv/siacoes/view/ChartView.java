﻿package br.edu.utfpr.dv.siacoes.view;

import java.util.logging.Level;
import java.util.logging.Logger;

import org.dussan.vaadin.dcharts.ChartImageFormat;
import org.dussan.vaadin.dcharts.DCharts;
import org.dussan.vaadin.dcharts.DownloadButtonLocation;

import com.vaadin.icons.VaadinIcons;
import com.vaadin.navigator.ViewChangeListener.ViewChangeEvent;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button;
import com.vaadin.ui.Component;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.Notification;
import com.vaadin.ui.Panel;
import com.vaadin.ui.VerticalLayout;
import com.vaadin.ui.themes.ValoTheme;
import com.vaadin.ui.Button.ClickEvent;
import com.vaadin.ui.Button.ClickListener;

import br.edu.utfpr.dv.siacoes.model.Module.SystemModule;
import br.edu.utfpr.dv.siacoes.model.User.UserProfile;

public abstract class ChartView extends BasicView {
	
	private final VerticalLayout layoutContent;
	private final VerticalLayout layoutFields;
	private final VerticalLayout layoutChart;
	private final Panel panelWindowChart;
	private final Panel panelChart;
	private final Button buttonChart;
	
	public ChartView(SystemModule module){
		this.setProfilePerimissions(UserProfile.STUDENT);
    	
    	this.buttonChart = new Button("Gerar Gráfico", new Button.ClickListener() {
            @Override
            public void buttonClick(ClickEvent event) {
            	try{
            		plotChart();
            		setChartVisible(true);
            	}catch(Exception e){
            		Logger.getGlobal().log(Level.SEVERE, e.getMessage(), e);
            		
            		Notification.show("Gerar Gráfico", e.getMessage(), Notification.Type.ERROR_MESSAGE);
            	}
            }
        });
		this.buttonChart.setWidth("150px");
		
		this.layoutFields = new VerticalLayout();
		this.layoutFields.setSpacing(true);
		
		Button buttonCloseChart = new Button(VaadinIcons.CLOSE);
		buttonCloseChart.addStyleName(ValoTheme.BUTTON_QUIET);
		buttonCloseChart.addStyleName(ValoTheme.BUTTON_SMALL);
		buttonCloseChart.addClickListener(new ClickListener() {
			@Override
			public void buttonClick(ClickEvent event) {
				setChartVisible(false);
			}
		});
		
		this.panelChart = new Panel();
		this.panelChart.setSizeFull();
		
		this.layoutChart = new VerticalLayout(buttonCloseChart, this.panelChart);
		this.layoutChart.setSpacing(true);
		this.layoutChart.setSizeFull();
		this.layoutChart.setComponentAlignment(buttonCloseChart, Alignment.TOP_RIGHT);
		this.layoutChart.setExpandRatio(this.panelChart, 1);
		
		this.panelWindowChart = new Panel();
		this.panelWindowChart.setContent(this.layoutChart);
		this.panelWindowChart.setSizeFull();
		
		this.layoutContent = new VerticalLayout(this.layoutFields);
		this.layoutContent.setSizeFull();
		
		HorizontalLayout layoutButtons = new HorizontalLayout(this.buttonChart);
		layoutButtons.setSpacing(true);
		
		VerticalLayout layout = new VerticalLayout(this.layoutContent, layoutButtons);
		layout.setSpacing(true);
		layout.setMargin(true);
		layout.setSizeFull();
		layout.setExpandRatio(this.layoutContent, 1);
    	
    	this.setModule(module);
    	
    	this.setContent(layout);
	}
    
    public void addFilterField(Component c){
    	if(c instanceof HorizontalLayout){
			((HorizontalLayout)c).setSpacing(true);
		}else if(c instanceof VerticalLayout){
			((VerticalLayout)c).setSpacing(true);
		}
    	
    	layoutFields.addComponent(c);
    }
    
    private void setChartVisible(boolean visible){
    	this.buttonChart.setVisible(!visible);
    	
    	this.layoutContent.removeAllComponents();
    	if(visible){
    		this.layoutContent.addComponent(this.panelWindowChart);
    	}else{
    		this.layoutContent.addComponent(this.layoutFields);
    	}
    }
    
    private void plotChart() throws Exception {
    	DCharts chart = generateChart().setEnableDownload(true).setDownloadButtonCaption("Salvar Gráfico").setDownloadButtonLocation(DownloadButtonLocation.BOTTOM_LEFT).setChartImageFormat(ChartImageFormat.PNG);
    	chart.setHeight("95%");
    	chart.show();
		
		this.panelChart.setContent(chart);
    }
    
    public abstract DCharts generateChart() throws Exception;
    
    @Override
	public void enter(ViewChangeEvent event) {
		// TODO Auto-generated method stub
		
	}
	
}
