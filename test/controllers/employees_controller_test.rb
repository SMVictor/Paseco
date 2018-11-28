require 'test_helper'

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee = employees(:one)
  end

  test "should get index" do
    get employees_url
    assert_response :success
  end

  test "should get new" do
    get new_employee_url
    assert_response :success
  end

  test "should create employee" do
    assert_difference('Employee.count') do
      post employees_url, params: { employee: { account: @employee.account, bank: @employee.bank, birthday: @employee.birthday, canton: @employee.canton, ccss_number: @employee.ccss_number, district: @employee.district, emergency_contact: @employee.emergency_contact, emergency_number: @employee.emergency_number, end_date: @employee.end_date, gender: @employee.gender, id_type: @employee.id_type, identification: @employee.identification, nama: @employee.nama, other: @employee.other, payment_method: @employee.payment_method, phone: @employee.phone, phone_1: @employee.phone_1, province: @employee.province, role: @employee.role, social_security: @employee.social_security, start_date: @employee.start_date } }
    end

    assert_redirected_to employee_url(Employee.last)
  end

  test "should show employee" do
    get employee_url(@employee)
    assert_response :success
  end

  test "should get edit" do
    get edit_employee_url(@employee)
    assert_response :success
  end

  test "should update employee" do
    patch employee_url(@employee), params: { employee: { account: @employee.account, bank: @employee.bank, birthday: @employee.birthday, canton: @employee.canton, ccss_number: @employee.ccss_number, district: @employee.district, emergency_contact: @employee.emergency_contact, emergency_number: @employee.emergency_number, end_date: @employee.end_date, gender: @employee.gender, id_type: @employee.id_type, identification: @employee.identification, nama: @employee.nama, other: @employee.other, payment_method: @employee.payment_method, phone: @employee.phone, phone_1: @employee.phone_1, province: @employee.province, role: @employee.role, social_security: @employee.social_security, start_date: @employee.start_date } }
    assert_redirected_to employee_url(@employee)
  end

  test "should destroy employee" do
    assert_difference('Employee.count', -1) do
      delete employee_url(@employee)
    end

    assert_redirected_to employees_url
  end
end
