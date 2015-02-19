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

  Scenario: Two people with one birthday in current week and one in previous week
    Given there is a person with a birthday on 1984-02-12
    And there is a person with a birthday on 1984-02-16
    When I get weekly birthdays on 2015-02-16
    Then there should be 1 birthdays

  Scenario: Two people with one birthday in current week and one in next week
    Given there is a person with a birthday on 1984-02-16
    And there is a person with a birthday on 1984-02-23
    When I get weekly birthdays on 2015-02-16
    Then there should be 1 birthdays

  Scenario: Birthdays are ordered
    Given there is a person with a birthday on 1984-02-18
    And there is a person with a birthday on 1983-02-16
    And there is a person with a birthday on 1982-02-19
    And there is a person with a birthday on 1981-02-17
    When I get weekly birthdays on 2015-02-16
    Then there should be 4 birthdays
    And the 1st person's birthday day should be on Monday
    And the 1st person's age should be 32
    And the 2nd person's birthday day should be on Tuesday
    And the 2nd person's age should be 34
    And the 3rd person's birthday day should be on Wednesday
    And the 3rd person's age should be 31
    And the 4th person's birthday day should be on Thursday
    And the 4th person's age should be 33
