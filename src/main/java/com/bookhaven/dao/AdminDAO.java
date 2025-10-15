package com.bookhaven.dao;

import com.bookhaven.model.Admin;
import com.bookhaven.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Data Access Object for Admin operations
 */
public class AdminDAO {
    
    /**
     * Validate admin credentials
     */
    public Admin validateAdmin(String username, String password) {
        String query = "SELECT * FROM admins WHERE username = ? AND password = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractAdminFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Get admin by username
     */
    public Admin getAdminByUsername(String username) {
        String query = "SELECT * FROM admins WHERE username = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractAdminFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Add new admin
     */
    public boolean addAdmin(Admin admin) {
        String query = "INSERT INTO admins (username, password, email) VALUES (?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, admin.getUsername());
            pstmt.setString(2, admin.getPassword());
            pstmt.setString(3, admin.getEmail());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Extract Admin object from ResultSet
     */
    private Admin extractAdminFromResultSet(ResultSet rs) throws SQLException {
        Admin admin = new Admin();
        admin.setId(rs.getInt("id"));
        admin.setUsername(rs.getString("username"));
        admin.setPassword(rs.getString("password"));
        admin.setEmail(rs.getString("email"));
        return admin;
    }
}
