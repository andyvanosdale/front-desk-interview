Feature: Get Weekly Birthdays

  Scenario: No people in the database
    Given there are no people
    When I get weekly birthdays
    Then there should be no birthdays
