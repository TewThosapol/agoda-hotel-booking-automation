*** Settings ***
Library    SeleniumLibrary
Resource    ../keywords/Agoda-keyword.robot

*** Variables ***
${City}    Bangkok
${Num_rooms}  1
${Num_adults}   2
${Min_price}  5000
${Max_price}  20000
${Filter_text}  Internet access
${Filter_Type}    Hotel
${First_name}    John
${Last_Name}    Doe
${Contact_email}    Johndoe@gmail.com
${Contact_PhoneNumber}    0812345678
${Special_offer}    Non-smoking
${CardHolderName}    Johndoetest
${CardNumber}    1111 2222 3333 4444
${Expiry_Date}    11/27
${Cvv}    133


*** Test Cases ***
Agoda Booking Hotel
    Open Agoda
    Search For City    ${City}
    Select Travel Dates
    Add Rooms     ${Num_rooms}
    Add Travelers      ${Num_adults}
    Submit Search        
    Switch To Results Tab
    Filter Price Range    ${Min_price}    ${Max_price}
    Filter Option     ${Filter_text} 
    Filter Type    ${Filter_Type}
    Select First Hotel
    Click View Detail
    Click Book Now
    Fill Contact First Name     ${first_name}
    Fill Contact Last Name     ${last_name}
    Fill Contact Email    ${contact_email}
    Fill Contact Phone Number  ${contact_phonenumber}
    Select Special Offer    ${Special_offer}
    Click Final Step
    Capture Page Screenshot    booking-confirmation.png
    [Teardown]    Close Browser