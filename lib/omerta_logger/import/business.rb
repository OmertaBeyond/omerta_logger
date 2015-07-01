module OmertaLogger
  module Import
    class Business < Base
      def set_owner(xml_business, business)
        owner = xml_business.css('owner').first
        owner_id = owner['id'].to_i
        if owner_id == 0
          business.user = nil
          business.family = nil
        else
          business.user = @version.users.find_or_create_by(ext_user_id: owner_id, name: owner.text)
          business.family = business.user.family
        end
      end

      def import
        @xml.css('business cbusiness').each do |xml_business|
          if Casino.casino_types.include? enumify(xml_business['type'])
            import_casino xml_business
          else
            import_business_object xml_business
          end
        end

        import_bullet_factories
      end

      def import_casino(xml_casino)
        casino = @version.casinos.find_or_create_by(ext_casino_id: xml_casino['id'])
        casino.casino_type = enumify(xml_casino['type'])
        casino.city = enumify(xml_casino.css('city').text)
        set_owner(xml_casino, casino)
        casino.protection = xml_casino.css('protection').text
        casino.max_bet = xml_casino.css('maxbet').text
        casino.profit = xml_casino.css('profit').text
        casino.bankrupt = xml_casino.css('closed').text == 'BR'
        casino.save
        Rails.logger.debug "imported casino #{casino.ext_casino_id} (#{casino.casino_type} in #{casino.city})"
      end

      def import_business_object(xml_business)
        business = @version.business_objects.find_or_create_by(ext_object_id: xml_business['id'])
        business.object_type = enumify(xml_business['type'].sub(' (10%)', '').sub(' (5%)', ''))
        business.city = enumify(xml_business.css('city').text)
        set_owner(xml_business, business)
        business.protection = xml_business.css('protection').text
        business.profit = xml_business.css('profit').text
        business.bankrupt = xml_business.css('closed').text == 'BR'
        business.save
        Rails.logger.debug "imported business object #{business.ext_object_id} (#{business.object_type} in #{business.city})"
      end

      def import_bullet_factories
        @xml.css('bulletfactories bulletfactory').each do |xml_bf|
          bf = @version.bullet_factories.find_or_create_by(ext_bullet_factory_id: xml_bf['id'])
          bf.city = enumify(xml_bf.css('city').text)
          set_owner(xml_bf, bf)
          bf.price = xml_bf.css('price').text.to_i
          bf.bullets = xml_bf.css('bullets').text.to_i
          bf.save
          Rails.logger.debug "imported bullet factory #{bf.ext_bullet_factory_id} (#{bf.city})"
        end
      end
    end
  end
end
