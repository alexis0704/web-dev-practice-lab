package com.example.student_mgmt;

import com.example.student_mgmt.Student;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {

    public List<Student> findAll() throws SQLException {
        String sql = "SELECT id, student_code, full_name, email, major, created_at FROM students ORDER BY id";
        List<Student> list = new ArrayList<>();
        try (Connection con = DBUtil.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Student s = map(rs);
                list.add(s);
            }
        }
        return list;
    }

    public Student findById(int id) throws SQLException {
        String sql = "SELECT id, student_code, full_name, email, major, created_at FROM students WHERE id=?";
        try (Connection con = DBUtil.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? map(rs) : null;
            }
        }
    }

    public void insert(String code, String name, String email, String major) throws SQLException {
        String sql = "INSERT INTO students (student_code, full_name, email, major) VALUES (?,?,?,?)";
        try (Connection con = DBUtil.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, code);
            ps.setString(2, name);
            ps.setString(3, emptyToNull(email));
            ps.setString(4, emptyToNull(major));
            ps.executeUpdate();
        }
    }

    public int update(int id, String name, String email, String major) throws SQLException {
        String sql = "UPDATE students SET full_name=?, email=?, major=? WHERE id=?";
        try (Connection con = DBUtil.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, emptyToNull(email));
            ps.setString(3, emptyToNull(major));
            ps.setInt(4, id);
            return ps.executeUpdate();
        }
    }

    public int delete(int id) throws SQLException {
        String sql = "DELETE FROM students WHERE id=?";
        try (Connection con = DBUtil.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate();
        }
    }

    private static Student map(ResultSet rs) throws SQLException {
        Student s = new Student();
        s.setId(rs.getInt("id"));
        s.setStudentCode(rs.getString("student_code"));
        s.setFullName(rs.getString("full_name"));
        s.setEmail(rs.getString("email"));
        s.setMajor(rs.getString("major"));
        s.setCreatedAt(rs.getTimestamp("created_at"));
        return s;
    }

    private static String emptyToNull(String v) {
        return (v == null || v.isBlank()) ? null : v;
    }
}
