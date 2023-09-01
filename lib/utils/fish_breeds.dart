class FishBreeds {
  static Map<String, String> breeds = {
    'Babuska (Carassius gibelio)':
        'Babuška (lat. Carassius gibelio pre 2003. godine lat. Carassius auratus gibelio) je slatkovodna riba veoma prilagodljive prirode. Pripada porodici šarana. Poreklom je iz Azije, odnosno Sibira. U našim rekama i jezerima se prvi put pojavila početkom osamdesetih godina 20. veka, a donesena je iz Kine. \n \n Babuška izgledom podseća na karaša (Carassius carassius), dostiže dužinu od 10 − 35 cm. Krljušti su joj veće od krljušti karaša, po pravilu ima 27 − 32 krljušti duž lateralne linije, dok karaš ima 31 − 35. Srebrnkaste je boje, ponekad sa blagim zlatnim tonom. Babuškin rep je račvastiji u odnosu na karašev. Ima debelo telo, najčešće je srebrne boje i nema brčiće poput običnog šarana. \n \nBabuška po svojim karakteristikama pripada porodici šarana srednje veličine i uglavnom ne prelazi težinu od 3 Kg i dužinu od 45 centimetara.',
    'Saran (Cyprinus carpio)':
        'Šaran (Cyprinus carpio) riba je iz porodice Cyprinidae. Ima produljeno, debelo tijelo potpuno prekriveno ljuskama. Masivna se glava završava ustima s četiri brka, a usta može produljiti u obliku cijevi kojom šaran pretražuje i usisava hranu s dna. Jedina leđna peraja ima na početku nazubljenu i veoma oštru zraku. Prema staništu, boja mu varira od bijelo zlatne do smeđe po leđima, a postaje svjetlija s bakrenim odsjajima po bokovima te završava više ili manje svijetlim trbuhom.',
    'Som (Silurus glanis)':
        'Som (Silurus glanis) je riba iz porodice Siluridae. Ima izduženo tijelo, široko i zdepasto na prednjem dijelu lagano je spljošteno na stražnjem dijelu u razini repne peraje. Koža nema ljuski, a prekrivena je sa sluzi koja daje somu ljepljiv izgled. Glava mu je velika i masivna, uzdužno spljoštena a završava široko rasječenim ustima, sa 6 brkova, 2 dugačka na gornjoj čeljusti i 4 nešto kraća na donjoj čeljusti. Ima jako dobro razvijenu bočnu prugu tako da može osjetiti i najmanje vibracije mogućeg plijena. Visoko postavljeno oko maleno je što navodi na noćni život. Dugačka analna peraja završava na razini repne peraje od koje je odvojena samo malenim izreskom. Tijelo je sive boje išarano tamnijim mrljama na leđima i bokovima dok je trbuh svjetlije boje.',
  };

  static String getFishDescription(String key) {
    if (breeds.containsKey(key)) {
      return breeds[key]!;
    }
    return '';
  }
}
