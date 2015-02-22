Feature: Get Weekly Birthdays

  Scenario: No people in the database
    Given there are no people
    When I get weekly birthdays
    Then there should be 0 birthdays

  Scenario: A person with a birthday in the current week
    Given there is a person Bob with a birthday on 1984-02-16
    When I get weekly birthdays on 2015-02-16
    Then there should be 1 birthday
    And the 1st person's birthday day should be on Monday
    And the 1st person's age should be 31

  Scenario: One person with a birthday in the previous week
    Given there is a person Bob with a birthday on 1984-02-14
    When I get weekly birthdays on 2015-02-16
    Then there should be 0 birthdays

  Scenario: Two people with birthdays in the checked week
    Given there are the following people:
      | Name | Birthdate  |
      | Bob  | 1984-02-17 |
      | Mary | 1984-02-18 |
    When I get weekly birthdays on 2015-02-16
    Then there should be 2 birthdays

  Scenario: Two people with birthdays in the previous week
    Given there are the following people:
      | Name | Birthdate  |
      | Bob  | 1984-02-12 |
      | Mary | 1984-02-14 |
    When I get weekly birthdays on 2015-02-16
    Then there should be 0 birthdays

  Scenario: Two people: one birthday in the current week and one in the previous week
    Given there are the following people:
      | Name | Birthdate  |
      | Bob  | 1984-02-12 |
      | Mary | 1984-02-16 |
    When I get weekly birthdays on 2015-02-16
    Then there should be 1 birthdays

  Scenario: Two people: one birthday in the current week and one in the next week
    Given there are the following people:
      | Name | Birthdate  |
      | Bob  | 1984-02-16 |
      | Mary | 1984-02-23 |
    When I get weekly birthdays on 2015-02-16
    Then there should be 1 birthdays

  Scenario: Birthdays are ordered by day of week
    Given there are the following people:
      | Name | Birthdate  |
      | Bob  | 1984-02-18 |
      | Mary | 1983-02-16 |
      | Jane | 1982-02-19 |
      | Jack | 1981-02-17 |
    When I get weekly birthdays on 2015-02-16
    Then there should be 4 birthdays
    And there should be the following people with birthdays that week:
      | Order | Name | Day       | Age |
      | 1     | Mary | Monday    | 32  |
      | 2     | Jack | Tuesday   | 34  |
      | 3     | Bob  | Wednesday | 31  |
      | 4     | Jane | Thursday  | 33  |

  Scenario: A February 29 leap year birthdate defaults to March 1 on non-leap year
    Given there are the following people:
      | Name | Birthdate  |
      | Bob  | 2012-02-29 |
    When I get weekly birthdays on 2014-02-28
    Then there should be 1 birthday
    And there should be the following people with birthdays that week:
      | Order | Name | Day      | Age |
      | 1     | Bob  | Saturday | 2   |

  Scenario: February 29 leap year birthdates are on February 29 on leap years
    Given there are the following people:
      | Name | Birthdate  |
      | Bob  | 2012-02-29 |
    When I get weekly birthdays on 2016-03-01
    Then there should be 1 birthday
    And there should be the following people with birthdays that week:
      | Order | Name | Day    | Age |
      | 1     | Bob  | Monday | 4   |
