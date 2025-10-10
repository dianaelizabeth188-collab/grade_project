# ============================================================
# FILE: grade3.impl.jac
# PURPOSE: Implementation logic for grade3.jac
# ============================================================

# --- grader walker logic ---
impl grader:
    can classify:
        std.out(f"Grading student with score {here.score} ...")

        if 80 <= here.score <= 100:
            here.grade = "A (Distinction)"
        elif 70 <= here.score <= 79:
            here.grade = "B (Credit)"
        elif 50 <= here.score <= 69:
            here.grade = "C (Pass)"
        elif 0 <= here.score <= 49:
            here.grade = "D (Fail)"
        else:
            here.grade = "Invalid score"

        # Request feedback from the LLM
        prompt = f"Explain why a student with a score of {here.score} received grade '{here.grade}', and suggest one improvement tip."
        here.feedback = llm.chat(prompt)

        # Display results
        std.out(f"Grade: {here.grade}")
        std.out(f"Feedback: {here.feedback}")


# --- registry walker logic ---
impl registry:
    can add_student:
        spawn -> student(score=here.score)
        std.out(f"Student with score {here.score} has been added to the registry.")
