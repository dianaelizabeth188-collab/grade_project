# ------------------------------------------------------------
# FILE: grade2.jac
# PROJECT: Grade Classification API System
# ------------------------------------------------------------
# Scale-agnostic Jac program.
# Runs locally or scales to cloud deployment seamlessly.
# When launched using `jac serve grade2.jac`,
# the walkers become REST API endpoints callable via HTTP.
# ------------------------------------------------------------

# --- Node definitions ---

node root;

node student {
    has score;
    has grade;
}


# --- Walker Declarations ---
walker grader;     # Performs grade classification
walker registry;   # Adds new students dynamically


# --- Implementations ---

impl grader {
    can classify;

    can classify {
        if here.score >= 80 and here.score <= 100:
            here.grade = "A (Distinction)";
        elif here.score >= 70 and here.score <= 79:
            here.grade = "B (Credit)";
        elif here.score >= 50 and here.score <= 69:
            here.grade = "C (Pass)";
        elif here.score >= 0 and here.score <= 49:
            here.grade = "D (Fail)";
        else:
            here.grade = "Invalid score";

        std.out("Score: " + str(here.score) + " → Grade: " + here.grade);
    }
}

impl registry {
    can add_student;

    can add_student {
        spawn -> student(score=here.score);
        std.out("Student with score " + str(here.score) + " registered.");
    }
}


# --- Execution / Initialization Section ---

root {
    # Example: Add and grade a sample student
    spawn -> student(score=85) as s;
    spawn walker::grader from here -> s;
}

# ------------------------------------------------------------
# DEPLOYMENT NOTES
# ------------------------------------------------------------
# ▶ Local Run:
#   jac run grade2.jac
#
# ▶ API Mode (local or cloud):
#   jac serve grade2.jac
#
# This automatically exposes the following REST endpoints:
#
#   POST /api/grader/classify
#       → Classify a student's score
#
#   POST /api/registry/add_student
#       → Add a new student with score data
#
# Example request (using curl):
#
#   curl -X POST http://127.0.0.1:8000/api/grader/classify \
#        -H "Content-Type: application/json" \
#        -d '{"score": 92}'
#
# This structure ensures scalability with no code modification.
# ------------------------------------------------------------
