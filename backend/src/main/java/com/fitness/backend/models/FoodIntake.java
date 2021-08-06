package com.fitness.backend.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class FoodIntake {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private String foodName;
    private double calorieTaken;
    private String date;
    private int userId;
    private String dietId;
}
