# --------------------------------------------
# JAC PROGRAM: Grade Classification System
# --------------------------------------------

# --- Node type representing the system root ---
node root;

# --- Node type representing a student ---
node student {
    has int score;
    has str grade;
}

# --- Walker that performs grading logic ---
walker grader {
    can classify;

    # The walker entry point
    start {
        take -> classify;
    }
}

# --- Implementations ---
impl grader {
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

        std.out("Score: " + str(here.score) + " -> Grade: " + here.grade);
    }
}

# --- Execution section ---
# Create a student node and attach it to the root
root {
    spawn -> student(score=85) as s;
    spawn walker::grader from here -> s;
}
