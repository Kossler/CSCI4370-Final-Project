package edu.uga.cs4370.controller;
import edu.uga.cs4370.db.DatabaseConnection;
import edu.uga.cs4370.*;

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

  @PostMapping("/login")
    public ModelAndView login(
      @RequestParam("email") String email,
      @RequestParam("password") String password) {
        ModelAndView mv = new ModelAndView();
        Login loginUser = new Login(email, password);
        if (loginUser.checkPassword()) {
          mv.setViewName("Home");
          return mv;
        } else {
          mv.setViewName("/");
          mv.addObject("loginError", "The entered email or password is invalid.");
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

}
