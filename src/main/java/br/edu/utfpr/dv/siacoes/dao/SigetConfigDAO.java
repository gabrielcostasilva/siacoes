package br.edu.utfpr.dv.siacoes.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import br.edu.utfpr.dv.siacoes.model.SigetConfig;
import br.edu.utfpr.dv.siacoes.model.SigetConfig.SupervisorFilter;

public class SigetConfigDAO {

	public SigetConfig findByDepartment(int idDepartment) throws SQLException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try{
			conn = ConnectionDAO.getInstance().getConnection();
			stmt = conn.prepareStatement("SELECT * FROM sigetconfig WHERE idDepartment = ?");
		
			stmt.setInt(1, idDepartment);
			
			rs = stmt.executeQuery();
			
			if(rs.next()){
				return this.loadObject(rs);
			}else{
				return null;
			}
		}finally{
			if((rs != null) && !rs.isClosed())
				rs.close();
			if((stmt != null) && !stmt.isClosed())
				stmt.close();
			if((conn != null) && !conn.isClosed())
				conn.close();
		}
	}
	
	public int save(SigetConfig config) throws SQLException{
		boolean insert = (this.findByDepartment(config.getDepartment().getIdDepartment()) == null);
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try{
			conn = ConnectionDAO.getInstance().getConnection();
			
			if(insert){
				stmt = conn.prepareStatement("INSERT INTO sigetconfig(minimumScore, registerProposal, showgradestostudent, supervisorfilter, cosupervisorfilter, idDepartment) VALUES(?, ?, ?, ?, ?, ?)");
			}else{
				stmt = conn.prepareStatement("UPDATE sigetconfig SET minimumScore=?, registerProposal=?, showgradestostudent=?, supervisorfilter=?, cosupervisorfilter=? WHERE idDepartment=?");
			}
			
			stmt.setDouble(1, config.getMinimumScore());
			stmt.setInt(2, (config.isRegisterProposal() ? 1 : 0));
			stmt.setInt(3, config.isShowGradesToStudent() ? 1 : 0);
			stmt.setInt(4, config.getSupervisorFilter().getValue());
			stmt.setInt(5, config.getCosupervisorFilter().getValue());
			stmt.setInt(6, config.getDepartment().getIdDepartment());
			
			stmt.execute();
			
			return config.getDepartment().getIdDepartment();
		}finally{
			if((stmt != null) && !stmt.isClosed())
				stmt.close();
			if((conn != null) && !conn.isClosed())
				conn.close();
		}
	}
	
	private SigetConfig loadObject(ResultSet rs) throws SQLException{
		SigetConfig config = new SigetConfig();
		
		config.getDepartment().setIdDepartment(rs.getInt("idDepartment"));
		config.setMinimumScore(rs.getDouble("minimumScore"));
		config.setRegisterProposal(rs.getInt("registerProposal") == 1);
		config.setShowGradesToStudent(rs.getInt("showgradestostudent") == 1);
		config.setSupervisorFilter(SupervisorFilter.valueOf(rs.getInt("supervisorFilter")));
		config.setCosupervisorFilter(SupervisorFilter.valueOf(rs.getInt("cosupervisorFilter")));
		
		return config;
	}
	
}
