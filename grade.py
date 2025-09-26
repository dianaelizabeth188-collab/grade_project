def get_grade(score):
    if 80 <= score <= 100:
        return "A (Distinction)"
    elif 70 <= score <= 79:
        return "B (Credit)"
    elif 50 <= score <= 69:
        return "C (Pass)"
    elif 0 <= score <= 49:
        return "D (Fail)"
    else:
        return "Invalid score"

# Example usage
if __name__ == "__main__":
    try:
        score = int(input("Enter student score (0-100): "))
        print("Grade:", get_grade(score))
    except ValueError:
        print("Please enter a valid number.")
