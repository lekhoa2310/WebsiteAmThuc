# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
City.create([
  {name: "Hà nội"},
  {name: "Đà nẵng"},
  {name: "Hồ Chí Minh"}
  ])

District.create([
  {city_id: "1", name: "Ba Đình"},
  {city_id: "1", name: "Bắc Từ Liêm"},
  {city_id: "1", name: "Cầu Giấy"},
  {city_id: "1", name: "Đống Đa"},
  {city_id: "1", name: "Hai Bà Trưng"},
  {city_id: "1", name: "Hoàn Kiếm"},
  {city_id: "1", name: "Hoàng Mai"},
  {city_id: "1", name: "Long Biên"},
  {city_id: "1", name: "Nam Từ Liêm"},
  {city_id: "1", name: "Thanh Xuân"},
  {city_id: "1", name: "Tây Hồ"},
  {city_id: "1", name: "Ba Vì"},
  {city_id: "1", name: "Chương Mỹ,"},
  {city_id: "1", name: "Đan Phượng"},
  {city_id: "1", name: "Đông Anh"},
  {city_id: "1", name: "Gia Lâm"},
  {city_id: "1", name: "Hoài Đức"},
  {city_id: "1", name: "Mê Linh"},
  {city_id: "1", name: "Mỹ Đức"},
  {city_id: "1", name: "Phúc Thọ"},
  {city_id: "1", name: "Phú Xuyên"},
  {city_id: "1", name: "Quốc Oai"},
  {city_id: "1", name: "Sóc Sơn"},
  {city_id: "1", name: "Thạch Thất"},
  {city_id: "1", name: "Thanh Oai"},
  {city_id: "1", name: "Thanh Trì"},
  {city_id: "1", name: "Thường Tín"},
  {city_id: "1", name: "Ứng Hòa"},
  {city_id: "2", name: "Hoàng Sa "},
  {city_id: "2", name: "Ngũ Hành Sơn "},
  {city_id: "2", name: "Sơn Trà "},
  {city_id: "2", name: "Hòa Vang "},
  {city_id: "2", name: "Thanh Khê "},
  {city_id: "2", name: "Cẩm Lệ "},
  {city_id: "2", name: "Hải Châu "},
  {city_id: "2", name: "Liên Chiểu"},
  {city_id: "3", name: "Quận 1"},
  {city_id: "3", name: "Quận 2"},
  {city_id: "3", name: "Quận 3"},
  {city_id: "3", name: "Quận 4"},
  {city_id: "3", name: "Quận 5"},
  {city_id: "3", name: "Quận 6"},
  {city_id: "3", name: "Quận 7"},
  {city_id: "3", name: "Quận 8"},
  {city_id: "3", name: "Quận 9"},
  {city_id: "3", name: "Quận 10"},
  {city_id: "3", name: "Quận 11"},
  {city_id: "3", name: "Quận 12"},
  {city_id: "3", name: "Thủ Đức"},
  {city_id: "3", name: "Gò Vấp"},
  {city_id: "3", name: "Bình Thạnh"},
  {city_id: "3", name: "Tân Bình"},
  {city_id: "3", name: "Tân Phú"},
  {city_id: "3", name: "Phú Nhuận"},
  {city_id: "3", name: "Bình Tân"},
  {city_id: "3", name: "Củ Chi"},
  {city_id: "3", name: "Hóc Môn"},
  {city_id: "3", name: "Bình Chánh"},
  {city_id: "3", name: "Nhà Bè"},
  {city_id: "3", name: "Cần Giờ"},

])

User.create([
  {name: "le khoa", email: "lekhoa@gmail.com", password: "123456",district_id: "1", address: "ktx", phone: "0989899466" , birthday: "1993-10-23", gender: "1", role: "5"}

  ])
