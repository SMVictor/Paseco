users = User.create([
   {name: 'Víctor Salvatierra Mora', email: 'victor.salvatierra@monkeylabs.cr', password: '1234asdf',   password_confirmation: '1234asdf',   role: 0},
   {name: 'Víctor Salvatierra Mora', email: 'victor.salvatierra@outlook.com',   password: '1234asdf',   password_confirmation: '1234asdf',   role: 1},
   {name: 'Lindsay Tatiana Arias Barquero',   email: 'lindsay.ariasb18@gmail.com',       password: 'paseco2019', password_confirmation: 'paseco2019', role: 0},
   {name: 'Justin Andrey Arias Barquero',   email: 'juspaseco94@gmail.com',            password: 'paseco2019', password_confirmation: 'paseco2019', role: 0},
   {name: 'Jose Ricardo Arias Barquero',   email: 'jariasb91@gmail.com',              password: 'paseco2019', password_confirmation: 'paseco2019', role: 0}])

positions = Position.create([{name: 'Oficial', salary: 0}])

bncr_infos = BncrInfo.create([{date: '03021019', company: "18159", transfer_type: "1", consecutive: "1", concept: "PAGO PLANILLA Q1 FEBRERO", account: "100010960008831"}])

bac_infos = BacInfo.create([{date: '20190203', plan: "ADE8", shipping: "00123", concept: "PAGO PLANILLA Q1 FEBRERO"}])