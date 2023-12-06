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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
public class WebController {

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
          mv.setViewName("Home");
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
    ModelAndView mv = new ModelAndView("Home ");
    return mv;
  }

}
