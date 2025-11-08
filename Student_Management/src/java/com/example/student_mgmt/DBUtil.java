package com.example.student_mgmt;

import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

public class DBUtil {
    private static String url;
    private static String user;
    private static String pass;

    static {
        try {
            Properties props = new Properties();
            try (InputStream in = DBUtil.class.getClassLoader().getResourceAsStream("db.properties")) {
                if (in == null) throw new RuntimeException("db.properties not found on classpath");
                props.load(in);
            }
            url  = props.getProperty("db.url");
            user = props.getProperty("db.user");
            pass = props.getProperty("db.password");
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception e) {
            throw new RuntimeException("Failed to init DBUtil", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, user, pass);
    }
}
