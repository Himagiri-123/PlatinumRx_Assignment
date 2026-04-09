def convert_minutes(total_minutes):
  
    hours = total_minutes // 60

    minutes = total_minutes % 60
    
    if hours == 1:
        hr_text = "hr"
    else:
        hr_text = "hrs"
        
    print(f"{total_minutes} becomes \"{hours} {hr_text} {minutes} minutes\"")


convert_minutes(130)
convert_minutes(110)