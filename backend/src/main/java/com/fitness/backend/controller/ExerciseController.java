package com.fitness.backend.controller;

import com.fitness.backend.models.ExerciseInfo;
import com.fitness.backend.services.ExerciseServices;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/exercise")
public class ExerciseController {

    private final ExerciseServices exerciseServices;

    public ExerciseController(ExerciseServices exerciseServices) {
        this.exerciseServices = exerciseServices;
    }


    @PostMapping("/")
    public ExerciseInfo addExerciseInfo(@RequestBody ExerciseInfo exerciseInfo){
        return exerciseServices.addExerciseInfo(exerciseInfo);
    }

    @GetMapping("/{id}")
    public ExerciseInfo getExerciseInfo(@PathVariable int id){
        return exerciseServices.getExerciseInfo(id);
    }

    @GetMapping("/all/{userID}")
    public List<ExerciseInfo> getAllExerciseInfoOfUser(@PathVariable int userID){
        return exerciseServices.getAllExerciseInfoOfUser(userID);
    }

    @PutMapping("/")
    public ExerciseInfo editExerciseInfo(@RequestBody ExerciseInfo exerciseInfo){
        return null;
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Map<String, String>> deleteExerciseInfo(@PathVariable int id){
        return new ResponseEntity<>(exerciseServices.deleteExerciseInfo(id), HttpStatus.OK);
    }


}
