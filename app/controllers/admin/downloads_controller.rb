module Admin
  class DownloadsController < ApplicationController
    layout 'admin'
    load_and_authorize_resource

    def index
      temp_roles = Role.where('id <= 18 or id >= 33').order(id: :asc)
      ids = []
      temp_roles.each do |role|
        if (DateTime.parse(role.end_date) + 5.days) < Date.today
          ids << role.id
        end
      end
      @roles = temp_roles.where(id: ids)
    end

    def ins_caja
      @roles = []
      params[:ids].split(",").each do |id|
        @roles << id.to_i if id != "0"
      end
      payrole_lines = PayroleLine.where(role_id: @roles).order(:name)
      @employee_ids = []
      payrole_lines.each do |payrole|
        @employee_ids << payrole.employee.id
      end
      @employee_ids = @employee_ids.uniq

      generate_headers
      generate_rows

      if params[:txt]
      	generate_txt_file
      end

      respond_to do |format|
        format.html
        format.xls
        format.csv { send_data to_csv }
        format.text
      end
    end

    def payroles
      @roles = []
      params[:ids].split(",").each do |id|
        @roles << id.to_i if id != "0"
      end

      @headers = ['#', 'Nombre', 'Salario Neto', 'N Dias', 'Salario Minimo', 'N Horas Extras', 'Horas Extras', 'Salario Bruto', 'Feriados', 'Viaticos', 'Pagos Extras', 'Deducciones', 'Fecha de Pago']

      @total_worked_days    = 0 
      @total_min_salary     = 0 
      @total_num_extra_hours= 0 
      @total_extra_hours    = 0 
      @total_daily_viatical = 0 
      @total_ccss_deduction = 0 
      @total_deductions     = 0 
      @total_extra_payments = 0 
      @total_net_salary     = 0 
      @total_holidays       = 0

      @rows = []

      @payrole_lines = PayroleLine.select('name, SUM(CAST(net_salary AS FLOAT)) AS net_salary,
        SUM(CAST(num_worked_days AS FLOAT)) AS num_worked_days, SUM(CAST(min_salary AS FLOAT)) AS min_salary, 
        SUM(CAST(num_worked_days AS FLOAT))AS num_worked_days, SUM(CAST(num_extra_hours AS FLOAT)) AS num_extra_hours, 
        SUM(CAST(extra_hours AS FLOAT)) AS extra_hours, SUM(CAST(holidays AS FLOAT)) AS holidays, 
        SUM(CAST(daily_viatical AS FLOAT)) AS daily_viatical, SUM(CAST(extra_payments AS FLOAT)) AS extra_payments, 
        SUM(CAST(ccss_deduction AS FLOAT)) AS ccss_deduction, SUM(CAST(deductions AS FLOAT)) AS deductions').where(role_id: @roles).group(:name).order(:name)

      @payrole_lines.each_with_index do |line, index|

        row = []

        row << index+1
        row << line.name
        row << line.net_salary
        row << line.num_worked_days
        row << line.min_salary
        row << line.num_extra_hours
        row << line.extra_hours
        row << (line.min_salary.to_f + line.extra_hours.to_f).round(2)
        row << line.holidays
        row << line.daily_viatical
        row << line.extra_payments
        row << line.deductions
        start_date = Role.find(@roles[0]).start_date
        end_date = Role.find(@roles[-1]).end_date
        row <<  start_date +"-"+ end_date 

        @rows << row

      end 

      if params[:txt]
        generate_txt_file
      end

      respond_to do |format|
        format.html { redirect_to admin_downloads_url }
        format.xls
        format.csv { send_data to_csv }
        format.text
      end
    end

    def breakdown
      @roles = []
      params[:ids].split(",").each do |id|
        @roles << id.to_i if id != "0"
      end
      payrole_details = PayroleDetail.where(role_id: @roles).ids
      @detail_lines    = DetailLine.where(payrole_detail_id: payrole_details)

      respond_to do |format|
        format.csv { send_data to_csv_2 }
      end
    end

    def entity
      @rows = []
      if params[:entity] == "Clientes"

        @headers = ['Cédula Jurídica', 'Razón Social', 'Nombre Comercial', 'Identificación Representante', 'Nombre Representante', 
                    'Fecha Inicio', 'Fecha Fin', 'Contacto', 'Correo 1', 'Correr 2', 'Correo 3', 'Teléfono 1', 'Teléfono 2', 
                    'Mérodo de Pago', 'Condiciones de Pago', 'Sector']

        entities = Customer.select('legal_document', 'business_name', 'tradename', 'representative_id', 'representative_name', 'start_date', 
                                'end_date', 'contact', 'email', 'email_1', 'email_2', 'phone_number', 'phone_number_1', 'payment_method', 
                                'payment_conditions', 'sector_id').where(active: params[:status]).order(:business_name)

        entities.each do |entity|

          row = []

          row << entity.legal_document
          row << entity.business_name
          row << entity.tradename
          row << entity.representative_id
          row << entity.representative_name
          row << entity.start_date
          row << entity.end_date
          row << entity.contact
          row << entity.email
          row << entity.email_1
          row << entity.email_2
          row << entity.phone_number
          row << entity.phone_number_1
          row << entity.payment_method
          row << entity.payment_conditions
          row << if entity.sector then entity.sector.name else 'Sin Clasificar' end

          @rows << row
        end

      elsif params[:entity] == "Puestos"

        @headers = ['Nombre', 'Descripción', 'province', 'Cantón', 'Distrito', 'Otras Señas', 'Viático Diario', 'Turno Extra', 'Sub Puestos', 'Cliente', 'Tipo de Puesto']
        entities = Stall.select('name', 'description', 'province', 'canton', 'district', 'other', 'daily_viatical', 'extra_shift', 
                             'substalls', 'customer_id', 'type_id').where(active: params[:status]).order(:name)

        entities.each do |entity|

          row = []

          row << entity.name
          row << entity.description
          row << entity.province
          row << entity.canton
          row << entity.district
          row << entity.other
          row << entity.daily_viatical
          row << entity.extra_shift
          row << entity.substalls
          row << if entity.customer then entity.customer.tradename else 'No hay cliente asociado' end
          row << if entity.type then entity.type.name else 'Sin Clasificar' end
          
          @rows << row
        end
      else

        @headers = ['Nombre', 'Genero', 'Tipo de Identificación', 'Identificación', 'Fecha de Nacimiento', 'Provincia', 'Cantón', 'Distrito',
                    'Otras Señas', 'Teléfono 1', 'Teléfono 2', 'Correo', 'Contacto de Emergencia', 'Número Contacto Emergencia', 'Banco', 
                    'Cuenta','Dueño de la cuenta', 'Identificación del Propietario', 'Método de Pago', 'Número de Seguro', 'Tipo de Seguro', 'Viáticos', 
                    'Completo', 'Librero']

        entities = Employee.select('name', 'gender', 'id_type', 'identification', 'birthday', 'province', 'canton', 'district', 'other', 
                                'phone', 'phone_1', 'email', 'emergency_contact', 'emergency_number', 'bank', 'account', 'account_owner', 
                                'account_identification', 'payment_method', 'ccss_number', 'social_security', 'daily_viatical', 'ccss_type', 
                                'special').where(active: params[:status]).order(:name)

        entities.each do |entity|

          row = []

          row << entity.name
          row << entity.gender
          row << entity.id_type
          row << entity.identification
          row << entity.birthday
          row << entity.province
          row << entity.canton
          row << entity.district
          row << entity.other
          row << entity.phone
          row << entity.phone_1
          row << entity.email
          row << entity.emergency_contact
          row << entity.emergency_number
          row << entity.bank
          row << entity.account
          row << entity.account_owner
          row << entity.account_identification
          row << entity.payment_method
          row << entity.ccss_number
          row << entity.social_security
          row << if entity.daily_viatical == "yes" then 'Sí' else "No" end
          row << if entity.ccss_type == "yes" then 'Sí' else "No" end
          row << if entity.special == "true" then 'Sí' else "No" end
          
          @rows << row

        end
      end

      if params[:txt]
        generate_txt_file
      end
      respond_to do |format|
        format.html { redirect_to admin_downloads_url }
        format.xls
        format.csv { send_data to_csv }
        format.text
      end
    end

    private

    def generate_headers
      @headers = ['CÉDULA', 'FECHA INGRESO', 'FECHA SALIDA', 'NOMBRE']
      @roles.each do |role|
      	@headers << Role.find(role).name
      end
      @headers << 'TOTAL'
    end

    def generate_rows
      @rows = []

      @employee_ids.each do |id| 

        row = []
        employee = Employee.find(id) 
        total = 0

        row << employee.identification

        if employee.entries != [] 
          last_entry = '01/01/1970' 
          last_end   = '01/01/1970' 
          employee.entries.each do |entry| 
            if entry.start_date.to_time > last_entry.to_time 
              last_entry = entry.start_date 
              last_end   = entry.end_date 
            end 
          end 

          if (last_entry.to_time >= Role.find(@roles.first).start_date.to_time && last_entry.to_time <= Role.find(@roles.last).end_date.to_time) || (last_end != "" && last_end.to_time >= Role.find(@roles.first).start_date.to_time && last_end.to_time <= Role.find(@roles.last).end_date.to_time) 
            row << last_entry
          else 
            row << ''
          end 

          if last_end != "" && last_end.to_time >= Role.find(@roles.first).start_date.to_time && last_end.to_time <= Role.find(@roles.last).end_date.to_time 
            row << last_end
          else 
            row << ''
          end 
        else 
          row << ''
          row << ''
        end 
        row << employee.name

        @roles.each do |role| 
          lines = PayroleLine.where(role_id: role, employee_id: id) 
          total += (lines.first.min_salary.to_f + lines.first.extra_hours.to_f + lines.first.holidays.to_f + lines.first.daily_viatical.to_f + lines.first.extra_payments.to_f) if lines != [] 
          row << helper.number_to_currency((lines.first.min_salary.to_f + lines.first.extra_hours.to_f + lines.first.holidays.to_f + lines.first.daily_viatical.to_f + lines.first.extra_payments.to_f), unit: '₡') if lines != []
        end 
        row << helper.number_to_currency(total.round(2), unit: '₡')
        @rows << row  	
      end
    end

    def helper
      @helper ||= Class.new do
        include ActionView::Helpers::NumberHelper
      end.new
    end

    def to_csv
      CSV.generate(headers: true) do |csv|
        csv << @headers
        @rows.each do |row|
          row2 = []
          row.each do |cell|
            begin
              row2 << cell.gsub('₡', '')
            rescue Exception => e
              row2 << cell
            end
          end
	      csv << row2
	    end
      end
    end

    def generate_txt_file
	    @content = ""

      @headers.each do |header|
        @content += header + ","
      end
      @content += "\n"

	    @rows.each do |row|
	      row.each do |cell|
	      	@content += cell.to_s + ","
	      end

	      @content += "\n"
	    end
    end


    def to_csv_2

      CSV.generate(headers: true) do |csv|

        headers  = ['COLABORADOR', 'FECHA', 'PUESTO', 'TURNO', 'HORAS TRABAJADAS', 'SALARIO BASE DIARIO', 
                   'SALARIO FERIADO', 'HORAS EXTRAS DEL DÍA',  'PAGO POR HORAS EXTRAS', 'VIÁTICO DIARIO', 
                   'PAGOS ADCIONALES', 'MOTIVO DEL PAGO ADICIONAL', 'DEDUCCIONES ADICIONALES', 'MOTIVO DE LA DEDUCCIÓN',
                   'COMENTARIOS', 'SECTOR DEL CLIENTE', 'SERVICIO', 'SUB SERVICIO', 'TIPO DE PUESTO']

        headers2  = ['employee_name', 'date', 'stall_name', 'shift_name', 'hours', 'salary', 
                   'holiday', 'extra_hours',  'extra_salary', 'viatical', 
                   'extra_payment', 'extra_payment_reason', 'deductions', 'deductions_reason',
                   'comments', 'sector', 'service', 'sub_service', 'stall_type']


        csv << headers

        @detail_lines.each do |line|
          csv << headers2.map{ |attr| line.send(attr) }
        end
      end
    end
  end
end
