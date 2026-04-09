def remove_duplicates(input_string):
    
    unique_string = ""
    
   
    for char in input_string:

        if char not in unique_string:
            unique_string += char
            
    print(f"Original String: {input_string}")
    print(f"Unique String: {unique_string}")


remove_duplicates("apple")
remove_duplicates("programming")