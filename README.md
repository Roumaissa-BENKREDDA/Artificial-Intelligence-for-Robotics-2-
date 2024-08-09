# Artificial-Intelligence-for-Robotics-2-
This project involved creating a detailed AI planning model for a robotic coffee shop scenario using the Planning Domain Definition Language (PDDL). The scenario required two robots—a barista and a waiter—to collaborate on preparing and serving drinks to customers, as well as cleaning tables.




<h1 align="center"> AI for Robotics II - Assignment 1: AI Planning </h1>

> **Authors:**
> - *Ines Haouala* (S5483776)  
> - *Aicha Manar Abbad* (S5565902)  
> - *Romaissa Benkredda* (S5434673)  
> - *Triki Karim* (S5528602)
>
> **Professors:**
> - *Mauro Vallati*  
> - *Fulvio Mastrogiovanni*

**Submission Date:** May 9th, 2023

## Table of Contents

1. [Introduction](#introduction)
2. [PDDL (Planning Domain Definition Language)](#pddl)
3. [LPG Planner](#lpg-planner)
    * [Positive Aspects of LPG Planner](#positive-aspects)
    * [Negative Aspects of LPG Planner](#negative-aspects)
    * [LPG Planner Download and Setup](#download-lpg)
4. [Problem Statement](#problem-statement)
5. [Domain Description](#domain-description)
    * [Types Definition](#types-definition)
    * [Predicates](#predicates)
    * [Functions](#functions)
    * [Actions](#actions)
        - [move-robot](#move-robot)
        - [prepare-order](#prepare-order)
        - [take-order](#take-order)
        - [serve-order](#serve-order)
        - [clean-table](#clean-table)
        - [take-last-order](#take-last-order)
        - [prepare-tray](#prepare-tray)
        - [serve-tray-order](#serve-tray-order)
        - [take-tray](#take-tray)
        - [serve-tray](#serve-tray)
6. [Problem Files Description](#problem-files-description)
    * [Problem 1](#problem-1)
    * [Problem 2](#problem-2)
    * [Problem 3](#problem-3)
    * [Problem 4](#problem-4)
7. [Result Analysis](#result-analysis)
8. [Conclusion](#conclusion)
9. [References](#references)
10. [Appendices](#appendices)

---

<a name="introduction"></a>

## Introduction

This project focuses on AI planning in a robotic coffee shop scenario, where two robots—a barista and a waiter—collaborate to serve customers and maintain the coffee shop. The assignment involved creating models in PDDL (Planning Domain Definition Language) and using the LPG planner to generate and analyze plans that optimize the operations of the coffee shop.

This work demonstrates the potential of robotics and AI in automating tasks within the food and beverage industry, highlighting the challenges and opportunities in deploying robotic systems in real-world environments.

---

<a name="pddl"></a>

## PDDL (Planning Domain Definition Language)

PDDL is a modeling language used to define the planning problems and domains. It enables the encoding of application domains into planning domain models, facilitating automated planning through various planning engines. This project uses PDDL to model the robotic coffee shop scenario, defining the actions, predicates, and functions required for the planning process.

---

<a name="lpg-planner"></a>

## LPG Planner

The LPG planner is a widely used planning system based on heuristic search, particularly effective for solving PDDL-expressed planning problems. It leverages heuristics and A* search to explore the planning space efficiently, making it suitable for complex planning domains like the one presented in this project.

<a name="positive-aspects"></a>

### Positive Aspects of LPG Planner

- **Efficiency**: Rapid exploration of potential plans while avoiding unpromising paths.
- **Flexibility**: Supports a wide range of PDDL constructs, making it versatile for different planning problems.
- **Accuracy**: The heuristic function of LPG provides precise cost estimates for transitions between states.
- **Open Source**: LPG is freely available and can be modified to suit specific needs.
- **Support for Durative Actions**: Essential for this project, as actions like moving and preparing orders have durations.

<a name="negative-aspects"></a>

### Negative Aspects of LPG Planner

- **Limited Expressivity**: May not cover more advanced modeling elements or non-standard constraints.
- **Tuning Requirements**: Performance can vary depending on the specific problem domain and the heuristic parameters used.
- **Complexity**: The planner can be challenging to configure, particularly for users new to PDDL or automated planning.
- **Resource Intensive**: Large or complex problems may require significant computational resources.

<a name="download-lpg"></a>

### LPG Planner Download and Setup

To download and set up the LPG planner, visit the [LPG++ download page](http://helios.hud.ac.uk/scommv/storage/lpg++). After downloading, navigate to the LPG++ directory in your terminal and run the following command:

```bash
./lpg++ -o waiterrobot.pddl -f waiterrobot_p4.pddl -n 1
