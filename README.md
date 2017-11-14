study_ssm_agent cookbook
===================

Description
-----------

A simple cookbook to download and install the [Amazon EC2 Systems Manager](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/systems-manager.html) agent.

About Systems Manager
---------------------

Amazon EC2 Systems Manager is a collection of capabilities that helps you automate management tasks such as collecting system inventory, applying operating system (OS) patches, automating the creation of Amazon Machine Images (AMIs), and configuring operating systems (OSs) and applications at scale. Systems Manager works with managed instances: Amazon EC2 instances, or servers and virtual machines (VMs) in your on-premises environment that are configured for Systems Manager.

Usage
-----

Include the default recipe.

```
include_recipe 'ssm_agent::default'
```

Additionally, the EC2 instance running the service will require specific IAM permissions which may be provided via [Managed Policies](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/systems-manager-access.html#sysman-configuring-access-policies). However, it's recommended to create a custom IAM policy due to how insecure the default managed policy seems to be.

References
----------

* [github:amazon-ssm-agent](https://github.com/aws/amazon-ssm-agent)
