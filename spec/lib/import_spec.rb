require 'rspec'
require 'nppes/import/import'

module Nppes
  describe Import do
    context 'when the specialties file exists' do
      before :each do
        specialties_json = '[]'
        @specialties = []
        File.should_receive(:exists?)
            .with(SPECIALTIES_FILE_PATH)
            .and_return(true)

        File.should_receive(:read)
            .with(SPECIALTIES_FILE_PATH)
            .and_return(specialties_json)

        JSON.should_receive(:parse)
            .with(specialties_json)
            .and_return(@specialties)
      end

      context 'and the given path to a providers.csv file exists' do
        before :each do
          File.should_receive(:exists?)
              .with('/providers.csv')
              .and_return(true)
        end

        describe 'construction' do
          it 'reads in the specialties and stores them in #specialties' do
            importer = Import.new '/providers.csv'
            importer.specialties.should == @specialties
          end

          it 'stores the given path in #import_file_path' do
            importer = Import.new '/providers.csv'
            importer.import_file_path.should == '/providers.csv'
          end
        end

        describe 'the import method' do
          class FakeRawProvider
            def to_hash
              @hash ||= {}
            end
          end
          class FakeCsv
            def rows
              @rows ||= [{},{},{}]
            end
            def foreach(path, options)
              rows.each { |row| yield row }
            end
          end
          class FakeProvider
            def save
            end
          end
          it 'creates a raw provider for each line in the given file' do
            fake_csv = FakeCsv.new
            rows = fake_csv.rows
            rows.each do |row|
              fake_raw_provider = FakeRawProvider.new
              RawProvider
                .should_receive(:new)
                .with(row)
                .and_return(fake_raw_provider)

              fake_provider = FakeProvider.new
              Provider
                .should_receive(:new)
                .with(fake_raw_provider.to_hash)
                .and_return(fake_provider)

              fake_provider.should_receive(:save)
            end
            importer = Import.new '/providers.csv', fake_csv
            importer.import_providers
          end
        end
      end

      context 'but the given path to providers.csv file does not exist' do
        before :each do
          File.should_receive(:exists?)
              .with('/providers.csv')
              .and_return(false)
        end
        describe 'construction' do
          it 'raises' do
            ->{ Import.new '/providers.csv' }.should raise_error
          end
        end
      end
    end

    context 'when the specialties file does not exist' do
      before :each do
        File.should_receive(:exists?)
            .with(SPECIALTIES_FILE_PATH)
            .and_return(false)
      end
      describe 'construction' do
        it 'raises' do
          ->{ Import.new '/providers.csv' }.should raise_error
        end
      end
    end

  end
end
