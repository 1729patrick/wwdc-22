//
//  Model-SwimmerType.swift
//  Marine Life
//
//  Created by Patrick Battisti Forsthofer on 12/04/22.
//

import Foundation

struct SwimmerType: Identifiable, Hashable, Decodable, Encodable {
    var id: String {
        image
    }
    
    let image: String
    let speed: Double
    let scale: Double
    let description: String
    let conservationStatus: String
    var source: String = "Wikipedia"
    var type = "animal"
    
    static var animals: [SwimmerType] {
        [
            SwimmerType(
                image: "Mustelus schmitti",
                speed: 900,
                scale: 2,
                description: "The narrownose smooth-hound (Mustelus schmitti) is a houndshark of the family Triakidae. It is found on the continental shelves of the subtropical southwest Atlantic, from southern Brazil to northern Argentina, between latitudes 30° S and 44° S, at depths between 60 m to 195 m. It can reach a length of 74 centimeters. Narrownose smooth-hounds feed on crabs and probably other crustaceans, and presumably small fish. Narrownose smooth-hounds are also caught and utilized for human consumption. The reproduction of this houndshark is ovoviviparous, with 2 to 7 pups per litter, and a birth length of about 26 cm.",
                conservationStatus: "CR"
            ),
            SwimmerType(
                image: "Atlantirivulus nudiventris",
                speed: 600,
                scale: 1,
                description: "Atlantirivulus nudiventris is a genus of fish in the family Rivulidae. They are endemic to shallow swamps, creeks, streams and pools in the Atlantic Forest in southeastern Brazil, ranging from Rio de Janeiro to Santa Catarina. Several of the species are highly threatened, while others survive in well-protected reserves. Atlantirivulus nudiventris was initially feared extinct, but has since been rediscovered in two reserves. Similar to closely related genera such as Anablepsoides, Cynodonichthys, Laimosemion and Melanorivulus, Atlantirivulus are non-annual killifish. They are small fish, no more than 6.5 cm (2.6 in) in total length. Compared to many species in the family, the colors of Atlantirivulus are relatively dull.",
                conservationStatus: "CR"
            ),
            SwimmerType(
                image: "Pristis pectinata",
                speed: 900,
                scale: 1.5,
                description: "The smalltooth sawfish (Pristis pectinata) is a species of sawfish in the family Pristidae. It is found in shallow tropical and subtropical waters in coastal and estuarine parts of the Atlantic. Reports from elsewhere are now believed to be misidentifications of other species of sawfish. It is a critically endangered species that has disappeared from much of its historical range. The smalltooth sawfish reputedly reaches a total length of up to 7.6 m (25 ft), but this is likely an exaggeration and the largest confirmed size is 5.54 m (18.2 ft). It weighs up to 350 kg (770 lb).",
                conservationStatus: "CR"
            ),
            SwimmerType(
                image: "Polyprion americanus",
                speed: 600,
                scale: 1,
                description: "The Atlantic wreckfish, (Polyprion americanus), also known as the stone bass or bass grouper, is a marine, bathydemersal, and oceanodromous ray-finned fish in the family Polyprionidae. It has a worldwide, if disjunct, distribution in the Atlantic, Pacific and Indian Oceans. They have also been described as being Wreckfish are bluish grey on the back with a paler silvery sheen on the underside. The fins are blackish brown. The maximum total length is 210 centimetres (6.9 ft) with a maximum published weight of 100 kilograms (220 lb).",
                conservationStatus: "CR"
            ),
            
            SwimmerType(image: "Chelonia mydas",
                       speed: 4000,
                       scale: 1.25,
                       description: "The green sea turtle (Chelonia mydas), also known as the green turtle, black (sea) turtle or Pacific green turtle, is a species of large sea turtle of the family Cheloniidae. It is the only species in the genus Chelonia. Its range extends throughout tropical and subtropical seas around the world, with two distinct populations in the Atlantic and Pacific Oceans, but it is also found in the Indian Ocean. The common name refers to the usually green fat found beneath its carapace, not to the color of its carapace, which is olive to black. ts appearance is that of a typical sea turtle. Chelonia mydas has a dorsoventrally flattened body, a beaked head at the end of a short neck, and paddle-like arms well-adapted for swimming. Adult green turtles grow to 1.5 metres (5 ft) long. The average weight of mature individuals is 68–190 kg (150–419 lb) and the average carapace length is 78–112 cm (31–44 in). Exceptional specimens can weigh 315 kg (694 lb) or even more, with the largest known Chelonia mydas having weighed 395 kg (871 lb) and measured 153 cm (60 in) in carapace length.",
                       conservationStatus: "NT"
                      ),
            SwimmerType(image: "Epinephelus itajara",
                       speed: 600,
                       scale: 1,
                       description: "The Atlantic goliath grouper or itajara (Epinephelus itajara), formerly known as the jewfish, is a saltwater fish of the grouper family and one of the largest species of bony fish. The species can be found in the west ranging from northeastern Florida, south throughout the Gulf of Mexico and the Caribbean Sea, and along South America to Brazil. In the east the species ranges West Africa from Senegal to Cabinda. The species has been observed at depths ranging from 1 to 100 meters (3.28 to 328 feet). The Atlantic goliath grouper can grow to lengths of 2.5 meters (8.2 feet) and weigh up to 363 kilograms (800 pounds). The species ranges in coloration from brownish yellow to grey to greenish and has small black dots on the head, body and fins. Individuals less than 1 meter (3.28 feet) in length have 3 to 4 faint vertical bars present on their sides. The species has an elongate body with a broad, flat head and small eyes. The lower jaw has 3 to 5 rows of teeth with no front canines.",
                       conservationStatus: "CR"
                      ),
            
            SwimmerType(image: "Balaenoptera musculus",
                       speed: 3000,
                       scale: 3,
                       description: "The blue whale (Balaenoptera musculus) is a marine mammal and a baleen whale. Reaching a maximum confirmed length of 29.9 meters (98 ft) and weighing up to 199 metric tons (196 long tons; 219 short tons), it is the largest animal known to have ever existed. The blue whale's long and slender body can be of various shades of greyish-blue dorsally and somewhat lighter underneath. Four subspecies are recognized: Balaenoptera musculus in the North Atlantic and North Pacific, Balaenoptera musculus intermedia in the Southern Ocean, Balaenoptera musculus brevicauda (the pygmy blue whale) in the Indian Ocean and South Pacific Ocean, Balaenoptera musculus indica in the Northern Indian Ocean. There is also a population in the waters off Chile that may constitute a fifth subspecies. In general, blue whale populations migrate between their summer feeding areas near the polars and their winter breeding ground near the tropics. There is also evidence of year-round residencies, and partial or age/sex-based migration. Blue whales are filter feeders; their diet consists almost exclusively of krill. They are generally solitary or gather in small groups and have no well-defined social structure other than mother-calf bonds. The fundamental frequency for blue whale vocalizations ranges from 8 to 25 Hz and the production of vocalizations may vary by region, season, behavior, and time of day. Orcas are their only natural predators.",
                       conservationStatus: "CR"
                      ),
            SwimmerType(image: "Spintherobolus papilliferus",
                       speed: 600,
                       scale: 1,
                       description: "Spintherobolus papilliferus is a genus of characins that are endemic to river basins in southern and southeastern Brazil from Santa Catarina to Rio de Janeiro. All four species in the genus are considered threatened by Brazil's Ministry of the Environment. They are small fish, up to 6.1 cm (2.4 in) in standard length. The eyes of S. papilliferus (18.4-26.0% HL) are the smallest of the four species of Spintherobolus; the caudal peduncle length is the longest, being 23.8-24.6% SL in males and 21.3-27.0% SL in females; the anal-fin rays of adult males are not expanded in a sagittal plane; segments of anal-fin rays of adult males are not fused; an anterior extension of the proximal end of the lepidotrichia of the anal-fin rays of males is absent.",
                       conservationStatus: "EN"
                      ),
            
            SwimmerType(image: "Galeorhinus galeus",
                       speed: 900,
                       scale: 2,
                       description: "The school shark (Galeorhinus galeus) is a houndshark of the family Triakidae, and the only member of the genus Galeorhinus. Common names also include tope shark, snapper shark, and soupfin shark. It is found worldwide in temperate seas at depths down to about 800 m (2,600 ft). It can grow to nearly 2 m (6 ft 7 in) long. It feeds both in midwater and near the seabed, and its reproduction is ovoviviparous. This shark is caught in fisheries for its flesh, its fins, and its liver, which has a very high vitamin A content. The IUCN has classified this species as critically endangered in its Red List of Threatened Species. The school shark is a small, shallow-bodied shark with an elongated snout. The large mouth is crescent-shaped and the teeth are of a similar size and shape in both jaws. They are triangular-shaped, small, and flat, set at an oblique angle facing backwards, serrated and with a notch. The spiracles are small. The first dorsal fin is triangular with a straight leading edge and is set just behind the pectoral fins. The second dorsal fin is about the same size as the anal fin and is set immediately above it. The terminal lobe of the caudal fin has a notch in it and is as long as the rest of the fin. School sharks are dark bluish grey on their upper (dorsal) surfaces and white on their bellies (ventral surface). Juveniles have black markings on their fins. Mature sharks range from 135 to 175 cm (53 to 69 in) for males and 150 to 195 cm (59 to 77 in) for females.",
                       conservationStatus: "CR"
                       
                      ),
            SwimmerType(image: "Austrolebias cinereus",
                       speed: 600,
                       scale: 1,
                       description: "Austrolebias Cineurus species with conservation problems, due to its restricted distribution in the country or because they have a naturally small population or because they have suffered processes of astriction in their distribution or population declines. They are found in places where conditions are more favorable for their survival, or in regions that manage to colonize conditioned by historical events. They have an omnivorous diet. The male 'flinders' around the female, displaying his fins high- up with the most intense colors. As the female is willing to spawn, she follows the male, pressing his head towards the layer of peat, and when the female contact the male's belly, both will dive into the peat layer. This layer should have a thickness of at least the length of the largest animal or, better, some deeper so they can dive entirely into it.  The spawning occurs during the whole fertile life of the fish, starting at 5 to 6 weeks of age, till they become old and weak or die from the lack of water in their natural environment. This 'end-of-life' will be within 8 to 11 months, depending on the temperature. Higher temperatures will trigger more rapid aging. Max. size 6.0 cm. Dorsal 23.5, Anal 25.0, D/A 6, LL scale count (average) 32.0, Pre- dorsal length to % SL – 51.9 %, Depth to % SL – 34.7 %.",
                       conservationStatus: "CR",
                       source: "Austrolebias cinereus, (Amato, 1986)"
                      ),
            
            SwimmerType(image: "Carcharhinus galapagensis",
                       speed: 900,
                       scale: 2,
                       description: "The Galapagos shark (Carcharhinus galapagensis) is a species of requiem shark, in the family Carcharhinidae, found worldwide. It favors clear reef environments around oceanic islands, where it is often the most abundant shark species. A large species that often reaches 3.0 m (9.8 ft), the Galapagos reef shark has a typical fusiform 'reef shark' shape and is very difficult to distinguish from the dusky shark (C. obscurus) and the grey reef shark (C. amblyrhynchos). An identifying character of this species is its tall first dorsal fin, which has a slightly rounded tip and originates over the rear tips of the pectoral fins. The Galapagos shark is an active predator often encountered in large groups. It feeds mainly on bottom-dwelling bony fish and cephalopods; larger individuals have a much more varied diet, consuming other sharks, marine iguanas, sea lions, and even garbage. As in other requiem sharks, reproduction is viviparous, with females bearing litters of 4–16 pups every 2 to 3 years. The juveniles tend to remain in shallow water to avoid predation by the adults. The International Union for Conservation of Nature (IUCN) has assessed this species as least concern, but it has a slow reproductive rate and there is heavy fishing pressure across its range.",
                       conservationStatus: "CR"
                      ),
            SwimmerType(image: "Hypsolebias auratus",
                       speed: 600,
                       scale: 1,
                       description: "Hypsolebias auratus is a genus of small fish in the family Rivulidae that are endemic the Caatinga, Cerrado and nearby regions in Brazil. The greatest richness is in the São Francisco River basin, but there are also species in the Tocantins, Jequitinhonha and Jaguaribe systems, as well as smaller river basins in northeastern Brazil. Like their relatives, Hypsolebias are annual killifish. The short-lived adults inhabit temporary waters like rain pools, laying their eggs in the bottom. As their habitat dries up the adults die, but the eggs survive and hatch when the water returns in the next season. The males are more colorful than the females, and male colors/patterns are a primary way of separating the different species. They are small fish that reach up to 7 cm (2.8 in) in total length.",
                       conservationStatus: "CR"
                      ),
            
            SwimmerType(image: "Carcharhinus isodon",
                       speed: 900,
                       scale: 2,
                       description: "The finetooth shark (Carcharhinus isodon) is a species of requiem shark, in the family Carcharhinidae, found in the western Atlantic Ocean, from North Carolina to Brazil. It forms large schools in shallow, coastal waters, and migrates seasonally following warm water. A relatively small, slender-bodied shark, the finetooth shark can be identified by its needle-like teeth, dark blue-gray dorsal coloration, and long gill slits. It attains a maximum length of 1.9 m (6.2 ft). The diet of this species consists primarily of small bony fish, in particular menhaden. Like other members of its family, it is viviparous with females giving birth to two to six pups in estuarine nursery areas every other year. Valued for its meat, the finetooth shark forms an important component of the commercial gillnet shark fishery operating off the southeastern United States. Population assessments suggest that this fishery does not currently pose a threat to U.S. populations of the species. This shark is not known to pose a danger to humans, though it snaps vigorously when captured and should be handled with caution.",
                       conservationStatus: "DD"
                      ),
            SwimmerType(image: "Leporinus guttatus",
                       speed: 600,
                       scale: 1,
                       description: "Leporinus guttatus is one of the most species-rich genera in the entire order Characiformes, with approximately 90 valid species. Although several species have been described in the last twenty years, recent collection efforts in streams and small tributaries of large river drainages, especially in the Amazon basin, have revealed a still greater number of undescribed species. Fish collections from the Serra do Cachimbo, the highest portion of the Brazilian shield in the Amazon, have revealed a quite rich and endemic fish fauna. The area is drained by three major river basins, the rio Curuá, a large tributary of the rio Iriri in the rio Xingu basin, and the rio Teles Pires and the rio Jamanxim, flowing into the rio Tapajós. The rio Curuá near Vila de Cachoeira da Serra drop off from Serra do Cachimbo tablelands in a series of two great waterfalls of approximately 40 and 60 meters deep, separated only by a 50 meters river stretch, that completely isolate the fish fauna in the areas above the falls.",
                       conservationStatus: "VU",
                       source: "New species of the genus Leporinus Agassiz"
                      ),
            
            SwimmerType(image: "Pontoporia blainvillei",
                       speed: 900,
                       scale: 1.5,
                       description: "The La Plata dolphin, franciscana or toninha (Pontoporia blainvillei) is a species of dolphin found in coastal Atlantic waters of southeastern South America. It is a member of the river dolphin group and the only one that lives in the ocean and saltwater estuaries, rather than inhabiting exclusively freshwater systems. Commercialized areas that create agricultural runoffs and industrialized zones can affect the health of the La Plata dolphin, especially in regards to their contributions of waste and pollution, which can lead to habitat degradation and poisoned food among other concerns. The La Plata dolphin has the longest beak (as a proportion of body size) of any cetacean — as much as 15% in older adults. Males grow to 1.6 metres (5.2 ft) and females to 1.8 metres (5.9 ft). The body is a greyish brown colour, with a lighter underside. The flippers are also very large in comparison with body size and are very broad, but narrow on joining the body, so are almost triangular in shape. The trailing edges are serrated. The crescent-shaped blowhole lies just in front of a crease in the neck, giving the impression that dolphin forever has its head cricked upwards. The dorsal fin has a long base and a rounded tip. The La Plata dolphin has homodont dentition with conical-shaped teeth. The number of teeth ranges from 48 to 61 on each side of its upper and lower jaw.",
                       conservationStatus: "CR"
                      ),
//            SwimmerType(image: "Austrolebias jaegari",  speed: 600,
//                       scale: 1,
//                       description: "A species of fish is Austrolebias jaegari was first described by Costa and Cheffe in 2002. Austrolebias jaegari belongs to the genus Austrolebias, and family Rivulidae. This species is propagated by Brazil. There is no such species listed.",
//                       conservationStatus: "CR"
//                      ),
            
            SwimmerType(image: "Characidium vestigipinne",
                       speed: 600,
                       scale: 1,
                       description: "Roundish black marks on the pelvic, dorsal and anal fins; a black band along the distal margin of anal and pelvic fins; a black band along the distal margin of anal and pelvic fins in adult males (band also present but fainter and narrower in juveniles and females); enlarged anal fin with rounded distal profile in adult males; fins brightly colored with orange or red chromatophores in live adult males; reduction of adipose fin, which may be very small or even absent; lateral line complete or at least extending well beyond the 12th scale of series. Dorsal spines (total): 0; Dorsal soft rays (total): 11-13; Anal spines 0; Soft anal rays: 7 - 9.",
                       conservationStatus: "CR"
                      ),
            SwimmerType(image: "Myliobatis ridens",
                       speed: 1500,
                       scale: 1.25,
                       description: "The shortnose eagle ray (Myliobatis ridens) is a species of eagle ray that lives in the southwestern Atlantic Ocean off Brazil, Uruguay and Argentina. This species is distinguished by the following set of characters: rhombic disc which is wider than long, width about 2.2-times TL; disc length 58%-64% of DW; anterior margin of disc joining head behind orbits; head clearly protruding from disc, eyes in lateral position, moderate in size; snout width equal to interorbital distance (13.6%-16.5% DW), mouth relatively wide, as broad as distance between 5th gill slits (mouth width 0.8-1-times distance between 5th gill slits), mouth width greater than distance between inner ends of nostrils (1.5-1.6- times); distance between 5th gill slits greater than distance between inner ends of nostrils (1.8-1.6-times). Male and female mature at approximately 50.0-60.0 mm DW (Ruocco, unpubl. data), and males are typically smaller than females.",
                       conservationStatus: "CR"
                      ),
            
            SwimmerType(image: "Prochilodus britskii",
                       speed: 600,
                       scale: 1,
                       description: "Prochilodus britskii is a genus of freshwater fish from the family Prochilodontidae. This family include two other genera, Ichthyoelephas and Semaprochilodus, which have been included in Prochilodus instead. The greatest species richness of Prochilodus is in river basins in eastern, southeastern and southern Brazil, but there are also species in the river basins of the Amazon, Guianas, Colombia, Venezuela, Paraguay and northeastern Argentina. The largest species in the genus reach about 80 centimetres (2.6 ft) in length, but most species barely reach half that size.",
                       conservationStatus: "EN"
                      ),
            SwimmerType(image: "Sphyrna lewini",
                       speed: 900,
                       scale: 2,
                       description: "The scalloped hammerhead (Sphyrna lewini) is a species of hammerhead shark in the family Sphyrnidae. It was originally known as Zygaena lewini. The Greek word sphyrna translates into 'hammer' in English, referring to the shape of this shark's head, which is its most distinguishing characteristic. The shark's eyes and nostrils are at the tips of the extensions. It is a fairly large hammerhead, but is still smaller than both the great and smooth hammerheads. This shark is also known as the bronze, kinky-headed, or southern hammerhead. It primarily lives in warm, temperate, and tropical coastal waters all around the globe between latitudes 46°N and 36°S, down to a depth of 500 m (1,600 ft). It is the most common of all hammerheads. Typically, males measure 1.5 to 1.8 m (4.9 to 5.9 ft) and weigh about 29 kg (64 lb) when they attain sexual maturity, whereas the larger females measure 2.5 m (8.2 ft) and weigh 80 kg (180 lb) at sexual maturity. The maximum length of the scalloped hammerhead is 4.3 m (14 ft) and the maximum weight is 152.4 kg (336 lb), per FishBase. A female caught off of Miami was found to have measured 3.26 m (10.7 ft) and reportedly weighed 200 kg (440 lb), though was in a gravid state then.",
                       conservationStatus: "CR"
                      ),
            
            SwimmerType(image: "Schroederichthys bivius",
                       speed: 600,
                       scale: 1,
                       description: "The narrowmouthed catshark (Schroederichthys bivius) is a catshark of the family Scyliorhinidae, found from central Chile around the Straits of Magellan, to Argentina between latitudes 23° S and 56° S, at depths down to about 180 m (600 ft) in the Atlantic Ocean and about 360 m (1,200 ft) in the Pacific. It can grow to a length of up to 70 cm (28 in). The reproduction of this catshark is oviparous. As a juvenile, the narrowmouthed catshark is elongated and very slender, but as it grows its proportions change and it becomes rather more thickset. Its adult length can reach 70 cm (28 in) or more. The snout is rounded and slender and the front nasal flaps are narrow and lobed. This fish displays heterodont dentition; the mouth is long in both sexes, but is longer and narrower in males, with teeth that are twice the height of those of females. The general colour of the dorsal surface of both sexes is greyish-brown, with seven or eight dark brown saddles. Some large dark spots are scattered along the body but do not occur on the saddles. There are also many small white spots on the upper half of the body.",
                       conservationStatus: "LC"
                      ),
            SwimmerType(image: "Cetorhinus maximus",
                       speed: 900,
                       scale: 2,
                       description: "The basking shark (Cetorhinus maximus) is the second-largest living shark and fish, after the whale shark, and one of three plankton-eating shark species, along with the whale shark and megamouth shark. Adults typically reach 7.9 m (26 ft) in length. It is usually greyish-brown, with mottled skin. The caudal fin has a strong lateral keel and a crescent shape. The basking shark is a cosmopolitan migratory species, found in all the world's temperate oceans. A slow-moving filter feeder, its common name derives from its habit of feeding at the surface, appearing to be basking in the warmer water there. It has anatomical adaptations for filter-feeding, such as a greatly enlarged mouth and highly developed gill rakers. Its snout is conical and the gill slits extend around the top and bottom of its head. The gill rakers, dark and bristle-like, are used to catch plankton as water filters through the mouth and over the gills. The teeth are numerous and very small, and often number 100 per row. The teeth have a single conical cusp, are curved backwards and are the same on both the upper and lower jaws. This species has the smallest weight-for-weight brain size of any shark, reflecting its relatively passive lifestyle. The basking shark is a coastal-pelagic shark found worldwide in boreal to warm-temperate waters. It lives around the continental shelf and occasionally enters brackish waters. It is found from the surface down to at least 910 m (2,990 ft). It prefers temperatures of 8 to 14.5 °C (46.4 to 58.1 °F), but has been confirmed to cross the much-warmer waters at the equator. It is often seen close to land, including in bays with narrow openings. The shark follows plankton concentrations in the water column, so is often visible at the surface. It characteristically migrates with the seasons.",
                       conservationStatus: "CR"
                      ),
            //            SwimmerType(image: "Baryancistrus longipinnis",
            //                       speed: 600,
            //                       scale: 1,
            //                       description: "",
            //                       conservationStatus: "CR"
            //                      ),
            
            
            SwimmerType(image: "Brycon red",
                       speed: 600,
                       scale: 1,
                       description: "Readily distinguishable in life from all other species of the genus in eastern Brazilian coastal rivers by the unique brightly red colored dorsal, adipose, caudal and anal fins. Differs from all other species of eastern coastal Brazilian Brycon by having the fifth infraorbital bone longer than wide and a great maximum body depth (31.7-37.5% SL). Differs from B. ferox, the only other member of the genus occurring in the Rio Mucuri, by having 11 or 12 scales between lateral line and the dorsal fin, and by a different color pattern. The coloration of this species is unique among the Bryconidae of the eastern basins, with its dorsal, adipose, caudal and anal fins having a dark red tone in life. It also differs in terms of the fifth infraorbital bone, which is longer than wide, and in terms of great height (31.7 to 37.5% in standard length).",
                       conservationStatus: "EN"
                      )
            //            SwimmerType(image: "Odontesthes bicudo",
            //                       speed: 600,
            //                       scale: 1,
            //                       description: "",
            //                       conservationStatus: "EN"
            //                      )
        ]
    }
    
    static var trashes: [SwimmerType] {
        [
            SwimmerType(
                image: "Bottle1",
                speed: 1600,
                scale: 0.75,
                description: "",
                conservationStatus: "",
                type: "trash"
            ),
            SwimmerType(
                image: "Cigarette",
                speed: 1600,
                scale: 0.4,
                description: "",
                conservationStatus: "",
                type: "trash"
            ),
            SwimmerType(
                image: "Bottle2",
                speed: 1600,
                scale: 0.75,
                description: "",
                conservationStatus: "",
                type: "trash"
            ),
            SwimmerType(
                image: "Bottle3",
                speed: 1600,
                scale: 0.75,
                description: "",
                conservationStatus: "",
                type: "trash"
            ),
            SwimmerType(
                image: "Cup",
                speed: 1600,
                scale: 0.4,
                description: "",
                conservationStatus: "",
                type: "trash"
            )
        ]
    }
}

