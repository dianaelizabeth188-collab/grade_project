# ============================================================
# FILE: grade3.jac
# PROJECT: AI-Enhanced Grading System
# AUTHOR: Diana Elizabeth
# DESCRIPTION:
#   This file declares the system architecture: nodes, globals,
#   and walkers. The logic is implemented separately in
#   'grade3.impl.jac' using the `impl` keyword.
# ============================================================

# --- Import global resources ---
import from byllm.llm { Model }

# --- Global AI model instance ---
glob llm = Model(model_name="gemini/gemini-2.0-flash", verbose=False)

# --- Node Definitions ---
node root:
    doc "Root node: entry point for the grading system."

node student:
    has int score = 0
    has str grade = "Unassigned"
    has str feedback = "No feedback yet"
    doc "Represents a student with score, grade, and AI-generated feedback."


# --- Walker Declarations ---
walker grader:
    can classify
    doc "Grades a student and provides AI-based feedback."

walker registry:
    can add_student
    doc "Adds new student nodes dynamically."


# --- Entry Point ---
root:
    # Example student creation
    spawn -> student(score=88) as s

    # Trigger the grading walker
    spawn walker::grader from here -> s
