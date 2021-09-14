package test

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func Test(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		// Source path of Terraform directory.
		TerraformDir: "../",
	}

	// This will run 'terraform init' and 'terraform application' and will fail the test if any errors occur
	terraform.InitAndApply(t, terraformOptions)

	// To clean up any resources that have been created, run 'terraform destroy' towards the end of the test
	defer terraform.Destroy(t, terraformOptions)

	// Tests
	vpcID := terraform.Output(t, terraformOptions, "vpc_id")
	assert.NotNil(t, vpcID)

	publicSubnetID := terraform.Output(t, terraformOptions, "public_subnet_ids")
	assert.NotNil(t, publicSubnetID)

	privateSubnetID := terraform.Output(t, terraformOptions, "private_subnet_ids")
	assert.NotNil(t, privateSubnetID)

	fmt.Println("Tests Completed!")

}
