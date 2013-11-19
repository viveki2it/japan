# -*- encoding : utf-8 -*-
# Create administrative user
User.create email: "admin@example.com", password: "testadmin", role: "admin"

# Create categories tree

beaute = CategoriesParent.create title: "Beauté & Bien-être", permalink: "beaute_bien_etre"

category = Category.create title: "Soin du corps", permalink: "soin_du_corps", description: "Default", parent: beaute

tags_group = TagsGroup.create name: 'Mains'
Tag.create name: 'Manucure', group: tags_group, category: category
Tag.create name: 'Soins des mains', group: tags_group, category: category

tags_group = TagsGroup.create name: 'Pieds'
Tag.create name: 'Fish pédicure', group: tags_group, category: category
Tag.create name: 'Massage pieds', group: tags_group, category: category
Tag.create name: 'Pédicure', group: tags_group, category: category
Tag.create name: 'Soins pieds', group: tags_group, category: category

tags_group = TagsGroup.create name: 'Corps'
Tag.create name: 'Bilan corporel', group: tags_group, category: category
Tag.create name: 'Envelloppement', group: tags_group, category: category
Tag.create name: 'Gommage corps', group: tags_group, category: category
Tag.create name: 'Hammam', group: tags_group, category: category
Tag.create name: 'Hammam et bains', group: tags_group, category: category
Tag.create name: 'Jeunes mamans', group: tags_group, category: category
Tag.create name: 'Massages corps', group: tags_group, category: category
Tag.create name: 'Modelage', group: tags_group, category: category
Tag.create name: 'Mincir', group: tags_group, category: category
Tag.create name: 'Ostéopathie', group: tags_group, category: category
Tag.create name: 'Peeling Corps', group: tags_group, category: category
Tag.create name: 'Sauna', group: tags_group, category: category
Tag.create name: 'Soins Corps', group: tags_group, category: category
Tag.create name: 'Soins future maman', group: tags_group, category: category
Tag.create name: 'Soins psycho-énergétiques', group: tags_group, category: category
Tag.create name: 'Suivi & evolution du corps', group: tags_group, category: category
Tag.create name: 'Tonification & rajeunissement corps', group: tags_group, category: category

tags_group = TagsGroup.create name: 'Epilation'
Tag.create name: 'Epilation à la cire', group: tags_group, category: category
Tag.create name: 'Epilation éléctrique', group: tags_group, category: category
Tag.create name: 'Epilation orientale', group: tags_group, category: category
Tag.create name: 'Epilation progressive définitive', group: tags_group, category: category
Tag.create name: 'Epilation sourcil', group: tags_group, category: category
Tag.create name: 'Threading - épilation au fil', group: tags_group, category: category


category = Category.create title: "Soin du visage", permalink: "soin_du_visage", description: "Default", parent: beaute
tags_group = TagsGroup.create name: 'Visage'
Tag.create name: 'Cours de maquillage', group: tags_group, category: category
Tag.create name: 'Extension de cils', group: tags_group, category: category
Tag.create name: 'Gommage visage', group: tags_group, category: category
Tag.create name: 'Maquillage', group: tags_group, category: category
Tag.create name: 'Peeling visage', group: tags_group, category: category
Tag.create name: 'Rasage', group: tags_group, category: category
Tag.create name: 'Réflexologie faciale et crânienne', group: tags_group, category: category
Tag.create name: 'Soins visage', group: tags_group, category: category
Tag.create name: 'Soins yeux', group: tags_group, category: category
Tag.create name: 'Tonification & rajeunissement visage', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Sourire'
Tag.create name: 'Blanchiment des dents', group: tags_group, category: category
Tag.create name: 'Maquillage permanent des lèvres', group: tags_group, category: category


category = Category.create title: "Coiffeur", permalink: "coiffeur", description: "Default", parent: beaute
Tag.create name: 'Afro', group: nil, category: category
Tag.create name: 'Attache & Chignon', group: nil, category: category
Tag.create name: 'Balayage', group: nil, category: category
Tag.create name: 'Barbier', group: nil, category: category
Tag.create name: 'Brushing', group: nil, category: category
Tag.create name: 'Coloration', group: nil, category: category
Tag.create name: 'Coupe Enfant', group: nil, category: category
Tag.create name: 'Coupe Femme', group: nil, category: category
Tag.create name: 'Coupe Homme', group: nil, category: category
Tag.create name: 'Coupe Jeune', group: nil, category: category
Tag.create name: 'Décoloration', group: nil, category: category
Tag.create name: 'Défrisage', group: nil, category: category
Tag.create name: 'Démaquillage', group: nil, category: category
Tag.create name: 'Extensions', group: nil, category: category
Tag.create name: 'Gommage', group: nil, category: category
Tag.create name: 'Lissage', group: nil, category: category
Tag.create name: 'Mariée', group: nil, category: category
Tag.create name: 'Permanente', group: nil, category: category
Tag.create name: 'Pré-coloration', group: nil, category: category
Tag.create name: 'Soins réparateur', group: nil, category: category
Tag.create name: 'Soins Coiffure', group: nil, category: category


category = Category.create title: "Sports", permalink: "sports", description: "Default", parent: beaute
tags_group = TagsGroup.create name: 'Collectif'
Tag.create name: 'Basket-ball', group: tags_group, category: category
Tag.create name: 'Beach Volley', group: tags_group, category: category
Tag.create name: 'Beach Soccer', group: tags_group, category: category
Tag.create name: 'Football', group: tags_group, category: category
Tag.create name: 'Jorkyball', group: tags_group, category: category
Tag.create name: 'Handball', group: tags_group, category: category
Tag.create name: 'Paintball', group: tags_group, category: category
Tag.create name: 'Polo', group: tags_group, category: category
Tag.create name: 'Rugby', group: tags_group, category: category
Tag.create name: 'Volley-ball', group: tags_group, category: category
Tag.create name: 'Water polo', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Gym'
Tag.create name: 'Acrosport', group: tags_group, category: category
Tag.create name: 'Aérobic', group: tags_group, category: category
Tag.create name: 'Gymnastique artistique', group: tags_group, category: category
Tag.create name: 'Gymnastique rythmique', group: tags_group, category: category
Tag.create name: 'Trampoline', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Mecanique'
Tag.create name: 'Karting', group: tags_group, category: category
Tag.create name: 'Motocross', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Raquette'
Tag.create name: 'Badminton', group: tags_group, category: category
Tag.create name: 'Padel', group: tags_group, category: category
Tag.create name: 'Pelote basque', group: tags_group, category: category
Tag.create name: 'Squash', group: tags_group, category: category
Tag.create name: 'Tennis', group: tags_group, category: category
Tag.create name: 'Tennis de table', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Cyclisme'
Tag.create name: 'Bmx', group: tags_group, category: category
Tag.create name: 'Cyclisme', group: tags_group, category: category
Tag.create name: 'Vélo tout terrain', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Arts martiaux'
Tag.create name: 'Aïkido', group: tags_group, category: category
Tag.create name: 'Capoeira', group: tags_group, category: category
Tag.create name: 'Ju-jitsu', group: tags_group, category: category
Tag.create name: 'Judo', group: tags_group, category: category
Tag.create name: 'Karaté', group: tags_group, category: category
Tag.create name: 'Kendo', group: tags_group, category: category
Tag.create name: 'Ninjutsu', group: tags_group, category: category
Tag.create name: 'Sumo', group: tags_group, category: category
Tag.create name: 'Taekwondo', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Combat'
Tag.create name: 'Boxe', group: tags_group, category: category
Tag.create name: 'Bâton de combat', group: tags_group, category: category
Tag.create name: 'Lutte', group: tags_group, category: category
Tag.create name: 'Escrime', group: tags_group, category: category
Tag.create name: 'Unifight', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Glace'
Tag.create name: 'Patinage', group: tags_group, category: category
Tag.create name: 'Hockey', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Force'
Tag.create name: 'Bodybuilding', group: tags_group, category: category
Tag.create name: 'Fitness', group: tags_group, category: category
Tag.create name: 'Haltérophilie', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Plein air'
Tag.create name: 'Marche', group: tags_group, category: category
Tag.create name: 'Fitness', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Precision'
Tag.create name: 'Billards', group: tags_group, category: category
Tag.create name: 'Boomerang', group: tags_group, category: category
Tag.create name: 'Croquet', group: tags_group, category: category
Tag.create name: 'Croquet', group: tags_group, category: category
Tag.create name: 'Fléchettes', group: tags_group, category: category
Tag.create name: 'Golf', group: tags_group, category: category
Tag.create name: 'Pétanque', group: tags_group, category: category
Tag.create name: 'Tir', group: tags_group, category: category
Tag.create name: 'Tir à l`arc', group: tags_group, category: category

tags_group = TagsGroup.create name: 'Plein air'
Tag.create name: 'Marche', group: tags_group, category: category
Tag.create name: 'Fitness', group: tags_group, category: category

tags_group = TagsGroup.create name: 'Nautique'
Tag.create name: 'Apnée', group: tags_group, category: category
Tag.create name: 'Natation', group: tags_group, category: category
Tag.create name: 'Plongeon', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Glisse'
Tag.create name: 'Roller', group: tags_group, category: category
Tag.create name: 'Skateboard', group: tags_group, category: category


category = Category.create title: "Mieux-être", permalink: "mieux_etre", description: "Default", parent: beaute
Tag.create name: 'Coaching Minceur', group: nil, category: category
Tag.create name: 'Hypnothérapie', group: nil, category: category
Tag.create name: 'Onirologie', group: nil, category: category
Tag.create name: 'Psychothérapie', group: nil, category: category
Tag.create name: 'Relooking', group: nil, category: category
Tag.create name: 'Yoga', group: nil, category: category


maison = CategoriesParent.create title: "Maison & Déco", permalink: "maison"

category = Category.create title: "Meubles", permalink: "meubles", description: "Default", parent: maison
tags_group = TagsGroup.create name: 'Interieur'
Tag.create name: 'Chaises et fauteuils hauts', group: tags_group, category: category
Tag.create name: 'Tables hautes', group: tags_group, category: category
Tag.create name: 'Tables basses', group: tags_group, category: category
Tag.create name: 'Tabourets de bar', group: tags_group, category: category
Tag.create name: 'Poufs et coussins', group: tags_group, category: category
Tag.create name: 'Fauteuils design', group: tags_group, category: category
Tag.create name: 'Canapés design', group: tags_group, category: category
Tag.create name: 'Etagères et bibliothèques', group: tags_group, category: category
Tag.create name: 'Miroirs', group: tags_group, category: category
Tag.create name: 'Fauteuils bureau', group: tags_group, category: category
Tag.create name: 'Mobilier Bureau', group: tags_group, category: category
Tag.create name: 'Tabourets bas', group: tags_group, category: category
Tag.create name: 'Mobilier d`exception', group: tags_group, category: category
Tag.create name: 'Lits', group: tags_group, category: category
Tag.create name: 'Compléments ameublement', group: tags_group, category: category
Tag.create name: 'Meubles TV', group: tags_group, category: category
Tag.create name: 'Portemanteaux, patères', group: tags_group, category: category
Tag.create name: 'Mobilier pour Kids', group: tags_group, category: category
Tag.create name: 'Tapis / plaids', group: tags_group, category: category
Tag.create name: 'Mobilier lumineux', group: tags_group, category: category
Tag.create name: 'Mobilier Ados', group: tags_group, category: category
Tag.create name: 'Tables de chevet', group: tags_group, category: category
Tag.create name: 'Commodes, bahuts...', group: tags_group, category: category
Tag.create name: 'Consoles', group: tags_group, category: category
Tag.create name: 'Paravents, séparations, cloisons.', group: tags_group, category: category
Tag.create name: 'Rangements', group: tags_group, category: category
Tag.create name: 'Bancs', group: tags_group, category: category
Tag.create name: 'Pots et plantes', group: tags_group, category: category
Tag.create name: 'Poubelles', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Exterieur'
Tag.create name: 'Chaises et fauteuils hauts', group: tags_group, category: category
Tag.create name: 'Poufs et coussins', group: tags_group, category: category
Tag.create name: 'Tables hautes', group: tags_group, category: category
Tag.create name: 'Tables basses', group: tags_group, category: category
Tag.create name: 'Canapés et fauteuils bas', group: tags_group, category: category
Tag.create name: 'Chaises longues et hamacs', group: tags_group, category: category
Tag.create name: 'Parasols', group: tags_group, category: category
Tag.create name: 'Tabourets hauts', group: tags_group, category: category
Tag.create name: 'Barbecues', group: tags_group, category: category
Tag.create name: 'Tabourets bas', group: tags_group, category: category
Tag.create name: 'Bancs', group: tags_group, category: category
Tag.create name: 'Douches', group: tags_group, category: category

category = Category.create title: "Luminaries", permalink: "luminaries", description: "Default", parent: maison
tags_group = TagsGroup.create name: 'Type'
Tag.create name: 'Décorations lumineuses', group: tags_group, category: category
Tag.create name: 'Lampadaires et liseuses', group: tags_group, category: category
Tag.create name: 'Lampes', group: tags_group, category: category
Tag.create name: 'Lustres et suspensions', group: tags_group, category: category
Tag.create name: 'Appliques et spots', group: tags_group, category: category


category = Category.create title: "Accessories déco", permalink: "accessories_deco", description: "Default", parent: maison
tags_group = TagsGroup.create name: 'Linge'
Tag.create name: 'Linge de lit', group: tags_group, category: category
Tag.create name: 'Linge d`office', group: tags_group, category: category
Tag.create name: 'Linge de table', group: tags_group, category: category
Tag.create name: 'Lampes', group: tags_group, category: category
Tag.create name: 'Plaid', group: tags_group, category: category
Tag.create name: 'Coussins', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Objets'
Tag.create name: 'Petits rangements', group: tags_group, category: category
Tag.create name: 'Patères', group: tags_group, category: category
Tag.create name: 'Cadres & Décoration murale', group: tags_group, category: category
Tag.create name: 'Bougies, bougeoirs et photophores', group: tags_group, category: category
Tag.create name: 'Miroirs', group: tags_group, category: category
Tag.create name: 'Serre-livres', group: tags_group, category: category
Tag.create name: 'Stickers', group: tags_group, category: category
Tag.create name: 'Mobiles', group: tags_group, category: category
Tag.create name: 'Nichoirs', group: tags_group, category: category
Tag.create name: 'Petits objets', group: tags_group, category: category
Tag.create name: 'Tapis', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Table'
Tag.create name: 'Tasses, Mugs et Bols', group: tags_group, category: category
Tag.create name: 'Assiettes', group: tags_group, category: category
Tag.create name: 'Ustensiles', group: tags_group, category: category
Tag.create name: 'Carafes et Théières', group: tags_group, category: category
Tag.create name: 'Saladiers', group: tags_group, category: category
Tag.create name: 'Coquetiers', group: tags_group, category: category
Tag.create name: 'Dessous de plat', group: tags_group, category: category
Tag.create name: 'Pots à lait et sucrier', group: tags_group, category: category
Tag.create name: 'Plateau', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Petits mobiliers'
Tag.create name: 'Poufs, nattes et petits canapés', group: tags_group, category: category
Tag.create name: 'Tables d`appoint', group: tags_group, category: category
Tag.create name: 'Bureaux, pupitres', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Curiosites'
Tag.create name: 'Bijoux', group: tags_group, category: category
Tag.create name: 'Transferts', group: tags_group, category: category
Tag.create name: 'Papeterie', group: tags_group, category: category
Tag.create name: 'Aimants', group: tags_group, category: category
Tag.create name: 'Bavoirs', group: tags_group, category: category
Tag.create name: 'Boites à musique', group: tags_group, category: category
Tag.create name: 'Tampons', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Exterieur'
Tag.create name: 'Accessoires déco jardin', group: tags_group, category: category
Tag.create name: 'Compléments d`ameublement', group: tags_group, category: category

category = Category.create title: "Commerce Equitable", permalink: "commerce_equitable", description: "Default", parent: maison
tags_group = TagsGroup.create name: 'Alimentaire'
Tag.create name: 'Café', group: tags_group, category: category
Tag.create name: 'Thés et Infusions', group: tags_group, category: category
Tag.create name: 'Chocolats et Cacao', group: tags_group, category: category
Tag.create name: 'Sucre, miel et confiseries', group: tags_group, category: category
Tag.create name: 'Epices et condiments', group: tags_group, category: category
Tag.create name: 'Bijoux', group: tags_group, category: category
Tag.create name: 'Céréales', group: tags_group, category: category
Tag.create name: 'Jus de Fruits et boissons', group: tags_group, category: category
Tag.create name: 'Biscuits', group: tags_group, category: category

tags_group = TagsGroup.create name: 'Artisanat'
Tag.create name: 'Sacs & Accessoires', group: tags_group, category: category
Tag.create name: 'Bijouterie', group: tags_group, category: category
Tag.create name: 'Vêtements Femme', group: tags_group, category: category
Tag.create name: 'Accessoires Femme', group: tags_group, category: category
Tag.create name: 'Vêtements Homme', group: tags_group, category: category
Tag.create name: 'Bijoux', group: tags_group, category: category
Tag.create name: 'Accessoires Homme', group: tags_group, category: category
Tag.create name: 'Maison', group: tags_group, category: category
Tag.create name: 'Musique', group: tags_group, category: category
Tag.create name: 'Enfant', group: tags_group, category: category

category = Category.create title: "Nature", permalink: "nature", description: "Default", parent: maison
Tag.create name: 'Pots', group: nil, category: category
Tag.create name: 'Plantes', group: nil, category: category
Tag.create name: 'Bouquets', group: nil, category: category
Tag.create name: 'Anniversaire', group: nil, category: category
Tag.create name: 'Naissance', group: nil, category: category
Tag.create name: 'Mariage', group: nil, category: category
Tag.create name: 'Amour', group: nil, category: category
Tag.create name: 'Deuil', group: nil, category: category
Tag.create name: 'Cadeaux', group: nil, category: category


fooding = CategoriesParent.create title: "Restauration & Snacks", permalink: "fooding"
category = Category.create title: "Snack & Sandwich", permalink: "snack_sandwich", description: "Default", parent: fooding
tags_group = TagsGroup.create name: 'Sandwich'
Tag.create name: 'Bagel', group: tags_group, category: category
Tag.create name: 'Club sandwich', group: tags_group, category: category
Tag.create name: 'Minis sandwich', group: tags_group, category: category
Tag.create name: 'Tortillas', group: tags_group, category: category
Tag.create name: 'Sandwich viennois', group: tags_group, category: category
Tag.create name: 'Sandwich scandinave', group: tags_group, category: category
Tag.create name: 'Sandwich ciabatta', group: tags_group, category: category
Tag.create name: 'Hot dog', group: tags_group, category: category
Tag.create name: 'Washiki', group: tags_group, category: category
Tag.create name: 'Croques', group: tags_group, category: category
Tag.create name: 'Wrap', group: tags_group, category: category
Tag.create name: 'Kebab', group: tags_group, category: category
Tag.create name: 'Kefta', group: tags_group, category: category
Tag.create name: 'Burger', group: tags_group, category: category
Tag.create name: 'Panini', group: tags_group, category: category
Tag.create name: 'Burrito', group: tags_group, category: category
Tag.create name: 'Pita', group: tags_group, category: category
Tag.create name: 'Fouée', group: tags_group, category: category
Tag.create name: 'Mitraillette', group: tags_group, category: category
Tag.create name: 'Pan bagnat', group: tags_group, category: category
Tag.create name: 'Tramezzino', group: tags_group, category: category
Tag.create name: 'Tuna ftira', group: tags_group, category: category
Tag.create name: 'Sandwich', group: tags_group, category: category
Tag.create name: 'Fajitas', group: tags_group, category: category
Tag.create name: 'Toasts', group: tags_group, category: category

tags_group = TagsGroup.create name: 'Snack'
Tag.create name: 'Wings', group: tags_group, category: category
Tag.create name: 'Onion Rings', group: tags_group, category: category
Tag.create name: 'Salades', group: tags_group, category: category
Tag.create name: 'Soupes', group: tags_group, category: category
Tag.create name: 'Sushi', group: tags_group, category: category
Tag.create name: 'Tartes salées', group: tags_group, category: category
Tag.create name: 'Pizza', group: tags_group, category: category
Tag.create name: 'Brunch', group: tags_group, category: category
Tag.create name: 'Pasta', group: tags_group, category: category
Tag.create name: 'Brochette', group: tags_group, category: category
Tag.create name: 'Noodles', group: tags_group, category: category
Tag.create name: 'Pretzel', group: tags_group, category: category


category = Category.create title: "Restaurants", permalink: "restaurants", description: "Default", parent: fooding
tags_group = TagsGroup.create name: 'France'
Tag.create name: 'Alsacien', group: tags_group, category: category
Tag.create name: 'Auvergnat', group: tags_group, category: category
Tag.create name: 'Corse', group: tags_group, category: category
Tag.create name: 'Crêperie', group: tags_group, category: category
Tag.create name: 'Cuisine française', group: tags_group, category: category
Tag.create name: 'Lyonnais', group: tags_group, category: category
Tag.create name: 'Poissons et fruits de mers', group: tags_group, category: category
Tag.create name: 'Provençal', group: tags_group, category: category
Tag.create name: 'Savoyard', group: tags_group, category: category
Tag.create name: 'Sud-Ouest', group: tags_group, category: category
Tag.create name: 'Viandes et Grillades', group: tags_group, category: category
Tag.create name: 'Végétarien', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Asie'
Tag.create name: 'Chinois', group: tags_group, category: category
Tag.create name: 'Coréen', group: tags_group, category: category
Tag.create name: 'Japonais', group: tags_group, category: category
Tag.create name: 'Thailandais', group: tags_group, category: category
Tag.create name: 'Vietnamien', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Amerique'
Tag.create name: 'Créole', group: tags_group, category: category
Tag.create name: 'Cubain', group: tags_group, category: category
Tag.create name: 'Mexicain', group: tags_group, category: category
Tag.create name: 'Nord américain', group: tags_group, category: category
Tag.create name: 'Sud américain', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Europe'
Tag.create name: 'Espagnol', group: tags_group, category: category
Tag.create name: 'Europe de l`est', group: tags_group, category: category
Tag.create name: 'Grec', group: tags_group, category: category
Tag.create name: 'Italien', group: tags_group, category: category
Tag.create name: 'Nordique', group: tags_group, category: category
Tag.create name: 'Russe', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Orient'
Tag.create name: 'Algérien', group: tags_group, category: category
Tag.create name: 'Indien', group: tags_group, category: category
Tag.create name: 'Libanais', group: tags_group, category: category
Tag.create name: 'Pakistanais', group: tags_group, category: category
Tag.create name: 'Marocain', group: tags_group, category: category
Tag.create name: 'Tunisien', group: tags_group, category: category
Tag.create name: 'Turquie', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Monde'
Tag.create name: 'Africaine', group: tags_group, category: category
Tag.create name: 'Cuisine des îles', group: tags_group, category: category
Tag.create name: 'Méditerranéenne', group: tags_group, category: category


category = Category.create title: "Epicerie Fine", permalink: "epicerie_fine", description: "Default", parent: fooding
tags_group = TagsGroup.create name: 'Gourmandises'
Tag.create name: 'Chocolats', group: tags_group, category: category
Tag.create name: 'Nougats & calissons', group: tags_group, category: category
Tag.create name: 'Pâtes à tartiner', group: tags_group, category: category
Tag.create name: 'Confiseries', group: tags_group, category: category
Tag.create name: 'Biscuits', group: tags_group, category: category
Tag.create name: 'Gâteaux', group: tags_group, category: category
Tag.create name: 'Fruits', group: tags_group, category: category
Tag.create name: 'Dragées Médicis', group: tags_group, category: category
Tag.create name: 'Miels', group: tags_group, category: category
Tag.create name: 'Confitures', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Condiments'
Tag.create name: 'Huiles', group: tags_group, category: category
Tag.create name: 'Vinaigres', group: tags_group, category: category
Tag.create name: 'Sels', group: tags_group, category: category
Tag.create name: 'Poivres', group: tags_group, category: category
Tag.create name: 'Epices', group: tags_group, category: category
Tag.create name: 'Herbes et aromates', group: tags_group, category: category
Tag.create name: 'Moutardes', group: tags_group, category: category
Tag.create name: 'Sauces', group: tags_group, category: category
Tag.create name: 'Condiments', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Epicerie fine'
Tag.create name: 'Farine', group: tags_group, category: category
Tag.create name: 'Riz et céréales', group: tags_group, category: category
Tag.create name: 'Pâtes', group: tags_group, category: category
Tag.create name: 'Légumes secs', group: tags_group, category: category
Tag.create name: 'Champignons', group: tags_group, category: category
Tag.create name: 'Fruits', group: tags_group, category: category
Tag.create name: 'Fruits secs', group: tags_group, category: category
Tag.create name: 'Truffes', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Viandes'
Tag.create name: 'Foie gras', group: tags_group, category: category
Tag.create name: 'Confits', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Charcuterie & fromages'
Tag.create name: 'Terrines, Rillettes & Pâtés', group: tags_group, category: category
Tag.create name: 'Saucissons & Saucisses', group: tags_group, category: category
Tag.create name: 'Jambons & Jambonneaux', group: tags_group, category: category
Tag.create name: 'Tripes & Spécialités', group: tags_group, category: category
Tag.create name: 'Fromages & Accompagnements', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Produits de la mer'
Tag.create name: 'Terrines et rillettes', group: tags_group, category: category
Tag.create name: 'Conserves', group: tags_group, category: category
Tag.create name: 'Caviar, boutargue & huitres', group: tags_group, category: category
Tag.create name: 'Foie de lotte et oursin', group: tags_group, category: category
Tag.create name: 'Saumon fumé', group: tags_group, category: category
Tag.create name: 'Algues', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Boissons'
Tag.create name: 'Thés', group: tags_group, category: category
Tag.create name: 'Cafés', group: tags_group, category: category
Tag.create name: 'Infusions', group: tags_group, category: category
Tag.create name: 'Cacaos', group: tags_group, category: category
Tag.create name: 'Vins', group: tags_group, category: category
Tag.create name: 'Spiritueux et liqueurs', group: tags_group, category: category
Tag.create name: 'Whisky', group: tags_group, category: category
Tag.create name: 'Champagne & bulles', group: tags_group, category: category
Tag.create name: 'Rhums', group: tags_group, category: category
Tag.create name: 'Digestifs', group: tags_group, category: category
Tag.create name: 'Cidres', group: tags_group, category: category
Tag.create name: 'Bières', group: tags_group, category: category
Tag.create name: 'Cocktails', group: tags_group, category: category
Tag.create name: 'Jus de fruits', group: tags_group, category: category
Tag.create name: 'Limonades et sodas', group: tags_group, category: category
Tag.create name: 'Sirops', group: tags_group, category: category
Tag.create name: 'Eaux du monde', group: tags_group, category: category

category = Category.create title: "Café sucré", permalink: "gafe_sucre", description: "Default", parent: fooding
tags_group = TagsGroup.create name: 'Sucre'
Tag.create name: 'Glace', group: tags_group, category: category
Tag.create name: 'Gelato', group: tags_group, category: category
Tag.create name: 'Yaourts', group: tags_group, category: category
Tag.create name: 'Muffins', group: tags_group, category: category
Tag.create name: 'Cookies', group: tags_group, category: category
Tag.create name: 'Donuts', group: tags_group, category: category
Tag.create name: 'Croissant', group: tags_group, category: category
Tag.create name: 'Pain au chocolat', group: tags_group, category: category
Tag.create name: 'Macarons', group: tags_group, category: category
Tag.create name: 'Cheesecake', group: tags_group, category: category
Tag.create name: 'Tartes sucrées', group: tags_group, category: category
Tag.create name: 'Beignet', group: tags_group, category: category
Tag.create name: 'Biscuits', group: tags_group, category: category
Tag.create name: 'Brioche', group: tags_group, category: category
Tag.create name: 'Brownies', group: tags_group, category: category
Tag.create name: 'Canelé', group: tags_group, category: category
Tag.create name: 'Chausson aux pommes', group: tags_group, category: category
Tag.create name: 'Crêpes', group: tags_group, category: category
Tag.create name: 'Gaufre', group: tags_group, category: category
Tag.create name: 'Crumble', group: tags_group, category: category
Tag.create name: 'Cupcake', group: tags_group, category: category
Tag.create name: 'Flan', group: tags_group, category: category
Tag.create name: 'Gâteau basque', group: tags_group, category: category
Tag.create name: 'Madeleine', group: tags_group, category: category
Tag.create name: 'Pain d’épice', group: tags_group, category: category
Tag.create name: 'Pouding', group: tags_group, category: category
Tag.create name: 'Salade de fruits', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Boissons'
Tag.create name: 'Espresso', group: tags_group, category: category
Tag.create name: 'Macchiato', group: tags_group, category: category
Tag.create name: 'Cappuccino', group: tags_group, category: category
Tag.create name: 'Mocha', group: tags_group, category: category
Tag.create name: 'Café au lait', group: tags_group, category: category
Tag.create name: 'Café americano', group: tags_group, category: category
Tag.create name: 'Chocolat chaud', group: tags_group, category: category
Tag.create name: 'Chocolat au lait', group: tags_group, category: category
Tag.create name: 'Chocolat viennois', group: tags_group, category: category
Tag.create name: 'Milk shake', group: tags_group, category: category
Tag.create name: 'Café frappé', group: tags_group, category: category
Tag.create name: 'Jus', group: tags_group, category: category
Tag.create name: 'Thé glacé', group: tags_group, category: category
Tag.create name: 'Thé', group: tags_group, category: category
Tag.create name: 'Thé earl grey', group: tags_group, category: category
Tag.create name: 'Thé vert', group: tags_group, category: category
Tag.create name: 'Thé noir', group: tags_group, category: category
Tag.create name: 'Thé rouge', group: tags_group, category: category
Tag.create name: 'Thé blanc', group: tags_group, category: category
Tag.create name: 'Thé à la menthe', group: tags_group, category: category
Tag.create name: 'Infusion', group: tags_group, category: category
Tag.create name: 'Smoothie', group: tags_group, category: category
category = Category.create title: "Bio", permalink: "bio", description: "Default", parent: fooding
Tag.create name: 'Aliments diététique santé', group: nil, category: category
Tag.create name: 'Céréales et pâtes bio', group: nil, category: category
Tag.create name: 'Sucres bio', group: nil, category: category
Tag.create name: 'Charcuterie bio', group: nil, category: category
Tag.create name: 'Graines germées', group: nil, category: category
Tag.create name: 'Aides culinaires bio', group: nil, category: category
Tag.create name: 'Confitures et miels', group: nil, category: category
Tag.create name: 'Assaisonnements', group: nil, category: category
Tag.create name: 'Légumes et soupes', group: nil, category: category
Tag.create name: 'Boissons bio', group: nil, category: category
Tag.create name: 'Gourmandises', group: nil, category: category
Tag.create name: 'Cadeaux bio', group: nil, category: category

mode = CategoriesParent.create title: "Mode & Accessoires", permalink: "mode"
category = Category.create title: "Prêt à porter homme", permalink: "pret_a_porter_homme", description: "Default", parent: mode
tags_group = TagsGroup.create name: 'Chemises'
Tag.create name: 'Chemises manches longues', group: tags_group, category: category
Tag.create name: 'Chemises manches courtes', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Maillots / Sous_vêtements'
Tag.create name: 'Boxers', group: tags_group, category: category
Tag.create name: 'Maillots de bain', group: tags_group, category: category
Tag.create name: 'Macarons', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Pantalons'
Tag.create name: 'Pantalons', group: tags_group, category: category
Tag.create name: 'Jeans', group: tags_group, category: category
Tag.create name: 'Sport / Homewear', group: tags_group, category: category
Tag.create name: 'Slims', group: tags_group, category: category
Tag.create name: 'Chinos', group: tags_group, category: category
Tag.create name: 'Pantalons à pinces', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Pulls / Gilets'
Tag.create name: 'Pulls', group: tags_group, category: category
Tag.create name: 'Gilets / Cardigans', group: tags_group, category: category
Tag.create name: 'Sport / Homewear', group: tags_group, category: category
Tag.create name: 'Sweats', group: tags_group, category: category
tags_group = TagsGroup.create name: 'SHORTS'
Tag.create name: 'Bermudas', group: tags_group, category: category
Tag.create name: 'Shorts', group: tags_group, category: category
tags_group = TagsGroup.create name: 'T-shirts / polo'
Tag.create name: 'Débardeurs', group: tags_group, category: category
Tag.create name: 'T-shirts manches courtes', group: tags_group, category: category
Tag.create name: 'T-shirts manches longues', group: tags_group, category: category
Tag.create name: 'Polos', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Vestes / manteaux'
Tag.create name: 'Doudounes', group: tags_group, category: category
Tag.create name: 'Trenchs / Parkas', group: tags_group, category: category
Tag.create name: 'Vestes / Blazers', group: tags_group, category: category
Tag.create name: 'Blousons', group: tags_group, category: category
Tag.create name: 'Manteaux', group: tags_group, category: category
Tag.create name: 'Manteaux 3/4', group: tags_group, category: category
Tag.create name: 'Cuirs', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Costumes'
Tag.create name: 'Chemises', group: tags_group, category: category
Tag.create name: 'Ensemble costume', group: tags_group, category: category
Tag.create name: 'Pantalons costumes', group: tags_group, category: category
Tag.create name: 'Cravates', group: tags_group, category: category

category = Category.create title: "Prêt à porter femme", permalink: "pret_a_porter_femme", description: "Default", parent: mode
tags_group = TagsGroup.create name: 'Combi / shorts'
Tag.create name: 'Short', group: tags_group, category: category
Tag.create name: 'Combis-pantalon', group: tags_group, category: category
Tag.create name: 'Combis-short', group: tags_group, category: category
Tag.create name: 'Salopette', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Jupes'
Tag.create name: 'Jupes courtes', group: tags_group, category: category
Tag.create name: 'Jupes mi-longues / longues', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Leggings / collants'
Tag.create name: 'Leggings courts', group: tags_group, category: category
Tag.create name: 'Leggings longs', group: tags_group, category: category
Tag.create name: 'Collants / Chaussettes', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Maillots'
Tag.create name: 'Maillots 1 pièce', group: tags_group, category: category
Tag.create name: 'Maillots 2 pièces', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Lingerie'
Tag.create name: 'Soutiens-gorge push up', group: tags_group, category: category
Tag.create name: 'Soutiens-gorge corbeille', group: tags_group, category: category
Tag.create name: 'Soutiens-gorge sans bretelles', group: tags_group, category: category
Tag.create name: 'Strings', group: tags_group, category: category
Tag.create name: 'Tangas', group: tags_group, category: category
Tag.create name: 'Slips', group: tags_group, category: category
Tag.create name: 'Shortys', group: tags_group, category: category
Tag.create name: 'Gaines', group: tags_group, category: category
Tag.create name: 'Guêpière', group: tags_group, category: category
Tag.create name: 'Bustier', group: tags_group, category: category
Tag.create name: 'Ensembles sexy', group: tags_group, category: category
Tag.create name: 'Culotte ouverte', group: tags_group, category: category
Tag.create name: 'Nuisettes', group: tags_group, category: category
Tag.create name: 'Redresse seins', group: tags_group, category: category
Tag.create name: 'Porte jartelles', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Pantalons'
Tag.create name: 'Pantalons 3/4 et 7/8', group: tags_group, category: category
Tag.create name: 'Pantalons', group: tags_group, category: category
Tag.create name: 'Jeans', group: tags_group, category: category
Tag.create name: 'Sport / Homewear', group: tags_group, category: category
Tag.create name: 'Jeggings', group: tags_group, category: category
Tag.create name: 'Chinos / Carrots', group: tags_group, category: category
Tag.create name: 'Slims', group: tags_group, category: category
Tag.create name: 'Flares', group: tags_group, category: category
Tag.create name: 'Sarouels', group: tags_group, category: category
Tag.create name: 'Pantalons à pinces', group: tags_group, category: category
Tag.create name: 'Cuirs', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Pulls / gilets'
Tag.create name: 'Pulls', group: tags_group, category: category
Tag.create name: 'Gilets / Cardigans', group: tags_group, category: category
Tag.create name: 'Gilets sans manches', group: tags_group, category: category
Tag.create name: 'Ponchos / Boléros', group: tags_group, category: category
Tag.create name: 'Sport / Homewear', group: tags_group, category: category
Tag.create name: 'Sweats', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Robes'
Tag.create name: 'Robes courtes', group: tags_group, category: category
Tag.create name: 'Robes longues', group: tags_group, category: category
Tag.create name: 'Robes bustiers', group: tags_group, category: category
Tag.create name: 'Robes pulls', group: tags_group, category: category
Tag.create name: 'Robes en cuir', group: tags_group, category: category
Tag.create name: 'Robes de soirée', group: tags_group, category: category
Tag.create name: 'Robes en soie', group: tags_group, category: category
Tag.create name: 'Robes sans manche', group: tags_group, category: category
Tag.create name: 'Robes tuniques', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Tops'
Tag.create name: 'Débardeurs', group: tags_group, category: category
Tag.create name: 'Tops manches courtes', group: tags_group, category: category
Tag.create name: 'Tops manches longues', group: tags_group, category: category
Tag.create name: 'Cols roulés', group: tags_group, category: category
Tag.create name: 'Polos', group: tags_group, category: category
Tag.create name: 'Chemises/Blouses', group: tags_group, category: category
Tag.create name: 'T-shirts manches longues', group: tags_group, category: category
Tag.create name: 'T-shirts manches courtes', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Vestes / manteaux'
Tag.create name: 'Manteaux courts', group: tags_group, category: category
Tag.create name: 'Doudounes', group: tags_group, category: category
Tag.create name: 'Manteaux longs', group: tags_group, category: category
Tag.create name: 'Trenchs / Parkas', group: tags_group, category: category
Tag.create name: 'Vestes / Blazers', group: tags_group, category: category
Tag.create name: 'Blousons', group: tags_group, category: category
Tag.create name: 'Capes', group: tags_group, category: category
Tag.create name: 'Manteaux 3/4', group: tags_group, category: category
Tag.create name: 'Cuirs', group: tags_group, category: category

category = Category.create title: "Prêt à porter enfant", permalink: "pret_a_porter_enfant", description: "Default", parent: mode
tags_group = TagsGroup.create name: 'Fille'
Tag.create name: 'Shorts', group: tags_group, category: category
Tag.create name: 'Combis-pantalons', group: tags_group, category: category
Tag.create name: 'Combis-shorts', group: tags_group, category: category
Tag.create name: 'Jupes courtes', group: tags_group, category: category
Tag.create name: 'Leggings longs', group: tags_group, category: category
Tag.create name: 'Collants / Chaussettes', group: tags_group, category: category
Tag.create name: 'Maillots 1 pièce', group: tags_group, category: category
Tag.create name: 'Maillots 2 pièces', group: tags_group, category: category
Tag.create name: 'Lingerie', group: tags_group, category: category
Tag.create name: 'Pantalons', group: tags_group, category: category
Tag.create name: 'Jeans', group: tags_group, category: category
Tag.create name: 'Sport / Homewear', group: tags_group, category: category
Tag.create name: 'Jeggings', group: tags_group, category: category
Tag.create name: 'Sarouels', group: tags_group, category: category
Tag.create name: 'Puériculture', group: tags_group, category: category
Tag.create name: 'Pulls', group: tags_group, category: category
Tag.create name: 'Gilets / Cardigans', group: tags_group, category: category
Tag.create name: 'Sport / Homewear', group: tags_group, category: category
Tag.create name: 'Robes courtes', group: tags_group, category: category
Tag.create name: 'Robes longues', group: tags_group, category: category
Tag.create name: 'Débardeurs', group: tags_group, category: category
Tag.create name: 'Chemises/Blouses', group: tags_group, category: category
Tag.create name: 'Tops', group: tags_group, category: category
Tag.create name: 'Doudounes', group: tags_group, category: category
Tag.create name: 'Vestes / Blazers', group: tags_group, category: category
Tag.create name: 'Manteaux 3/4', group: tags_group, category: category
Tag.create name: 'Accessoires', group: tags_group, category: category
Tag.create name: 'Chaussures', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Garçon'
Tag.create name: 'Shorts', group: tags_group, category: category
Tag.create name: 'Combis-pantalons', group: tags_group, category: category
Tag.create name: 'Salopettes', group: tags_group, category: category
Tag.create name: 'Collants / Chaussettes', group: tags_group, category: category
Tag.create name: 'Boxers', group: tags_group, category: category
Tag.create name: 'Maillots de bain', group: tags_group, category: category
Tag.create name: 'Pantalons', group: tags_group, category: category
Tag.create name: 'Jeans', group: tags_group, category: category
Tag.create name: 'Sport / Homewear', group: tags_group, category: category
Tag.create name: 'Puériculture', group: tags_group, category: category
Tag.create name: 'Pulls', group: tags_group, category: category
Tag.create name: 'Gilets / Cardigans', group: tags_group, category: category
Tag.create name: 'Sport / Homewear', group: tags_group, category: category
Tag.create name: 'Débardeurs', group: tags_group, category: category
Tag.create name: 'Tops', group: tags_group, category: category
Tag.create name: 'Chemises/Blouses', group: tags_group, category: category
Tag.create name: 'T-shirts', group: tags_group, category: category
Tag.create name: 'Manteaux', group: tags_group, category: category
Tag.create name: 'Doudounes', group: tags_group, category: category
Tag.create name: 'Blousons', group: tags_group, category: category
Tag.create name: 'Vestes / Blazers', group: tags_group, category: category
Tag.create name: 'Accessoires', group: tags_group, category: category
Tag.create name: 'Chaussures', group: tags_group, category: category



category = Category.create title: "Chaussures homme", permalink: "chaussures_homme", description: "Default", parent: mode
Tag.create name: 'Baskets mode', group: nil, category: category
Tag.create name: 'Bottes et bottines', group: nil, category: category
Tag.create name: 'Bottines et boots', group: nil, category: category
Tag.create name: 'Chaussons', group: nil, category: category
Tag.create name: 'Chaussures à boucles', group: nil, category: category
Tag.create name: 'Chaussures à lacets', group: nil, category: category
Tag.create name: 'Chaussures bateaux', group: nil, category: category
Tag.create name: 'Chaussures de sport', group: nil, category: category
Tag.create name: 'Derbies', group: nil, category: category
Tag.create name: 'Espadrilles', group: nil, category: category
Tag.create name: 'Mocassins', group: nil, category: category
Tag.create name: 'Neige et temps froid', group: nil, category: category
Tag.create name: 'Nu-pieds et sandales', group: nil, category: category
Tag.create name: 'Richelieu', group: nil, category: category
Tag.create name: 'Santiags', group: nil, category: category
Tag.create name: 'Tongs', group: nil, category: category
category = Category.create title: "Chaussures femme", permalink: "chaussures_femme", description: "Default", parent: mode
Tag.create name: 'Ballerines', group: nil, category: category
Tag.create name: 'Baskets mode', group: nil, category: category
Tag.create name: 'Bottes', group: nil, category: category
Tag.create name: 'Bottines et boots', group: nil, category: category
Tag.create name: 'Chaussons', group: nil, category: category
Tag.create name: 'Chaussures à lacets', group: nil, category: category
Tag.create name: 'Chaussures de sport', group: nil, category: category
Tag.create name: 'Compensées', group: nil, category: category
Tag.create name: 'Cuissardes', group: nil, category: category
Tag.create name: 'Escarpins', group: nil, category: category
Tag.create name: 'Espadrilles', group: nil, category: category
Tag.create name: 'Mocassins', group: nil, category: category
Tag.create name: 'Mules et sabots', group: nil, category: category
Tag.create name: 'Neige et temps froid', group: nil, category: category
Tag.create name: 'Nu-pieds et sandales', group: nil, category: category
Tag.create name: 'Santiags', group: nil, category: category
Tag.create name: 'Spartiates', group: nil, category: category
Tag.create name: 'Tongs', group: nil, category: category

category = Category.create title: "Lunettes de soleil", permalink: "lunettes_de_soleil", description: "Default", parent: mode
tags_group = TagsGroup.create name: 'Unisex'
Tag.create name: 'Aviator', group: tags_group, category: category
Tag.create name: 'Carré', group: tags_group, category: category
Tag.create name: 'Wayfarer', group: tags_group, category: category
Tag.create name: 'Ovale', group: tags_group, category: category
Tag.create name: 'Masque', group: tags_group, category: category
Tag.create name: 'Ronde', group: tags_group, category: category
Tag.create name: 'Papillon', group: tags_group, category: category
Tag.create name: 'Enveloppante', group: tags_group, category: category
Tag.create name: 'Sans Monture', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Homme'
Tag.create name: 'Aviator', group: tags_group, category: category
Tag.create name: 'Carré', group: tags_group, category: category
Tag.create name: 'Wayfarer', group: tags_group, category: category
Tag.create name: 'Ovale', group: tags_group, category: category
Tag.create name: 'Masque', group: tags_group, category: category
Tag.create name: 'Ronde', group: tags_group, category: category
Tag.create name: 'Papillon', group: tags_group, category: category
Tag.create name: 'Enveloppante', group: tags_group, category: category
Tag.create name: 'Sans Monture', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Femme'
Tag.create name: 'Aviator', group: tags_group, category: category
Tag.create name: 'Carré', group: tags_group, category: category
Tag.create name: 'Wayfarer', group: tags_group, category: category
Tag.create name: 'Ovale', group: tags_group, category: category
Tag.create name: 'Masque', group: tags_group, category: category
Tag.create name: 'Ronde', group: tags_group, category: category
Tag.create name: 'Papillon', group: tags_group, category: category
Tag.create name: 'Enveloppante', group: tags_group, category: category
Tag.create name: 'Sans Monture', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Enfant'
Tag.create name: 'Aviator', group: tags_group, category: category
Tag.create name: 'Carré', group: tags_group, category: category
Tag.create name: 'Wayfarer', group: tags_group, category: category
Tag.create name: 'Ovale', group: tags_group, category: category
Tag.create name: 'Masque', group: tags_group, category: category
Tag.create name: 'Ronde', group: tags_group, category: category
Tag.create name: 'Papillon', group: tags_group, category: category
Tag.create name: 'Enveloppante', group: tags_group, category: category
Tag.create name: 'Sans Monture', group: tags_group, category: category

category = Category.create title: "Sportwear", permalink: "sportwear", description: "Default", parent: mode
tags_group = TagsGroup.create name: 'Hommes'
Tag.create name: 'Maillots de bain', group: tags_group, category: category
Tag.create name: 'Maillots de Foot', group: tags_group, category: category
Tag.create name: 'Maillots de Rugby', group: tags_group, category: category
Tag.create name: 'Pantacourts / shorts', group: tags_group, category: category
Tag.create name: 'Polaires', group: tags_group, category: category
Tag.create name: 'Pulls', group: tags_group, category: category
Tag.create name: 'Shorts De Foot', group: tags_group, category: category
Tag.create name: 'Sous vêtements', group: tags_group, category: category
Tag.create name: 'Survêtements', group: tags_group, category: category
Tag.create name: 'Sweats / vestes zippées', group: tags_group, category: category
Tag.create name: 'Tee-shirts', group: tags_group, category: category
Tag.create name: 'Thermiques', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Femmes'
Tag.create name: 'Débardeurs', group: tags_group, category: category
Tag.create name: 'Maillots de bain', group: tags_group, category: category
Tag.create name: 'Pantacourts / shorts', group: tags_group, category: category
Tag.create name: 'Polaires', group: tags_group, category: category
Tag.create name: 'Polos', group: tags_group, category: category
Tag.create name: 'Pulls / Gilets', group: tags_group, category: category
Tag.create name: 'Jupes', group: tags_group, category: category
Tag.create name: 'Survêtements', group: tags_group, category: category
Tag.create name: 'Sweats / vestes zippées', group: tags_group, category: category
Tag.create name: 'Tee-shirts', group: tags_group, category: category
Tag.create name: 'Thermiques', group: tags_group, category: category
Tag.create name: 'Veste de ski', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Enfants'
Tag.create name: 'Maillots de bain', group: tags_group, category: category
Tag.create name: 'Maillots de Foot', group: tags_group, category: category
Tag.create name: 'Shorts', group: tags_group, category: category
Tag.create name: 'Shorts De Foot', group: tags_group, category: category
Tag.create name: 'Polaires', group: tags_group, category: category
Tag.create name: 'Polos', group: tags_group, category: category
Tag.create name: 'Pulls', group: tags_group, category: category
Tag.create name: 'Sous-vêtements', group: tags_group, category: category
Tag.create name: 'Survêtements', group: tags_group, category: category
Tag.create name: 'Sweats', group: tags_group, category: category
Tag.create name: 'Tee-shirts', group: tags_group, category: category
Tag.create name: 'Thermiques', group: tags_group, category: category
Tag.create name: 'Vestes zippées', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Chaussures de sport'
Tag.create name: 'Baskets basses', group: tags_group, category: category
Tag.create name: 'Baskets montantes', group: tags_group, category: category
Tag.create name: 'Boots', group: tags_group, category: category
Tag.create name: 'Foot', group: tags_group, category: category
Tag.create name: 'Indoor', group: tags_group, category: category
Tag.create name: 'Randonnée', group: tags_group, category: category
Tag.create name: 'Running / trail', group: tags_group, category: category
Tag.create name: 'Skate', group: tags_group, category: category

category = Category.create title: "Accessories", permalink: "accessories", description: "Default", parent: mode
tags_group = TagsGroup.create name: 'Femme'
Tag.create name: 'Bijoux', group: tags_group, category: category
Tag.create name: 'Ceinture', group: tags_group, category: category
Tag.create name: 'Foulard', group: tags_group, category: category
Tag.create name: 'Echarpe', group: tags_group, category: category
Tag.create name: 'Bonnet', group: tags_group, category: category
Tag.create name: 'Chapeau', group: tags_group, category: category
Tag.create name: 'Gants', group: tags_group, category: category
Tag.create name: 'Cheveux', group: tags_group, category: category
Tag.create name: 'Serviettes', group: tags_group, category: category
Tag.create name: 'Parapluies', group: tags_group, category: category
Tag.create name: 'Portes-clefs', group: tags_group, category: category
Tag.create name: 'Montres', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Sac femme'
Tag.create name: 'Sacs en cuir', group: tags_group, category: category
Tag.create name: 'Sacs à main', group: tags_group, category: category
Tag.create name: 'Sacs à bandoulière', group: tags_group, category: category
Tag.create name: 'Sacs XL', group: tags_group, category: category
Tag.create name: 'Sacs de soirée/Pochettes', group: tags_group, category: category
Tag.create name: 'Petite Maro/Portefeuilles', group: tags_group, category: category
Tag.create name: 'Weekend bags/Valises', group: tags_group, category: category
Tag.create name: 'Cartables', group: tags_group, category: category
Tag.create name: 'Sacs de ville', group: tags_group, category: category
Tag.create name: 'Sacs de plage', group: tags_group, category: category
Tag.create name: 'Sacs de sport', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Homme'
Tag.create name: 'Bonnets', group: tags_group, category: category
Tag.create name: 'Chapeaux', group: tags_group, category: category
Tag.create name: 'Ceintures', group: tags_group, category: category
Tag.create name: 'Echarpes', group: tags_group, category: category
Tag.create name: 'Foulards', group: tags_group, category: category
Tag.create name: 'Petite Maroquinerie', group: tags_group, category: category
Tag.create name: 'Gants', group: tags_group, category: category
Tag.create name: 'Montres', group: tags_group, category: category
Tag.create name: 'Parapluies', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Sac homme'
Tag.create name: 'Cartables', group: tags_group, category: category
Tag.create name: 'Sacs de ville', group: tags_group, category: category
Tag.create name: 'Sacs de sport', group: tags_group, category: category

sorties = CategoriesParent.create title: "Sorties & Loisirs", permalink: "sorties"
Category.create title: "Concerts & Spectacles", permalink: "concerts_spectacles", description: "Default", parent: sorties
tags_group = TagsGroup.create name: 'Concerts'
Tag.create name: 'Musique classique', group: tags_group, category: category
Tag.create name: 'Musique du monde', group: tags_group, category: category
Tag.create name: 'Chanson Française', group: tags_group, category: category
Tag.create name: 'Variété Internationale', group: tags_group, category: category
Tag.create name: 'Pop / Rock / Folk', group: tags_group, category: category
Tag.create name: 'Jazz / Blues / Gospel', group: tags_group, category: category
Tag.create name: 'Musique électronique', group: tags_group, category: category
Tag.create name: 'Rap / R`n`b / Slam /Hip hop', group: tags_group, category: category
Tag.create name: 'Punk - Hardcore', group: tags_group, category: category
Tag.create name: 'Soul - Funk - Reggae', group: tags_group, category: category
Tag.create name: 'Boeuf / Jam sessions', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Spectacles'
Tag.create name: 'One man show', group: tags_group, category: category
Tag.create name: 'Plateau d`humoristes', group: tags_group, category: category
Tag.create name: 'Slam', group: tags_group, category: category
Tag.create name: 'Comédie musicale', group: tags_group, category: category
Tag.create name: 'Danse', group: tags_group, category: category
Tag.create name: 'Danse du monde', group: tags_group, category: category
Tag.create name: 'Danse contemporaine', group: tags_group, category: category
Tag.create name: 'Danse Classique', group: tags_group, category: category
Tag.create name: 'Cabaret / revue', group: tags_group, category: category
Tag.create name: 'Nuits à Thème', group: tags_group, category: category
Tag.create name: 'Son et lumière', group: tags_group, category: category
Tag.create name: 'Spectacle Historique', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Opera'
Tag.create name: 'Opérette', group: tags_group, category: category
Tag.create name: 'Concert Lyrique', group: tags_group, category: category
Tag.create name: 'Musique Baroque', group: tags_group, category: category
Tag.create name: 'Opéra', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Cirque'
Tag.create name: 'Cirque traditionnel', group: tags_group, category: category
Tag.create name: 'Cirque Contemporain', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Theâtre'
Tag.create name: 'Théâtre de boulevard', group: tags_group, category: category
Tag.create name: 'Comédie', group: tags_group, category: category
Tag.create name: 'Comédie dramatique', group: tags_group, category: category
Tag.create name: 'Théâtre dramatique', group: tags_group, category: category
Tag.create name: 'Théâtre classique', group: tags_group, category: category
Tag.create name: 'Théâtre contemporain', group: tags_group, category: category
Tag.create name: 'Théâtre musical', group: tags_group, category: category
Tag.create name: 'Contes pour Adultes', group: tags_group, category: category
Tag.create name: 'Mimes, Marionnettes', group: tags_group, category: category

Category.create title: "Night clubs", permalink: "night_clubs", description: "Default", parent: sorties
Tag.create name: 'Etudiants', group: nil, category: category
Tag.create name: 'Gay', group: nil, category: category
Tag.create name: 'Lesbienne', group: nil, category: category
Tag.create name: 'After Work', group: nil, category: category
Tag.create name: 'Dancing & rétro', group: nil, category: category
Tag.create name: 'Funk & soul', group: nil, category: category
Tag.create name: 'Discothèques généralistes', group: nil, category: category
Tag.create name: 'Hip-Hop / R’n’b', group: nil, category: category
Tag.create name: 'House', group: nil, category: category
Tag.create name: 'Musiques latines', group: nil, category: category
Tag.create name: 'Pop Inde', group: nil, category: category
Tag.create name: 'Reggae / dub / ska', group: nil, category: category
Tag.create name: 'Rock / punk', group: nil, category: category
Tag.create name: 'Techno / electro', group: nil, category: category
Tag.create name: 'Zouk / créole', group: nil, category: category
Tag.create name: 'Select / VIP', group: nil, category: category
Category.create title: "Bars & Pubs", permalink: "bars_pubs", description: "Default", parent: sorties
Tag.create name: 'Live music', group: nil, category: category
Tag.create name: 'Cocktail bar', group: nil, category: category
Tag.create name: 'Café bar', group: nil, category: category
Tag.create name: 'Bar à vin', group: nil, category: category
Tag.create name: 'Pub', group: nil, category: category
Tag.create name: 'Piano / jazz bar', group: nil, category: category
Tag.create name: 'Gastrobar', group: nil, category: category
Tag.create name: 'Bar à champagne', group: nil, category: category
Tag.create name: 'Bar lounge', group: nil, category: category
Tag.create name: 'Bar d’hôtel', group: nil, category: category
Tag.create name: 'Bar gay', group: nil, category: category
Tag.create name: 'Bar lesbienne', group: nil, category: category
Tag.create name: 'Bar sportif', group: nil, category: category
Tag.create name: 'Bar branché', group: nil, category: category
Tag.create name: 'Bar de nuit', group: nil, category: category
Tag.create name: 'Bodega', group: nil, category: category
Tag.create name: 'Insolite', group: nil, category: category
Tag.create name: 'Bar pas cher', group: nil, category: category
Tag.create name: 'Bar dansant', group: nil, category: category
culture = CategoriesParent.create title: "Culture & Education", permalink: "culture"
Category.create title: "Librarie", permalink: "librarie", description: "Default", parent: culture
tags_group = TagsGroup.create name: 'BD & Jeunesse'
Tag.create name: 'BD & Humour', group: tags_group, category: category
Tag.create name: 'Manga', group: tags_group, category: category
Tag.create name: 'Livre Jeunesse', group: tags_group, category: category
Tag.create name: 'Livre Ados et Young adults', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Litterature & fiction'
Tag.create name: 'Roman et Nouvelles', group: tags_group, category: category
Tag.create name: 'Roman en poche', group: tags_group, category: category
Tag.create name: 'Poésie, Théâtre, Lettres', group: tags_group, category: category
Tag.create name: 'Roman Policier et Thriller', group: tags_group, category: category
Tag.create name: 'Fantasy et Science-Fiction', group: tags_group, category: category
Tag.create name: 'Littérature sentimentale', group: tags_group, category: category
Tag.create name: 'Livres audio', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Culture & societe'
Tag.create name: 'Actualité : Politique, Economie, Société', group: tags_group, category: category
Tag.create name: 'Art, Cinéma, Musique', group: tags_group, category: category
Tag.create name: 'Biographie Autobiographie', group: tags_group, category: category
Tag.create name: 'Esotérisme et Paranormal', group: tags_group, category: category
Tag.create name: 'Histoire', group: tags_group, category: category
Tag.create name: 'Religions et Spiritualités', group: tags_group, category: category
Tag.create name: 'Sciences humaines', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Vie pratique'
Tag.create name: 'Cuisine et vins', group: tags_group, category: category
Tag.create name: 'Erotisme (public averti)', group: tags_group, category: category
Tag.create name: 'Santé, Bien-être, Puériculture', group: tags_group, category: category
Tag.create name: 'Loisirs créatifs, Décoration, Bricolage', group: tags_group, category: category
Tag.create name: 'Sports et autres loisirs', group: tags_group, category: category
Tag.create name: 'Tourisme et Voyages', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Nature & loisirs'
Tag.create name: 'Nature, Animaux, Jardin', group: tags_group, category: category
Tag.create name: 'Sports, Loisirs, Transports', group: tags_group, category: category
Tag.create name: 'Tourisme et Voyage', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Scolaire & universitaire'
Tag.create name: 'Scolaire et soutien scolaire', group: tags_group, category: category
Tag.create name: 'Rentrée universitaire', group: tags_group, category: category
Tag.create name: 'Concours et Prépas', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Savoirs'
Tag.create name: 'Dictionnaires et Langues', group: tags_group, category: category
Tag.create name: 'Droit', group: tags_group, category: category
Tag.create name: 'Entreprise, management', group: tags_group, category: category
Tag.create name: 'Livres Informatique', group: tags_group, category: category
Tag.create name: 'Sciences et Médecine', group: tags_group, category: category


Category.create title: "Musique", permalink: "musique", description: "Default", parent: culture
tags_group = TagsGroup.create name: 'Genres'
Tag.create name: 'Variété française', group: tags_group, category: category
Tag.create name: 'Pop', group: tags_group, category: category
Tag.create name: 'Rock', group: tags_group, category: category
Tag.create name: 'Compilations / Dance', group: tags_group, category: category
Tag.create name: 'Rock Indépendant', group: tags_group, category: category
Tag.create name: 'Rap / Hip-Hop', group: tags_group, category: category
Tag.create name: 'R&B', group: tags_group, category: category
Tag.create name: 'Soul / Funk', group: tags_group, category: category
Tag.create name: 'Reggae', group: tags_group, category: category
Tag.create name: 'Ragga', group: tags_group, category: category
Tag.create name: 'Ska', group: tags_group, category: category
Tag.create name: 'Musique Classique', group: tags_group, category: category
Tag.create name: 'Electro', group: tags_group, category: category
Tag.create name: 'Indé / Alternatif', group: tags_group, category: category
Tag.create name: 'Hard / Metal', group: tags_group, category: category
Tag.create name: 'Folk & Songwriter', group: tags_group, category: category
Tag.create name: 'Musiques du monde', group: tags_group, category: category
Tag.create name: 'Jazz', group: tags_group, category: category
Tag.create name: 'Blues', group: tags_group, category: category
Tag.create name: 'Musiques de films', group: tags_group, category: category
Tag.create name: 'Comédies musicales', group: tags_group, category: category
Tag.create name: 'Enfants', group: tags_group, category: category
Tag.create name: 'Karaoké', group: tags_group, category: category
Tag.create name: 'J-pop / J-rock', group: tags_group, category: category
Tag.create name: 'Import Trendy', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Instruments'
Tag.create name: 'Guitares', group: tags_group, category: category
Tag.create name: 'Basses', group: tags_group, category: category
Tag.create name: 'Contrebasses', group: tags_group, category: category
Tag.create name: 'Piano / Claviers', group: tags_group, category: category
Tag.create name: 'DJ', group: tags_group, category: category
Tag.create name: 'Batteries', group: tags_group, category: category
Tag.create name: 'Autres Percussions', group: tags_group, category: category
Tag.create name: 'Trompettes', group: tags_group, category: category
Tag.create name: 'Saxophones', group: tags_group, category: category
Tag.create name: 'Violons', group: tags_group, category: category
Tag.create name: 'Autres cuivres & vents', group: tags_group, category: category
Tag.create name: 'Accordéons', group: tags_group, category: category
Tag.create name: 'Accessoires', group: tags_group, category: category

Category.create title: "Art", permalink: "art", description: "Default", parent: culture
tags_group = TagsGroup.create name: 'Oeuvres uniques'
Tag.create name: 'Sculpture', group: tags_group, category: category
Tag.create name: 'Peinture', group: tags_group, category: category
Tag.create name: 'Illustration', group: tags_group, category: category
Tag.create name: 'Dessin', group: tags_group, category: category
Tag.create name: 'Collage', group: tags_group, category: category
Tag.create name: 'Art numérique', group: tags_group, category: category
Tag.create name: 'Vidéo', group: tags_group, category: category
Tag.create name: 'Tapisserie', group: tags_group, category: category
Tag.create name: 'Mosaïque', group: tags_group, category: category
Tag.create name: 'Céramique', group: tags_group, category: category
Tag.create name: 'Enluminure', group: tags_group, category: category
Tag.create name: 'Plasticien', group: tags_group, category: category
Tag.create name: 'Verre', group: tags_group, category: category
Tag.create name: 'Orfèvrerie', group: tags_group, category: category
Tag.create name: 'Calligraphie', group: tags_group, category: category
Tag.create name: 'Autre Expression', group: tags_group, category: category
Tag.create name: 'Design', group: tags_group, category: category
Tag.create name: 'Pyrogravure', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Reproductions'
Tag.create name: 'Photographie', group: tags_group, category: category
Tag.create name: 'Gravure', group: tags_group, category: category
Tag.create name: 'Lithographie', group: tags_group, category: category
Tag.create name: 'Estampe numérique', group: tags_group, category: category
Tag.create name: 'Tirés à part', group: tags_group, category: category
Tag.create name: 'Affiche', group: tags_group, category: category
Tag.create name: 'Carte postale', group: tags_group, category: category

Category.create title: "Cours", permalink: "cours", description: "Default", parent: culture
tags_group = TagsGroup.create name: 'Langues'
Tag.create name: 'Allemand', group: tags_group, category: category
Tag.create name: 'Anglais', group: tags_group, category: category
Tag.create name: 'Arabe', group: tags_group, category: category
Tag.create name: 'Chinois', group: tags_group, category: category
Tag.create name: 'Espagnol', group: tags_group, category: category
Tag.create name: 'Hébreu', group: tags_group, category: category
Tag.create name: 'Hindi', group: tags_group, category: category
Tag.create name: 'Italien', group: tags_group, category: category
Tag.create name: 'Japonais', group: tags_group, category: category
Tag.create name: 'Langue des signes', group: tags_group, category: category
Tag.create name: 'Portugais', group: tags_group, category: category
Tag.create name: 'Russe', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Musique'
Tag.create name: 'Accordéon', group: tags_group, category: category
Tag.create name: 'Basse', group: tags_group, category: category
Tag.create name: 'Batterie', group: tags_group, category: category
Tag.create name: 'Chant', group: tags_group, category: category
Tag.create name: 'Chorale', group: tags_group, category: category
Tag.create name: 'Clarinette', group: tags_group, category: category
Tag.create name: 'Contrebasse', group: tags_group, category: category
Tag.create name: 'Flûte', group: tags_group, category: category
Tag.create name: 'Guitare', group: tags_group, category: category
Tag.create name: 'Harmonica', group: tags_group, category: category
Tag.create name: 'Harpe', group: tags_group, category: category
Tag.create name: 'Mix', group: tags_group, category: category
Tag.create name: 'Percussions', group: tags_group, category: category
Tag.create name: 'Piano', group: tags_group, category: category
Tag.create name: 'Saxophone', group: tags_group, category: category
Tag.create name: 'Solfège', group: tags_group, category: category
Tag.create name: 'Trombone', group: tags_group, category: category
Tag.create name: 'Trompette', group: tags_group, category: category
Tag.create name: 'Violon', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Loisirs'
Tag.create name: 'Cuisine', group: tags_group, category: category
Tag.create name: 'Décoration', group: tags_group, category: category
Tag.create name: 'Echecs', group: tags_group, category: category
Tag.create name: 'Jardinage', group: tags_group, category: category
Tag.create name: 'Magie', group: tags_group, category: category
Tag.create name: 'Oenologie', group: tags_group, category: category
Tag.create name: 'Cuisine', group: tags_group, category: category
Tag.create name: 'Poker', group: tags_group, category: category
Tag.create name: 'Relooking', group: tags_group, category: category
Tag.create name: 'Secourisme', group: tags_group, category: category
tags_group = TagsGroup.create name: 'Arts'
Tag.create name: 'Cinéma', group: tags_group, category: category
Tag.create name: 'Dessin', group: tags_group, category: category
Tag.create name: 'Peinture', group: tags_group, category: category
Tag.create name: 'Photographie', group: tags_group, category: category
Tag.create name: 'Sculpture', group: tags_group, category: category
Tag.create name: 'Théâtre', group: tags_group, category: category
