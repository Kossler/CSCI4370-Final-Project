package edu.uga.cs4370;
import edu.uga.cs4370.db.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.mindrot.jbcrypt.BCrypt;
 

public class Registration {
  String firstName;
  String lastName;
  String email;
  String hashedPassword;

  public Registration(String firstName, String lastName, String email, String password) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
  }

  public void insertUser() {
    System.out.println(firstName);
    System.out.println(lastName);
    System.out.println(email);
    System.out.println(hashedPassword);
    // try {
    //   String sql = "INSERT INTO User (firstName, lastName, email, password) VALUES (?, ?, ?, ?)";
    //   Connection conn = DatabaseConnection.getConnection();
    //   PreparedStatement preparedStatement = conn.prepareStatement(sql);
    //   preparedStatement.setString(0, firstName);
    //   preparedStatement.setString(1, lastName);
    //   preparedStatement.setString(2, email);
    //   preparedStatement.setString(3, hashedPassword);
    //   preparedStatement.executeUpdate();
    // } catch (SQLException e) {
    //   e.printStackTrace();
    // }
  }
}
