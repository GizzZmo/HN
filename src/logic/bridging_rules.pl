% harmonia_nexus/src/logic/bridging_rules.pl

% --- Facts (Conceptual Database of Echoes and their properties) ---
% echo(EchoID, CoreFeeling, ContextTagsList).
echo('e001', 'Sorrow', ['loss', 'agriculture', 'rural']).
echo('e002', 'Sorrow', ['loss', 'urban', 'economic']).
echo('e003', 'Joy', ['family', 'education', 'achievement']).
echo('e004', 'Joy', ['community', 'resilience', 'rebuilding']).
echo('e005', 'Fear', ['uncertainty', 'future', 'global']).
echo('e006', 'Fear', ['trauma', 'conflict', 'personal']).
echo('e007', 'Injustice', ['discrimination', 'social', 'minority']).
echo('e008', 'Injustice', ['corruption', 'political', 'developing_nation']).
echo('e009', 'Hope', ['innovation', 'technology', 'youth']).
echo('e010', 'Hope', ['spiritual', 'ancient_wisdom', 'tradition']).

% context_type(Tag, Type).
% Classify context tags into broader categories for bridging logic.
context_type(agriculture, 'Economic').
context_type(rural, 'Geographic').
context_type(urban, 'Geographic').
context_type(economic, 'Economic').
context_type(family, 'Social').
context_type(education, 'Social').
context_type(achievement, 'Personal').
context_type(community, 'Social').
context_type(resilience, 'Personal').
context_type(rebuilding, 'Social').
context_type(uncertainty, 'Existential').
context_type(future, 'Temporal').
context_type(global, 'Scope').
context_type(trauma, 'Personal').
context_type(conflict, 'Social').
context_type(personal, 'Personal').
context_type(discrimination, 'Social').
context_type(social, 'Social').
context_type(minority, 'Group').
context_type(corruption, 'Political').
context_type(political, 'Political').
context_type(developing_nation, 'Geopolitical').
context_type(innovation, 'Progress').
context_type(technology, 'Progress').
context_type(youth, 'Demographic').
context_type(spiritual, 'Belief').
context_type(ancient_wisdom, 'Belief').
context_type(tradition, 'Belief').

% --- Rules for Bridging Perspectives ---

% has_context_type(EchoID, Type)
% An Echo has a given context type if any of its tags belong to that type.
has_context_type(EchoID, Type) :-
    echo(EchoID, _, Tags),
    member(Tag, Tags),
    context_type(Tag, Type).

% shares_core_feeling(EchoID1, EchoID2, Feeling)
% Two echoes share a core feeling.
shares_core_feeling(EchoID1, EchoID2, Feeling) :-
    echo(EchoID1, Feeling, _),
    echo(EchoID2, Feeling, _),
    EchoID1 \= EchoID2. % Ensure they are different echoes

% are_contextually_diverse(EchoID1, EchoID2)
% Two echoes are contextually diverse if they have at least one different context type.
% This is a simplified rule; a real system would be more complex.
are_contextually_diverse(EchoID1, EchoID2) :-
    has_context_type(EchoID1, Type1),
    has_context_type(EchoID2, Type2),
    Type1 \= Type2. % They come from different broad contextual categories.

% suggests_bridging_path(PathID, EchoID1, EchoID2, SharedFeeling)
% A rule to identify a strong candidate for a "perspective bridging" path.
% This path is suggested if:
% 1. The two echoes share a core feeling.
% 2. They come from significantly diverse contexts.
% 3. The shared feeling is one that often drives conflict or misunderstanding (e.g., 'Injustice', 'Fear', 'Sorrow').
suggests_bridging_path(PathID, EchoID1, EchoID2, SharedFeeling) :-
    shares_core_feeling(EchoID1, EchoID2, SharedFeeling),
    are_contextually_diverse(EchoID1, EchoID2),
    member(SharedFeeling, ['Injustice', 'Fear', 'Sorrow', 'Hope']), % Feelings that can be divisive or unifying
    format(atom(PathID), 'bridge_~w_~w', [EchoID1, EchoID2]). % Generate a unique path ID

% Example Queries:
% ?- suggests_bridging_path(Path, EchoA, EchoB, Feeling).
% Finds pairs of echoes that would make good bridging paths.

% ?- has_context_type('e007', 'Social').
% Checks if echo e007 is related to a 'Social' context.

% ?- shares_core_feeling('e001', 'e002', 'Sorrow').
% Checks if e001 and e002 share 'Sorrow'.
Learn more about New+ by visiting https://aka.ms/PowerToysOverview_NewPlus