require "application_system_test_case"

class EmployeesTest < ApplicationSystemTestCase
  setup do
    @employee = employees(:one)
  end

  test "visiting the index" do
    visit employees_url
    assert_selector "h1", text: "Employees"
  end

  test "creating a Employee" do
    visit employees_url
    click_on "New Employee"

    fill_in "Account", with: @employee.account
    fill_in "Bank", with: @employee.bank
    fill_in "Birthday", with: @employee.birthday
    fill_in "Canton", with: @employee.canton
    fill_in "Ccss Number", with: @employee.ccss_number
    fill_in "District", with: @employee.district
    fill_in "Emergency Contact", with: @employee.emergency_contact
    fill_in "Emergency Number", with: @employee.emergency_number
    fill_in "End Date", with: @employee.end_date
    fill_in "Gender", with: @employee.gender
    fill_in "Id Type", with: @employee.id_type
    fill_in "Identification", with: @employee.identification
    fill_in "Nama", with: @employee.nama
    fill_in "Other", with: @employee.other
    fill_in "Payment Method", with: @employee.payment_method
    fill_in "Phone", with: @employee.phone
    fill_in "Phone 1", with: @employee.phone_1
    fill_in "Province", with: @employee.province
    fill_in "Role", with: @employee.role
    fill_in "Social Security", with: @employee.social_security
    fill_in "Start Date", with: @employee.start_date
    click_on "Create Employee"

    assert_text "Employee was successfully created"
    click_on "Back"
  end

  test "updating a Employee" do
    visit employees_url
    click_on "Edit", match: :first

    fill_in "Account", with: @employee.account
    fill_in "Bank", with: @employee.bank
    fill_in "Birthday", with: @employee.birthday
    fill_in "Canton", with: @employee.canton
    fill_in "Ccss Number", with: @employee.ccss_number
    fill_in "District", with: @employee.district
    fill_in "Emergency Contact", with: @employee.emergency_contact
    fill_in "Emergency Number", with: @employee.emergency_number
    fill_in "End Date", with: @employee.end_date
    fill_in "Gender", with: @employee.gender
    fill_in "Id Type", with: @employee.id_type
    fill_in "Identification", with: @employee.identification
    fill_in "Nama", with: @employee.nama
    fill_in "Other", with: @employee.other
    fill_in "Payment Method", with: @employee.payment_method
    fill_in "Phone", with: @employee.phone
    fill_in "Phone 1", with: @employee.phone_1
    fill_in "Province", with: @employee.province
    fill_in "Role", with: @employee.role
    fill_in "Social Security", with: @employee.social_security
    fill_in "Start Date", with: @employee.start_date
    click_on "Update Employee"

    assert_text "Employee was successfully updated"
    click_on "Back"
  end

  test "destroying a Employee" do
    visit employees_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Employee was successfully destroyed"
  end
end
