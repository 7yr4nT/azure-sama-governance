

  <h1>🛡️ SAMA-Compliant Azure Landing Zone (Policy-as-Code)</h1>

  <p>
    <img src="https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white" alt="Azure">
    <img src="https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform">
    <img src="https://img.shields.io/badge/Security-SAMA%20Compliant-gold" alt="Security">
    <img src="https://img.shields.io/badge/license-MIT-green" alt="License">
  </p>

  <hr>

  <h2>📋 Executive Summary</h2>

  <p>
    This project implements an automated governance framework for Microsoft Azure,
    designed to meet the strict regulatory requirements of the
    <strong>Saudi Central Bank (SAMA)</strong> Cybersecurity Framework.
  </p>

  <p>
    By utilizing <strong>Infrastructure as Code (IaC)</strong>, manual compliance checks
    are replaced with enforced technical guardrails. These controls ensure that
    <strong>Data Residency</strong> and <strong>Encryption-in-Transit</strong> requirements
    are applied programmatically and consistently at the Azure subscription level.
  </p>

  <p>
    This approach eliminates configuration drift, reduces human error, and provides
    auditable, repeatable compliance aligned with financial-sector regulatory expectations.
  </p>

  <hr>

  <h2>🏗️ Architecture &amp; Policies</h2>

  <h3>1. Geo-Fencing (Data Residency)</h3>

  <p><strong>Regulatory Requirement</strong></p>
  <p>
    All regulated data must remain within the legal jurisdictions approved by SAMA.
  </p>

  <p><strong>Approved Regions</strong></p>
  <ul>
    <li><code>uaenorth</code> – United Arab Emirates</li>
    <li><code>saudiarabiacentral</code> – Kingdom of Saudi Arabia</li>
  </ul>

  <p><strong>Technical Enforcement</strong></p>
  <p>
    A <strong>custom Azure Policy</strong> with a <code>deny</code> effect blocks the creation of:
  </p>
  <ul>
    <li>Resource Groups</li>
    <li>Azure Resources</li>
  </ul>
  <p>
    in any region outside the approved KSA/UAE locations. Non-compliant deployments
    are rejected before provisioning.
  </p>

  <h3>2. Encryption-in-Transit Enforcement</h3>

  <p><strong>Regulatory Requirement</strong></p>
  <p>
    All data in transit must be encrypted using HTTPS to mitigate interception and
    man-in-the-middle attacks.
  </p>

  <p><strong>Technical Enforcement</strong></p>
  <p>
    An <strong>audit policy</strong> evaluates Azure Storage Accounts for the
    <code>SecureTransferRequired</code> property:
  </p>
  <ul>
    <li><code>true</code> → Compliant</li>
    <li><code>false</code> → Flagged as non-compliant in Azure Policy Compliance</li>
  </ul>

  <p>
    This provides continuous visibility and governance without disrupting workloads.
  </p>

  <hr>

  <h2>📂 Project Structure</h2>

  <pre>
.
├── policies/
│   ├── location_deny.json     # Logic: "If region is NOT KSA/UAE, then Deny"
│   └── secure_transfer.json   # Logic: "Audit if HTTPS is disabled"
├── main.tf                    # Terraform configuration to deploy policy definitions and assignments
├── provider.tf                # Azure Provider configuration
└── README.md                  # Project documentation
  </pre>

  <hr>

  <h2>🚀 Deployment Guide</h2>

  <h3>Prerequisites</h3>
  <ul>
    <li>Terraform v1.0 or higher</li>
    <li>Azure CLI installed and authenticated (<code>az login</code>)</li>
    <li>Active Azure subscription with sufficient permissions</li>
  </ul>

  <h3>Installation Steps</h3>

  <h4>1. Clone the Repository</h4>
  <pre><code>git clone https://github.com/7yr4nT/azure-sama-governance.git</code></pre>

  <h4>2. Navigate to the Project Directory</h4>
  <pre><code>cd azure-sama-governance</code></pre>

  <h4>3. Initialize Terraform</h4>
  <pre><code>terraform init</code></pre>

  <h4>4. Deploy the Governance Guardrails</h4>
  <pre><code>terraform apply</code></pre>

  <p>
    When prompted, type <code>yes</code> to confirm the deployment and assign the policies
    at the subscription level.
  </p>

  <hr>

  <h2>📸 Evidence of Enforcement</h2>

  <p><strong>Scenario</strong></p>
  <p>
    An engineer attempts to deploy a Storage Account in the
    <strong>East US</strong> region, which is not an approved jurisdiction.
  </p>

  <p><strong>Result</strong></p>
  <p>
    The deployment is blocked before resource creation. Azure returns a
    <code>RequestDisallowedByPolicy</code> error, explicitly referencing the
    SAMA Geo-Fencing policy.
    
  <img width="2124" height="1095" alt="Screenshot 2026-01-06 100526" src="https://github.com/user-attachments/assets/a20e0fac-3ecc-4990-8a3e-c2ab8ff70f13" />

  </p>

  <p><strong>Outcome</strong></p>
  <ul>
    <li>No non-compliant resource is created</li>
    <li>Policy violation is logged</li>
    <li>Compliance posture remains intact</li>
  </ul>

  <hr>

  <h2>🔒 Compliance Value</h2>

  <ul>
    <li>Policy-as-Code implementation for regulatory compliance</li>
    <li>Preventive security controls (deny-based enforcement)</li>
    <li>Continuous compliance auditing</li>
    <li>Enterprise-grade Azure governance aligned with financial regulations</li>
  </ul>

  <hr>

  <h2>📌 Notes</h2>
  <ul>
    <li>This project is intended for <strong>educational and portfolio demonstration purposes</strong></li>
    <li>It showcases <strong>Cloud Governance</strong>, <strong>Azure Policy</strong>, and <strong>Terraform</strong> skills</li>
    <li>Not intended for direct production use without further customization and risk assessment</li>
  </ul>

  <hr>

  <h2>📄 License</h2>
  <p>
    This project is licensed under the <strong>MIT License</strong>.
  </p>

</body>
</html>
