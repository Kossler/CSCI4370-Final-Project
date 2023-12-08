package edu.uga.cs4370;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import edu.uga.cs4370.db.DatabaseConnection;

public class Stadium {
    private String name;
    private String city;
    private String state;
    private String yearOpened;
    private String capacity;
    private String surface;


    public Stadium(String name, String city, String state, String yearOpened, String capacity, String surface) {
        this.name = name;
        this.city = city;
        this.state = state;
        this.yearOpened = yearOpened;
        this.capacity = capacity;
        this.surface = surface;
    }

    public void insertStadium() {
    try {
      String sql = "INSERT INTO Stadiums (stadium_name, city, state, capacity, surface, year_opened) VALUES (?, ?, ?, ?, ?, ?)";
      Connection conn = DatabaseConnection.getConnection();
      PreparedStatement preparedStatement = conn.prepareStatement(sql);
      preparedStatement.setString(1, name);
      preparedStatement.setString(2, city);
      preparedStatement.setString(3, state);
      preparedStatement.setString(4, capacity);
      preparedStatement.setString(5, surface);
      preparedStatement.setString(6, yearOpened);
      preparedStatement.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }
}

