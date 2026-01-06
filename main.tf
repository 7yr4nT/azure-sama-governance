# --- 1. DEFINE THE POLICIES ---

# Policy A: Deny Foreign Regions
resource "azurerm_policy_definition" "sama_location" {
  name         = "sama-geo-fence"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "SAMA: Enforce UAE/KSA Data Residency"
  description  = "Strictly enforces resource creation only in UAE North and Saudi Arabia Central."

  # This tells Terraform to read the JSON file you created
  policy_rule = file("${path.module}/policies/location_deny.json")
}

# Policy B: Audit Insecure Storage
resource "azurerm_policy_definition" "sama_audit" {
  name         = "sama-storage-audit"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "SAMA: Audit Insecure Storage"
  description  = "Audits storage accounts that do not enforce HTTPS encryption."

  policy_rule = file("${path.module}/policies/secure_transfer.json")
}

# --- 2. ASSIGN THE POLICIES TO YOUR SUBSCRIPTION ---

# Assign Policy A
resource "azurerm_subscription_policy_assignment" "assign_location" {
  name                 = "assign-sama-geo"
  policy_definition_id = azurerm_policy_definition.sama_location.id
  subscription_id      = "/subscriptions/b095cc2c-f91c-4927-8847-xxxxxxxxxxxx"
}

# Assign Policy B
resource "azurerm_subscription_policy_assignment" "assign_audit" {
  name                 = "assign-sama-audit"
  policy_definition_id = azurerm_policy_definition.sama_audit.id
  subscription_id      = "/subscriptions/b095cc2c-f91c-4927-8847-xxxxxxxxx"
}
