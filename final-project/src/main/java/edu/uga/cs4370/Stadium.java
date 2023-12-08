package edu.uga.cs4370;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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

    public Stadium(String name) {
        this.name = name;
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

    public void removeStadium() {
      String findID = "SELECT stadium_id FROM Stadiums WHERE stadium_name = ?";
      String removeStadiums = "DELETE FROM Stadiums WHERE stadium_id = ?";
      String removeGames = "DELETE FROM Games WHERE stadium_id = ?";
      try (
        Connection conn = DatabaseConnection.getConnection();
        PreparedStatement findIdStatement = conn.prepareStatement(findID)) {
 
        findIdStatement.setString(1, name);
        ResultSet results = findIdStatement.executeQuery();
    
        if (results.next()) {
            String id = results.getString("stadium_id");
    
            try (PreparedStatement removeStadiumsStmt = conn.prepareStatement(removeStadiums);
                  PreparedStatement removeGamesStmt = conn.prepareStatement(removeGames)) {
                
                // Delete references in Games table
                removeGamesStmt.setString(1, id);
                removeGamesStmt.executeUpdate();
    
                // Delete stadium
                removeStadiumsStmt.setString(1, id);
                removeStadiumsStmt.executeUpdate();
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
        // Handle exceptions
    }
  }
}

