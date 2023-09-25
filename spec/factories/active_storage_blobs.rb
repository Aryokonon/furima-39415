FactoryBot.define do
  factory :active_storage_blob, class: 'ActiveStorage::Blob' do
    sequence(:key) { |n| "test/blob#{n}" }
    filename { 'sample_image.jpg' }
    content_type { 'image/jpeg' }
    metadata { '' }
    byte_size { 1000 } # Adjust the size as needed
    checksum { 'xyz123' } # Replace with an actual checksum
  end
end
