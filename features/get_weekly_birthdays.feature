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
      | Dave | 1986-02-21 |
      | Mary | 1983-02-16 |
      | Sue  | 1987-02-20 |
      | Gary | 1985-02-22 |
      | Jane | 1982-02-19 |
      | Jack | 1981-02-17 |
    When I get weekly birthdays on 2015-02-16
    Then there should be 7 birthdays
    And there should be the following people with birthdays that week:
      | Order | Name | Day       | Age |
      | 1     | Gary | Sunday    | 30  |
      | 2     | Mary | Monday    | 32  |
      | 3     | Jack | Tuesday   | 34  |
      | 4     | Bob  | Wednesday | 31  |
      | 5     | Jane | Thursday  | 33  |
      | 6     | Sue  | Friday    | 28  |
      | 7     | Dave | Saturday  | 29  |

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

  Scenario: Birthdays are ordered by day of week in Spanish
    Given there are the following people:
      | Name | Birthdate  |
      | Bob  | 1984-02-18 |
      | Dave | 1986-02-21 |
      | Mary | 1983-02-16 |
      | Sue  | 1987-02-20 |
      | Gary | 1985-02-22 |
      | Jane | 1982-02-19 |
      | Jack | 1981-02-17 |
    When I get weekly birthdays in the es-ES language on 2015-02-16
    Then there should be 7 birthdays
    And there should be the following people with birthdays that week:
      | Order | Name | Day       | Age |
      | 1     | Gary | domingo   | 30  |
      | 2     | Mary | lunes     | 32  |
      | 3     | Jack | martes    | 34  |
      | 4     | Bob  | mi??rcoles | 31  |
      | 5     | Jane | jueves    | 33  |
      | 6     | Sue  | viernes   | 28  |
      | 7     | Dave | s??bado    | 29  |
