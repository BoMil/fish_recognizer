class FishBreeds {
  static Map<String, String> breeds = {
    'Babuska (Carassius gibelio)':
        'Babuška (lat. Carassius gibelio pre 2003. godine lat. Carassius auratus gibelio) je slatkovodna riba veoma prilagodljive prirode. Pripada porodici šarana. Poreklom je iz Azije, odnosno Sibira. U našim rekama i jezerima se prvi put pojavila početkom osamdesetih godina 20. veka, a donesena je iz Kine. \n \n Babuška izgledom podseća na karaša (Carassius carassius), dostiže dužinu od 10 − 35 cm. Krljušti su joj veće od krljušti karaša, po pravilu ima 27 − 32 krljušti duž lateralne linije, dok karaš ima 31 − 35. Srebrnkaste je boje, ponekad sa blagim zlatnim tonom. Babuškin rep je račvastiji u odnosu na karašev. Ima debelo telo, najčešće je srebrne boje i nema brčiće poput običnog šarana. \n \nBabuška po svojim karakteristikama pripada porodici šarana srednje veličine i uglavnom ne prelazi težinu od 3 Kg i dužinu od 45 centimetara.',
    'Saran (Cyprinus carpio)':
        'Šaran (Cyprinus carpio) riba je slatkovodna riba sa koštanim skeletom košljoribe i istovremeno pripada i mekoperkama i porodici šarana. Naziva se još i krap, krmača, dunavski lisac. Šaran živi u mirnim i toplijim vodama i može da dostigne dužinu od jednog metra i masu i preko 20 kg. Ima izduženo, oblo telo i krupnu glavu na kojoj su usta okružena sa četiri izraštaja u vidu brkova. Može se obrazovati i izraštaj u obliku cevi kojom šaran usisava hranu sa rečnog dna. Ima par grudnih i par trbušnih peraja i jedno podrepno, repno i leđno koje počinje oštrom žbicom. Leđna strana tela je različito obojena u zavisnosti od staništa na kome živi, dok je trbušna uglavnom svetlija. Karakterističan je po svojim visokim masivnim leđima i relativno maloj glavi.',
    'Som (Silurus glanis)':
        'Som (Silurus glanis) edna je od najvećih slatkovodnih riba, a pripada familiji Somovi (Siluridae). Jedinke ove vrste mogu da narastu do preko 3 m i dostignu maksimalnu masu od preko 200 kg. Som se mresti od maja do jula. Som se dosta razlikuje od riba klasične forme, trup mu je ovalan, sa velikom i spljoštenom glavom na kojoj je tri para brkova od kojih je gornjovilični par dug do vrha grudnih peraja, ostali su dosta manji. Ima sitne oči, velika usta, a donja vilica mu je nešto duža od gornje, i obe su načičkane mnoštvom sitnih zuba. Telo mu je bez krljušt i veoma sluzava. Podrepno peraje dugačko, a repno je zaobljeno, leđno peraje je malo i bez tvrdih žilica. Leđa soma su modrocrna, bokovi su tamnosmeđi ili tamnozelenkasti i mramorirani, a trbuh sivkastobeličaste boje sa crvenkastim prelivima.',
  };

  static String getFishDescription(String key) {
    if (breeds.containsKey(key)) {
      return breeds[key]!;
    }
    return '';
  }
}
