package edu.uga.cs4370;
import edu.uga.cs4370.db.DatabaseConnection;
import edu.uga.cs4370.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.mindrot.jbcrypt.BCrypt;
 

public class Login {
  String email;
  String password;

  public Login(String email, String password) {
    this.email = email;
    this.password = password;
  }

  public User findUser() {
    User user = null;
        String sql = "SELECT email, password FROM users WHERE email = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {
            
            statement.setString(1, email);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                String hashedPassword = rs.getString("password");
                user = new User(email, hashedPassword);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
  }

  public Boolean checkPassword() {
    User user = findUser();
    if (user != null && BCrypt.checkpw(password, user.getHashedPassword())) {
      return true;
    } else {
      return false;
    }
  }
}
