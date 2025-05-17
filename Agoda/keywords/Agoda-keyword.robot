*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Open Agoda
    Open Browser    https://www.agoda.com   chrome
    Maximize Browser Window

Search For City
    [Arguments]    ${city}
    Input Text    xpath=//*[@id="textInput"]    ${city}
    Wait Until Element Is Visible    xpath=//*[@id="search-box-autocomplete-id"]/div/ul/li[1]    5s
    Click Element    xpath=//*[@id="search-box-autocomplete-id"]/div/ul/li[1]

Select Travel Dates
    #Open the date picker calendar
    Wait Until Element Is Visible    xpath=//*[@id="DatePicker__AccessibleV2"]/div/div[1]/div[2]/button    5s
    Click Element                    xpath=//*[@id="DatePicker__AccessibleV2"]/div/div[1]/div[2]/button

    #Date to go
    Wait Until Element Is Visible    xpath=//span[text()='20']    5s
    Click Element                    xpath=//span[text()='20']

    #Day to back
    Wait Until Element Is Visible    xpath=//span[text()='22']    5s
    Click Element                    xpath=//span[text()='22']

Add Rooms
    [Arguments]    ${num_rooms}
    Wait Until Element Is Visible    xpath=//*[@id="FocusTrap"]/div/div/div[1]/div[2]/div[2]    5s   
    FOR    ${i}    IN RANGE    ${num_rooms}
        Click Element    xpath=//*[@id="FocusTrap"]/div/div/div[1]/div[2]/div[2]
    END

Add Travelers
    [Arguments]    ${num_adults}
    Wait Until Element Is Visible    xpath=//*[@id="FocusTrap"]/div/div[1]/div[2]/div[2]/button[2]    5s
    FOR    ${i}    IN RANGE    ${num_adults}
        Click Element    xpath=//*[@id="FocusTrap"]/div/div[1]/div[2]/div[2]/button[2]
    END

Submit Search
    Wait Until Element Is Visible    xpath=//*[@id="Tabs-Container"]/button/div    5s
    Click Element    xpath=//*[@id="Tabs-Container"]/button/div
    Sleep    1s

Switch To Results Tab
    ${handles}=    Get Window Handles
    Log    ${handles}
    Switch Window    ${handles[1]}
    Sleep    1s

Filter Price Range
    [Arguments]    ${min_price}    ${max_price}
    Input Text    id=price_box_0    ${min_price}
    Input Text    id=price_box_1    ${max_price}

Filter Option
    [Arguments]    ${filter_text}
    Click Element    xpath=//span[normalize-space(text())='${filter_text}']/ancestor::label//input[@type='checkbox']

Filter Type
    [Arguments]    ${filter_type}
    Click Element    xpath=//span[normalize-space(text())='${filter_type}']/ancestor::label//input[@type='checkbox']

Select First Hotel
    Wait Until Element Is Visible    xpath=(//ol[1]/li[contains(@data-selenium, "hotel-item")])[1]    10s
    Scroll Element Into View         xpath=(//ol[1]/li[contains(@data-selenium, "hotel-item")])[1]
    ${first_hotel_link}=             Get Element Attribute    xpath=(//ol[1]/li[contains(@data-selenium, "hotel-item")])[1]//a    href
    Go To                            ${first_hotel_link}


Click View Detail
    Wait Until Element Is Visible    xpath=//*[@id="hotelNavBar"]/nav/div/div/div[2]/div/div/button    10s
    Click Element                    xpath=//*[@id="hotelNavBar"]/nav/div/div/div[2]/div/div/button
    Sleep    1s

Click Book Now
    Wait Until Element Is Visible    xpath=//button[normalize-space(.)='Book now']   10s
    Click Element    xpath=//button[normalize-space(.)='Book now']
    Sleep    2s

Fill Contact Firstname
    [Arguments]    ${first_name}
    Input Text    id=contact.contactFirstName    ${first_name}

Fill Contact Lastname
    [Arguments]    ${last_name}
    Input Text    id=contact.contactLastName    ${last_name}

Fill Contact Email
    [Arguments]    ${contact_email}
    Input Text    id=contact.contactEmail    ${contact_email}

Fill Contact Phone Number
    [Arguments]    ${contact_phonenumber}
    Input Text    id=contact.contactPhoneNumber      ${contact_phonenumber} 

Select Special Offer
    [Arguments]    ${special_offer}
    Click Element    xpath=//label[contains(., '${special_offer}')]//input[@type='radio']

Click Final Step
    Scroll Element Into View    xpath=//button[@data-testid="shimmer-cta"]
    Click Element               xpath=//button[@data-testid="shimmer-cta"]
    Sleep    1s
    Capture Page Screenshot    booking-confirmation.png
[Teardown]    Close Browser