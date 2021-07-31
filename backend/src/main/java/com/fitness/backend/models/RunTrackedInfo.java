package com.fitness.backend.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class RunTrackedInfo {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private int userID;
    private String date;    
    private String calorieBurned;
    private double distanceTraveled;
    @ElementCollection
    private List<String> locationCords;
}
