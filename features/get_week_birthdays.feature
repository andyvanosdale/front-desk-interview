Feature: Get Weekly Birthdays

  Scenario: No people in the database
    Given there are no people
    When I get weekly birthdays
    Then there should be 0 birthdays

  Scenario: A person with birthday in current week
    Given there is a person with a birthday on 1984-02-16
    When I get weekly birthdays on 2015-02-16
    Then there should be 1 birthday
    And the 1st person's birthday day should be on Monday
    And the 1st person's age should be 31

  Scenario: One person with birthday on previous week
    Given there is a person with a birthday on 1984-02-14
    When I get weekly birthdays on 2015-02-16
    Then there should be 0 birthdays

  Scenario: Two people with birthday in checked week
    Given there is a person with a birthday on 1984-02-17
    And there is a person with a birthday on 1984-02-18
    When I get weekly birthdays on 2015-02-16
    Then there should be 2 birthdays

  Scenario: Two people with birthday in previous week
    Given there is a person with a birthday on 1984-02-12
    And there is a person with a birthday on 1984-02-14
    When I get weekly birthdays on 2015-02-16
    Then there should be 0 birthdays
