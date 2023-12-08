package edu.uga.cs4370.controller;
import edu.uga.cs4370.db.DatabaseConnection;
import edu.uga.cs4370.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.*;
import java.sql.ResultSet;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mysql.cj.jdbc.result.ResultSetMetaData;

import java.sql.SQLException;


@Controller
public class WebController {

  User user;

  @GetMapping("/")
  public ModelAndView root() {
      ModelAndView mv = new ModelAndView("Login");
      mv.addObject("loginError", "");
      return mv;
  }

  @PostMapping("/login")
    public ModelAndView login(
      @RequestParam("email") String email,
      @RequestParam("password") String password,
      RedirectAttributes redirectAttributes) {
        ModelAndView mv = new ModelAndView();
        Login loginUser = new Login(email, password);
        if (loginUser.checkPassword()) {
          user = loginUser.findUser();
          mv.setViewName("redirect:/home");
          return mv;
        } else {
          redirectAttributes.addFlashAttribute("loginError", "The entered email or password is invalid.");
          mv.setViewName("redirect:/");
          return mv;
        }
    }

  @GetMapping("/register")
  public ModelAndView registration() {
      ModelAndView mv = new ModelAndView("Register");
      return mv;
  }

  @PostMapping("/register-user")
  public ModelAndView registration(
    @RequestParam("firstname") String firstName,
    @RequestParam("lastname") String lastName,
    @RequestParam("email") String email,
    @RequestParam("password") String password,
    @RequestParam("confirm-password") String confirmPassword) {
      Registration registerUser = new Registration(firstName, lastName, email, password);
      registerUser.insertUser();
      ModelAndView mv = new ModelAndView();
      mv.setViewName("redirect:/");
      return mv;
  }

  @GetMapping("/home")
  public ModelAndView home() {
    ModelAndView mv = new ModelAndView("Home");
    mv.addObject("firstName", user.getFirstName());
    mv.addObject("lastName", user.getLastName());
    return mv;
  }

  @GetMapping("/top_5_yards")
  public ModelAndView top5() {
    ModelAndView mv = new ModelAndView("Top5Yards");
    String passingYards = "SELECT P.first_name, P.last_name, T.team_name AS school, SUM(PGS.pass_yards) AS total_passing_yards FROM Player_Game_Statistics PGS JOIN Players P ON PGS.player_id = P.player_id JOIN Quarterbacks QB ON PGS.player_id = QB.player_id JOIN Teams T ON QB.team_id = T.team_id GROUP BY PGS.player_id, P.first_name, P.last_name, T.team_name ORDER BY total_passing_yards DESC LIMIT 5";
    String receivingYards = "SELECT P.first_name, P.last_name, T.team_name AS school, SUM(PGS.rec_yards) AS total_receiving_yards FROM Player_Game_Statistics PGS JOIN Players P ON PGS.player_id = P.player_id JOIN Wide_Receivers WR ON PGS.player_id = WR.player_id JOIN Teams T ON WR.team_id = T.team_id GROUP BY PGS.player_id, P.first_name, P.last_name, T.team_name ORDER BY total_receiving_yards DESC LIMIT 5";
    String rushingYards = "SELECT P.first_name, P.last_name, T.team_name AS school, SUM(PGS.rush_yards) AS total_rushing_yards FROM player_Game_Statistics PGS JOIN Players P ON PGS.player_id = P.player_id JOIN Running_Backs RB ON P.player_id = RB.player_id JOIN Teams T ON RB.team_id = T.team_id GROUP BY PGS.player_id, P.first_name, P.last_name, T.team_name ORDER BY total_rushing_yards DESC LIMIT 5";
    try {
      List<Map<String, Object>> topPassingYards = new ArrayList<>();
      Connection conn = DatabaseConnection.getConnection();
      PreparedStatement preparedStatement = conn.prepareStatement(passingYards);
      ResultSet results = preparedStatement.executeQuery();
      while (results.next()) {
        Map<String, Object> row = new HashMap<>();
        // Manually put each known column and its value
        row.put("first_name", results.getObject("first_name"));
        row.put("last_name", results.getObject("last_name"));
        row.put("school", results.getObject("school"));
        row.put("total_passing_yards", results.getObject("total_passing_yards"));
        // Add more columns as needed

        topPassingYards.add(row);
      }
      mv.addObject("passingYards", topPassingYards);

      List<Map<String, Object>> topReceivingYards = new ArrayList<>();
      preparedStatement = conn.prepareStatement(receivingYards);
      results = preparedStatement.executeQuery();
      while (results.next()) {
        Map<String, Object> row = new HashMap<>();
        // Manually put each known column and its value
        row.put("first_name", results.getObject("first_name"));
        row.put("last_name", results.getObject("last_name"));
        row.put("school", results.getObject("school"));
        row.put("total_receiving_yards", results.getObject("total_receiving_yards"));
        // Add more columns as needed

        topReceivingYards.add(row);
      }
      mv.addObject("receivingYards", topReceivingYards);

      List<Map<String, Object>> topRushingYards = new ArrayList<>();
      preparedStatement = conn.prepareStatement(rushingYards);
      results = preparedStatement.executeQuery();
      while (results.next()) {
        Map<String, Object> row = new HashMap<>();
        // Manually put each known column and its value
        row.put("first_name", results.getObject("first_name"));
        row.put("last_name", results.getObject("last_name"));
        row.put("school", results.getObject("school"));
        row.put("total_rushing_yards", results.getObject("total_rushing_yards"));
        // Add more columns as needed

        topRushingYards.add(row);
      }
      mv.addObject("rushingYards", topRushingYards);
    } catch (SQLException e) {
      e.printStackTrace();
    }
    
    return mv;
  }

  @GetMapping("/def_efficiency")
  public ModelAndView defEfficiency() {
    ModelAndView mv = new ModelAndView("DefEfficiency");
    String sacks = "SELECT T.team_name, ROUND(unioned_sacks.sacks / 12.0, 1) AS avg_sacks_per_game FROM Teams T JOIN (SELECT team_id, SUM(PGS.sack) AS sacks FROM Player_Game_Statistics PGS INNER JOIN (SELECT player_id, team_id FROM Quarterbacks UNION ALL SELECT player_id, team_id FROM Running_Backs UNION ALL SELECT player_id, team_id FROM Fullbacks UNION ALL SELECT player_id, team_id FROM Wide_Receivers UNION ALL SELECT player_id, team_id FROM Tight_Ends UNION ALL SELECT player_id, team_id FROM Kickers UNION ALL SELECT player_id, team_id FROM Offensive_Line UNION ALL SELECT player_id, team_id FROM Defensive_Line UNION ALL SELECT player_id, team_id FROM Linebackers UNION ALL SELECT player_id, team_id FROM Defensive_Backs UNION ALL SELECT player_id, team_id FROM Punters) AS AllPlayers ON PGS.player_id = AllPlayers.player_id GROUP BY team_id) AS unioned_sacks ON T.team_id = unioned_sacks.team_id GROUP BY T.team_id, T.team_name ORDER BY avg_sacks_per_game DESC LIMIT 5";
    String soloTackles = "SELECT T.team_name, ROUND(SUM(unioned_tackles.solo_tackles) / 12.0, 1) AS avg_solo_tackles_per_game FROM Teams T JOIN (SELECT team_id, SUM(PGS.solo_tackles) AS solo_tackles FROM Player_Game_Statistics PGS INNER JOIN (SELECT player_id, team_id FROM Quarterbacks UNION ALL SELECT player_id, team_id FROM Running_Backs UNION ALL SELECT player_id, team_id FROM Fullbacks UNION ALL SELECT player_id, team_id FROM Wide_Receivers UNION ALL SELECT player_id, team_id FROM Tight_Ends UNION ALL SELECT player_id, team_id FROM Kickers UNION ALL SELECT player_id, team_id FROM Offensive_Line UNION ALL SELECT player_id, team_id FROM Defensive_Line UNION ALL SELECT player_id, team_id FROM Linebackers UNION ALL SELECT player_id, team_id FROM Defensive_Backs UNION ALL SELECT player_id, team_id FROM Punters) AS AllPlayers ON PGS.player_id = AllPlayers.player_id GROUP BY team_id) AS unioned_tackles ON T.team_id = unioned_tackles.team_id GROUP BY T.team_id, T.team_name ORDER BY avg_solo_tackles_per_game DESC LIMIT 5";
    String interceptions = "SELECT T.team_name, ROUND(SUM(unioned_ints.ret_int) / 12.0, 1) AS avg_int_per_game FROM Teams T JOIN (SELECT team_id, SUM(PGS.ret_int) AS ret_int FROM Player_Game_Statistics PGS INNER JOIN (SELECT player_id, team_id FROM Quarterbacks UNION ALL SELECT player_id, team_id FROM Running_Backs UNION ALL SELECT player_id, team_id FROM Fullbacks UNION ALL SELECT player_id, team_id FROM Wide_Receivers UNION ALL SELECT player_id, team_id FROM Tight_Ends UNION ALL SELECT player_id, team_id FROM Kickers UNION ALL SELECT player_id, team_id FROM Offensive_Line UNION ALL SELECT player_id, team_id FROM Defensive_Line UNION ALL SELECT player_id, team_id FROM Linebackers UNION ALL SELECT player_id, team_id FROM Defensive_Backs UNION ALL SELECT player_id, team_id FROM Punters) AS AllPlayers ON PGS.player_id = AllPlayers.player_id GROUP BY team_id) AS unioned_ints ON T.team_id = unioned_ints.team_id GROUP BY T.team_id, T.team_name ORDER BY avg_int_per_game DESC LIMIT 5";
    String forcedFumbles = "SELECT T.team_name, ROUND(SUM(unioned_fumbles.forced_fumbles) / 12.0, 1) AS avg_forced_fumbles_per_game FROM Teams T JOIN (SELECT team_id, SUM(PGS.forced_fumbles) AS forced_fumbles FROM Player_Game_Statistics PGS INNER JOIN (SELECT player_id, team_id FROM Quarterbacks UNION ALL SELECT player_id, team_id FROM Running_Backs UNION ALL SELECT player_id, team_id FROM Fullbacks UNION ALL SELECT player_id, team_id FROM Wide_Receivers UNION ALL SELECT player_id, team_id FROM Tight_Ends UNION ALL SELECT player_id, team_id FROM Kickers UNION ALL SELECT player_id, team_id FROM Offensive_Line UNION ALL SELECT player_id, team_id FROM Defensive_Line UNION ALL SELECT player_id, team_id FROM Linebackers UNION ALL SELECT player_id, team_id FROM Defensive_Backs UNION ALL SELECT player_id, team_id FROM Punters) AS AllPlayers ON PGS.player_id = AllPlayers.player_id GROUP BY team_id) AS unioned_fumbles ON T.team_id = unioned_fumbles.team_id GROUP BY T.team_id, T.team_name ORDER BY avg_forced_fumbles_per_game DESC LIMIT 5";


    try {
      List<Map<String, Object>> avgSacks = new ArrayList<>();
      Connection conn = DatabaseConnection.getConnection();
      PreparedStatement preparedStatement = conn.prepareStatement(sacks);
      ResultSet results = preparedStatement.executeQuery();
      while (results.next()) {
        Map<String, Object> row = new HashMap<>();
        // Manually put each known column and its value
        row.put("team_name", results.getObject("team_name"));
        row.put("avg_sacks_per_game", results.getObject("avg_sacks_per_game"));
        // Add more columns as needed

        avgSacks.add(row);
      }
      mv.addObject("avgSacks", avgSacks);

      List<Map<String, Object>> avgTackles = new ArrayList<>();
      preparedStatement = conn.prepareStatement(soloTackles);
      results = preparedStatement.executeQuery();
      while (results.next()) {
        Map<String, Object> row = new HashMap<>();
        // Manually put each known column and its value
        row.put("team_name", results.getObject("team_name"));
        row.put("avg_solo_tackles_per_game", results.getObject("avg_solo_tackles_per_game"));
        // Add more columns as needed

        avgTackles.add(row);
      }
      mv.addObject("avgTackles", avgTackles);

      List<Map<String, Object>> avgInts = new ArrayList<>();
      preparedStatement = conn.prepareStatement(interceptions);
      results = preparedStatement.executeQuery();
      while (results.next()) {
        Map<String, Object> row = new HashMap<>();
        // Manually put each known column and its value
        row.put("team_name", results.getObject("team_name"));
        row.put("avg_int_per_game", results.getObject("avg_int_per_game"));
        // Add more columns as needed

        avgInts.add(row);
      }
      mv.addObject("avgInts", avgInts);

      List<Map<String, Object>> avgForcedFumbles = new ArrayList<>();
      preparedStatement = conn.prepareStatement(forcedFumbles);
      results = preparedStatement.executeQuery();
      while (results.next()) {
          Map<String, Object> row = new HashMap<>();
          row.put("team_name", results.getObject("team_name"));
          row.put("avg_forced_fumbles_per_game", results.getObject("avg_forced_fumbles_per_game"));
          avgForcedFumbles.add(row);
      }
      mv.addObject("avgForcedFumbles", avgForcedFumbles);

    } catch (SQLException e) {
      e.printStackTrace();
    }
    return mv;
  }

  @GetMapping("/points_scored")
  public ModelAndView pointsScored() {
    ModelAndView mv = new ModelAndView("PointsScored");
    String totalPointsPerConference = "SELECT C.conference_name, ROUND((SUM(PGS.points) / TeamCounts.team_count) / 12.0, 1) AS avg_points_per_conference FROM Player_Game_Statistics PGS JOIN (SELECT player_id, team_id FROM Quarterbacks UNION ALL SELECT player_id, team_id FROM Running_Backs UNION ALL SELECT player_id, team_id FROM Fullbacks UNION ALL SELECT player_id, team_id FROM Wide_Receivers UNION ALL SELECT player_id, team_id FROM Tight_Ends UNION ALL SELECT player_id, team_id FROM Kickers UNION ALL SELECT player_id, team_id FROM Offensive_Line UNION ALL SELECT player_id, team_id FROM Defensive_Line UNION ALL SELECT player_id, team_id FROM Linebackers UNION ALL SELECT player_id, team_id FROM Defensive_Backs UNION ALL SELECT player_id, team_id FROM Punters) AS AllPositions ON PGS.player_id = AllPositions.player_id JOIN Teams T ON AllPositions.team_id = T.team_id JOIN Conferences C ON T.conference_id = C.conference_id JOIN (SELECT conference_id, COUNT(*) AS team_count FROM Teams GROUP BY conference_id) AS TeamCounts ON C.conference_id = TeamCounts.conference_id GROUP BY C.conference_id, C.conference_name ORDER BY avg_points_per_conference DESC";


    try {
      List<Map<String, Object>> avgPoints = new ArrayList<>();
      Connection conn = DatabaseConnection.getConnection();
      PreparedStatement preparedStatement = conn.prepareStatement(totalPointsPerConference);
      ResultSet results = preparedStatement.executeQuery();
      while (results.next()) {
        Map<String, Object> row = new HashMap<>();
        // Manually put each known column and its value
        row.put("conference_name", results.getObject("conference_name"));
        row.put("avg_points_per_conference", results.getObject("avg_points_per_conference"));
        // Add more columns as needed

        avgPoints.add(row);
      }
      mv.addObject("avgPoints", avgPoints);

    } catch (SQLException e) {
      e.printStackTrace();
    }
    return mv;
  }

  @GetMapping("/top_uga")
  public ModelAndView topUGA() {
    ModelAndView mv = new ModelAndView("TopUGA");
    String qbQuery = "SELECT P.first_name, P.last_name, SUM(PGS.pass_yards) AS total_passing_yards FROM Quarterbacks QB JOIN Player_Game_Statistics PGS ON QB.player_id = PGS.player_id JOIN Players P ON QB.player_id = P.player_id JOIN Teams T ON QB.team_id = T.team_id WHERE T.team_name = 'Georgia' GROUP BY QB.player_id ORDER BY total_passing_yards DESC LIMIT 1;";
    String teQuery = "SELECT P.first_name, P.last_name, SUM(PGS.rec_yards) AS total_receiving_yards FROM Tight_Ends TE JOIN Player_Game_Statistics PGS ON TE.player_id = PGS.player_id JOIN Players P ON TE.player_id = P.player_id JOIN Teams T ON TE.team_id = T.team_id WHERE T.team_name = 'Georgia' GROUP BY TE.player_id ORDER BY total_receiving_yards DESC LIMIT 1;";
    String lbQuery = "SELECT P.first_name, P.last_name, SUM(PGS.solo_tackles) AS total_solo_tackles FROM Linebackers LB JOIN Player_Game_Statistics PGS ON LB.player_id = PGS.player_id JOIN Players P ON LB.player_id = P.player_id JOIN Teams T ON LB.team_id = T.team_id WHERE T.team_name = 'Georgia' GROUP BY LB.player_id ORDER BY total_solo_tackles DESC LIMIT 1;";
    String punterQuery = "SELECT PL.first_name, PL.last_name, SUM(PGS.punt_yards) AS total_punt_yards FROM Punters P JOIN Player_Game_Statistics PGS ON P.player_id = PGS.player_id JOIN Players PL ON P.player_id = PL.player_id JOIN Teams T ON P.team_id = T.team_id WHERE T.team_name = 'Georgia' GROUP BY P.player_id ORDER BY total_punt_yards DESC LIMIT 1;";
    String pkQuery = "SELECT P.first_name, P.last_name, SUM(PGS.points) AS total_points FROM Kickers PK JOIN Player_Game_Statistics PGS ON PK.player_id = PGS.player_id JOIN Players P ON PK.player_id = P.player_id JOIN Teams T ON PK.team_id = T.team_id WHERE T.team_name = 'Georgia' GROUP BY PK.player_id ORDER BY total_points DESC LIMIT 1;";

    try {
      List<Map<String, Object>> qb = new ArrayList<>();
      Connection conn = DatabaseConnection.getConnection();
      PreparedStatement preparedStatement = conn.prepareStatement(qbQuery);
      ResultSet results = preparedStatement.executeQuery();
      while (results.next()) {
        Map<String, Object> row = new HashMap<>();
        // Manually put each known column and its value
        row.put("first_name", results.getObject("first_name"));
        row.put("last_name", results.getObject("last_name"));
        row.put("total_passing_yards", results.getObject("total_passing_yards"));
        // Add more columns as needed

        qb.add(row);
      }
      mv.addObject("qb", qb);

      List<Map<String, Object>> te = new ArrayList<>();
      preparedStatement = conn.prepareStatement(teQuery);
      results = preparedStatement.executeQuery();
      while (results.next()) {
          Map<String, Object> row = new HashMap<>();
          row.put("first_name", results.getObject("first_name"));
          row.put("last_name", results.getObject("last_name"));
          row.put("total_receiving_yards", results.getObject("total_receiving_yards"));
          te.add(row);
      }
      mv.addObject("te", te);

      List<Map<String, Object>> lb = new ArrayList<>();
      preparedStatement = conn.prepareStatement(lbQuery);
      results = preparedStatement.executeQuery();
      while (results.next()) {
          Map<String, Object> row = new HashMap<>();
          row.put("first_name", results.getObject("first_name"));
          row.put("last_name", results.getObject("last_name"));
          row.put("total_solo_tackles", results.getObject("total_solo_tackles"));
          lb.add(row);
      }
      mv.addObject("lb", lb);

      List<Map<String, Object>> p = new ArrayList<>();
      preparedStatement = conn.prepareStatement(punterQuery);
      results = preparedStatement.executeQuery();
      while (results.next()) {
          Map<String, Object> row = new HashMap<>();
          row.put("first_name", results.getObject("first_name"));
          row.put("last_name", results.getObject("last_name"));
          row.put("total_punt_yards", results.getObject("total_punt_yards"));
          p.add(row);
      }
      mv.addObject("p", p);

      List<Map<String, Object>> pk = new ArrayList<>();
      preparedStatement = conn.prepareStatement(pkQuery);
      results = preparedStatement.executeQuery();
      while (results.next()) {
          Map<String, Object> row = new HashMap<>();
          row.put("first_name", results.getObject("first_name"));
          row.put("last_name", results.getObject("last_name"));
          row.put("total_points", results.getObject("total_points"));
          pk.add(row);
      }
      mv.addObject("pk", pk);

    } catch (SQLException e) {
      e.printStackTrace();
    }
    return mv;
  }

    @GetMapping("/stadiums")
  public ModelAndView stadiums() {
    ModelAndView mv = new ModelAndView("Stadiums");
    String stadiumsQuery = "SELECT stadium_name, city, state, year_opened, capacity, surface FROM Stadiums ORDER BY year_opened DESC;";


    try {
      List<Map<String, Object>> stadiums = new ArrayList<>();
      Connection conn = DatabaseConnection.getConnection();
      PreparedStatement preparedStatement = conn.prepareStatement(stadiumsQuery);
      ResultSet results = preparedStatement.executeQuery();
      while (results.next()) {
        Map<String, Object> row = new HashMap<>();
        // Manually put each known column and its value
        row.put("stadium_name", results.getObject("stadium_name"));
        row.put("city", results.getObject("city"));
        row.put("state", results.getObject("state"));
        row.put("year_opened", results.getObject("year_opened"));
        row.put("capacity", results.getObject("capacity"));
        row.put("surface", results.getObject("surface"));
        // Add more columns as needed

        stadiums.add(row);
      }
      mv.addObject("stadiums", stadiums);

    } catch (SQLException e) {
      e.printStackTrace();
    }
    return mv;
  }

  @GetMapping("/add_stadium")
  public ModelAndView addStadiums() {
    ModelAndView mv = new ModelAndView("AddStadiums");
    return mv;
  }

  @PostMapping("/insert_stadium")
  public ModelAndView insertStadiums(
    @RequestParam("name") String name,
    @RequestParam("city") String city,
    @RequestParam("state") String state,
    @RequestParam("yearOpened") String yearOpened,
    @RequestParam("capacity") String capacity,
    @RequestParam("surface") String surface) {
      Stadium insertStadium = new Stadium(name, city, state, yearOpened, capacity, surface);
      insertStadium.insertStadium();
      ModelAndView mv = new ModelAndView();
      mv.setViewName("redirect:/stadiums");
      return mv;
  }

  @GetMapping("/remove_stadium")
  public ModelAndView removeStadiums() {
    ModelAndView mv = new ModelAndView("RemoveStadiums");
    return mv;
  }

  @PostMapping("/delete_stadium")
  public ModelAndView deleteStadiums(
    @RequestParam("name") String name) {
      
      ModelAndView mv = new ModelAndView();
      mv.setViewName("redirect:/stadiums");
      return mv;
  }
}
