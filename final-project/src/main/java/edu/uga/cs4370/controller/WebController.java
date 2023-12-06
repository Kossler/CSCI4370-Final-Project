package edu.uga.cs4370.controller;
import edu.uga.cs4370.db.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.*;
import java.sql.ResultSet;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class WebController {
  
  @GetMapping("/")
    public ModelAndView root() {
        ModelAndView mv = new ModelAndView("Login");
        return mv;
    }

  @GetMapping("/register")
    public ModelAndView registration() {
        ModelAndView mv = new ModelAndView("Register");
        return mv;
    }

}
