require 'spec_helper'

describe 'postfix', :type => :class do

  ['Debian'].each do |osfamily|
    context "on #{osfamily}" do
      if osfamily == 'Debian'
        let(:facts) { 
          {
            :osfamily               => osfamily,
            :operatingsystem        => 'Ubuntu',
            :lsbdistid              => 'Ubuntu',
            :lsbdistcodename        => 'maverick',
            :kernelrelease          => '3.8.0-29-generic',
            :operatingsystemrelease => '10.04',
          } 
        }

        it { is_expected.to contain_class("postfix::params") }
        it { is_expected.to contain_package("postfix") }
      end
    end
  end
end
