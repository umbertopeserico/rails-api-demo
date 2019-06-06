require 'rails_helper'

RSpec.describe ApiConstraints::Version do

  context 'with default api set' do

    before do
      @version_constraint = ApiConstraints::Version.new({version: 1, default: true})
    end

    describe '#matches' do
      it 'should match every api version' do
        req = double('request', headers: { 'Accept': 'application/vnd.rails-api-demo.v12+json' }.stringify_keys)
        expect(@version_constraint.matches?(req)).to be
      end

      it 'should match api version #1' do
        req = double('request', headers: { 'Accept': 'application/vnd.rails-api-demo.v1+json' }.stringify_keys)
        expect(@version_constraint.matches?(req)).to be
      end
    end

  end

  context 'with specific api set' do

    describe 'as an integer' do
      before do
        @version_constraint = ApiConstraints::Version.new({version: 1})
      end

      describe '#matches' do
        it 'should match api version #1' do
          req = double('request', headers: { 'Accept': 'application/vnd.rails-api-demo.v1+json' }.stringify_keys)
          expect(@version_constraint.matches?(req)).to be
        end

        it 'should not match api version #2' do
          req = double('request', headers: { 'Accept': 'application/vnd.rails-api-demo.v2+json' }.stringify_keys)
          expect(@version_constraint.matches?(req)).not_to be
        end
      end
    end

    describe 'as an array' do
      before do
        @version_constraint = ApiConstraints::Version.new({version: [1,2]})
      end

      describe '#matches' do
        it 'should match api version #1' do
          req = double('request', headers: { 'Accept': 'application/vnd.rails-api-demo.v1+json' }.stringify_keys)
          expect(@version_constraint.matches?(req)).to be
        end

        it 'should match api version #2' do
          req = double('request', headers: { 'Accept': 'application/vnd.rails-api-demo.v2+json' }.stringify_keys)
          expect(@version_constraint.matches?(req)).to be
        end

        it 'should not match api version #3' do
          req = double('request', headers: { 'Accept': 'application/vnd.rails-api-demo.v3+json' })
          expect(@version_constraint.matches?(req)).not_to be
        end
      end
    end

  end

end