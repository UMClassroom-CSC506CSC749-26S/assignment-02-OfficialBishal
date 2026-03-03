% Food chains describe the feeding relationships between species in a biotic community. They show the transfer of material and energy from one species to another within an ecosystem. If one species eats another, there is an food link from the eaten of the food link to the eater of the foodlink. Apex predators are those species that are not eaten by any species. Primary producers (also known as autotrophs) are those species that do not eat any species - they are capable of producing complex organic substances (essentially "food") from an energy source and inorganic materials. A sequence of food links from a species to a species to a species, etc, forms a food chain that starts at the eaten of the first link and ends at the eaten of the last link. A complete food chain starts at a primary producer and ends at an apex predator. An apex predator is dependent on all the species in all the food chains that lead to the apex.

% The food chain environment can be modeled in typed first order logic, and various theorems can then be proved. Here the axioms of the system are given in English, interspersed with theorems that can be proved from the preceding axioms.

% Axiom: The eater of a food link eats the eaten of the link.
% Axiom: The eaten and eater of a food link are not the same (no cannibalism).
% Axiom: Every species eats something or is eaten by something (or both).
% Axiom: Something is a primary producer iff it eats no other species.
% Theorem: If something is a primary producer then there is no food link such that the primary producer is the eater of the food link.
% Theorem: Every primary producer is eaten by some other species.
% Theorem: If a species is not a primary producer then there is another species that it eats.
% Axiom: Something is an apex predator iff there is no species that eats it.
% Theorem: If something is an apex predator then there is no food link such that the apex predator is the eaten of the food link.
% Theorem: Every apex predator eats some other species.
% Theorem: If a species is not a apex predator then there is another species that eats it.
% Axiom: For every food chain, the start of the chain is the eaten of some food link, and one of the following holds: (i) the eater of the food link is the end of the food chain, xor (ii) there is a shorter food chain (shorter by one food link) from the eater of the food link to the end of the whole food chain.
% Axiom: There is no food chain from a species back to itself (no death spirals).
% Axiom: A complete food chain starts at a primary producer, and ends at an apex predator.
% Axiom: Every species is in some complete food chain, i.e., (i) the species is the primary producer start of the complete food chain, or (ii) the species is the apex predator at the end of the complete food chain, or (iii) there is a non-complete food chain from the start of the complete food chain to the species, and another non-complete food chain from the species to the end of the complete food chain.
% Theorem: The start species of a complete food chain does not eat the end species.
% Theorem: If a species is neither a primary producer nor an apex predator, then there is a food chain from a primary producer to that species, and another food chain from that species to an apex predator.
% Axiom: Given two species, the first depends on the second iff there is a food chain from the second to the first.
% Theorem: If a species is not an apex predator then there is an apex predator that depends on the species.
% Theorem: An apex predator depends on all primary producers of all complete food chains that end at the apex predator.


% Types

tff(species_type,type,
    species: $tType ).

tff(primary_producer_decl,type,
    primary_producer: species > $o ).

tff(apex_predator_decl,type,
    apex_predator: species > $o ).

tff(foodlink_type,type,
    foodlink: $tType ).

tff(eats_decl,type,
    eats: ( species * species ) > $o ).

tff(eater_decl,type,
    eater: foodlink > species ).

tff(eaten_decl,type,
    eaten: foodlink > species ).

tff(foodchain_type,type,
    foodchain: $tType ).

tff(start_of_decl,type,
    start_of: foodchain > species ).

tff(end_of_decl,type,
    end_of: foodchain > species ).

tff(complete_foodchain_decl,type,
    complete_foodchain: foodchain > $o ).

tff(depends_decl,type,
    depends: ( species * species ) > $o ).


% Axioms and Conjectures

% Axiom: The eater of a food link eats the eaten of the link.
tff(eater_eats_eaten,axiom,
    ! [L: foodlink] : eats(eater(L),eaten(L)) ).

% Axiom: The eaten and eater of a food link are not the same (no cannibalism).
tff(no_cannibalism,axiom,
    ( ! [L: foodlink] : ( eater(L) != eaten(L) ) ) ).

% Axiom: Every species eats something or is eaten by something (or both).
tff(eater_or_eaten,axiom,
    ! [S: species] :
      ( ? [S2: species] : eats(S,S2)
      | ? [S2: species] : eats(S2,S) ) ).

% Axiom: Something is a primary producer iff it eats no other species.
tff(primary_producer_defn,axiom,
    ! [S: species] :
      ( primary_producer(S)
    <=> ~ ? [S2: species] : eats(S,S2) ) ).

% Theorem: If something is a primary producer then there is no food link such that the primary producer is the eater of the food link.
tff(primary_producer_not_eater,conjecture,
    ! [S: species] :
      ( primary_producer(S)
     => ~ ? [L: foodlink] : ( eater(L) = S ) ) ).

% Theorem: Every primary producer is eaten by some other species.
tff(primary_producer_eaten,conjecture,
    ! [S: species] :
      ( primary_producer(S)
     => ? [S2: species] :
          ( eats(S2,S) ) ) ).

% Theorem: If a species is not a primary producer then there is another species that it eats.
tff(non_primary_producer_eats,conjecture,
    ! [S: species] :
      ( ~ primary_producer(S)
     => ? [S2: species] :
          ( eats(S,S2) ) ) ).

% Axiom: Something is an apex predator iff there is no species that eats it.
tff(apex_predator_defn,axiom,
    ! [S: species] :
      ( apex_predator(S)
    <=> ~ ? [S2: species] : eats(S2,S) ) ).

% Theorem: If something is an apex predator then there is no food link such that the apex predator is the eaten of the food link.
tff(apex_predator_not_eaten,conjecture,
    ! [S: species] :
      ( apex_predator(S)
     => ~ ? [L: foodlink] : ( eaten(L) = S ) ) ).

% Theorem: Every apex predator eats some other species.
tff(apex_predator_eats,conjecture,
    ! [S: species] :
      ( apex_predator(S)
     => ? [S2: species] :
          ( eats(S,S2) ) ) ).

% Theorem: If a species is not a apex predator then there is another species that eats it.
tff(non_apex_predator_eaten,conjecture,
    ! [S: species] :
      ( ~ apex_predator(S)
     => ? [S2: species] :
          ( eats(S2,S) ) ) ).

% Axiom: For every food chain, the start of the chain is the eaten of some food link, and one of the following holds: (i) the eater of the food link is the end of the food chain, xor (ii) there is a shorter food chain (shorter by one food link) from the eater of the food link to the end of the whole food chain.
tff(foodchain_defn,axiom,
    ! [C: foodchain] :
    ? [L: foodlink] :
      ( ( start_of(C) = eaten(L) )
      & ( ( end_of(C) = eater(L) )
      <~> ? [C2: foodchain] :
            ( ( start_of(C2) = eater(L) )
            & ( end_of(C2) = end_of(C) ) ) ) ) ).

% Axiom: There is no food chain from a species back to itself (no death spirals).
tff(no_death_spirals,axiom,
    ![S:species] :
       ~ ? [C: foodchain] : ( S = start_of(C) & S = end_of(C) ) ).

% Axiom: A complete food chain starts at a primary producer, and ends at an apex predator.
tff(complete_foodchain_defn,axiom,
    ! [C: foodchain] :
      ( complete_foodchain(C)
    <=> ( primary_producer(start_of(C))
        & apex_predator(end_of(C)) ) ) ).

% Axiom: Every species is in some complete food chain, i.e., (i) the species is the primary producer start of the complete food chain, or (ii) the species is the apex predator at the end of the complete food chain, or (iii) there is a non-complete food chain from the start of the complete food chain to the species, and another non-complete food chain from the species to the end of the complete food chain.
tff(every_species_in_complete_chain,axiom,
    ! [S: species] :
    ? [C: foodchain] :
      ( complete_foodchain(C)
      & ( ( S = start_of(C) )
        | ( S = end_of(C) )
        | ? [C1: foodchain,C2: foodchain] :
            ( ( start_of(C1) = start_of(C) )
            & ( end_of(C1) = S )
            & ( start_of(C2) = S )
            & ( end_of(C2) = end_of(C) )
            & ~ complete_foodchain(C1)
            & ~ complete_foodchain(C2) ) ) ) ).

% Theorem: The start species of a complete food chain does not eat the end species.
tff(complete_chain_start_does_not_eat_end,conjecture,
    ! [C: foodchain] :
      ( complete_foodchain(C)
     => ~ eats(start_of(C),end_of(C)) ) ).

% Theorem: If a species is neither a primary producer nor an apex predator, then there is a food chain from a primary producer to that species, and another food chain from that species to an apex predator.
tff(middle_species_chains,conjecture,
    ! [S: species] :
      ( ( ~ primary_producer(S)
        & ~ apex_predator(S) )
     => ? [C1: foodchain,C2: foodchain] :
          ( primary_producer(start_of(C1))
          & ( end_of(C1) = S )
          & ( start_of(C2) = S )
          & apex_predator(end_of(C2)) ) ) ).

% Axiom: Given two species, the first depends on the second iff there is a food chain from the second to the first.
tff(depends_defn,axiom,
    ! [S1: species,S2: species] :
      ( depends(S1,S2)
    <=> ? [C: foodchain] :
          ( ( start_of(C) = S2 )
          & ( end_of(C) = S1 ) ) ) ).

% Theorem: If a species is not an apex predator then there is an apex predator that depends on the species.
tff(non_apex_predator_has_dependent,conjecture,
    ! [S: species] :
      ( ~ apex_predator(S)
     => ? [S_apex: species] :
          ( apex_predator(S_apex)
          & depends(S_apex,S) ) ) ).

% Theorem: An apex predator depends on all primary producers of all complete food chains that end at the apex predator.
tff(apex_predator_depends_on_producers,conjecture,
    ! [S_apex: species, S_prod: species] :
      ( (apex_predator(S_apex) & primary_producer(S_prod))
      => ( ( ? [C: foodchain] :
                ( complete_foodchain(C)
                & ( end_of(C) = S_apex )
                & ( start_of(C) = S_prod )
                ) )
          => depends(S_apex,S_prod) ) ) ).
