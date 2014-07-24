class DummyData::LoadUsers
  class << self
    def run
      puts "[DummyData] load users ---------------------------------------------------------- started"

      unless User.exists?(email: 'winston@alphagov.co.uk')
        User.create!(
          name: 'Winston',
          uid: 'winston',
          email: 'winston@alphagov.co.uk',
          permissions: ['signin', 'GDS Editor']
        )
      end

      10.times do |i|
        unless User.exists?(email: 'winston@alphagov.co.uk')
          User.create!(
            name: "Test User #{i + 1}",
            uid: "test_user_#{i + 1}",
            email:  "test_user_#{i + 1}@alphagov.co.uk",
            permissions: ['signin', 'GDS Editor']
          )
        end
      end

      puts "[DummyData] load users ---------------------------------------------------------- completed"
    end
  end
end