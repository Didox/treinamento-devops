Feature: Validate CPF

@mytag
Scenario: CPF Valid
	Given i'm in home page
	And I type the CPF "583.068.670-84"
	When I click on button validate
	Then I have the successful result


@mytag
Scenario: CPF Invalid
	Given i'm in home page
	And I type the CPF "583.068.670-86" invalid
	When I click on button validate
	Then I have the error result