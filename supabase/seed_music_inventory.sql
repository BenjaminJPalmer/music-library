-- Music Inventory seed — 172 unique pieces from 'Music Inventory.xlsx'
-- Composer/publisher names de-duplicated to canonical forms.
-- Duplicate rows collapsed on (composer, title, publisher, category). Run AFTER migration 002. Run ONCE.
begin;

insert into composers (name) values
  ('ABBA'),
  ('Adele'),
  ('Altès, H.'),
  ('Andersen, J.'),
  ('Arnold, M.'),
  ('Bach, J.S.'),
  ('Baemann'),
  ('Barber, S.'),
  ('Beethoven, L.'),
  ('Berkley, L.'),
  ('Berlioz'),
  ('Bernstein, L.'),
  ('Bizet-Borne arr. McLearnon'),
  ('Bolling, C.'),
  ('Borne, F.'),
  ('Boublil & Schönberg'),
  ('Bowen, Y.'),
  ('Bozza, E.'),
  ('Brahms'),
  ('Bridge, F.'),
  ('Britten, B.'),
  ('Chopin'),
  ('Clarke, I.'),
  ('Crusell, B.'),
  ('Curry, J.'),
  ('Debussy, C.'),
  ('Doppler, F.'),
  ('Dukas, P.'),
  ('Faure'),
  ('Ferrous, P.O.'),
  ('Filas, T.'),
  ('Finzi, G.'),
  ('Fitkin, G.'),
  ('Gershwin, G.'),
  ('Giampieri'),
  ('Goddard, B.'),
  ('Grieg, E.'),
  ('Grovlez, G.'),
  ('Handel, G.'),
  ('Harris, C.'),
  ('Harris, P.'),
  ('Harty, H.'),
  ('Harvey, P.'),
  ('Has, S.'),
  ('Heumann, H-G.'),
  ('Hindemith, P.'),
  ('Honegger, A.'),
  ('Horovitz, J.'),
  ('Hurwitz, J.'),
  ('Ibert, J.'),
  ('Ireland, J.'),
  ('Jacob, G.'),
  ('Kapustin, N.'),
  ('Karg-Elert, S.'),
  ('Kovacs, B.'),
  ('Larson, J.'),
  ('Lawrance, P.'),
  ('Ledbury, O.'),
  ('Legrand, M.'),
  ('Lindberg, M.'),
  ('Lloyd Webber, A.'),
  ('Lutoslawski, W.'),
  ('Martinu, B.'),
  ('Mendelssohn'),
  ('Messiaen, O.'),
  ('Milhaud, D.'),
  ('Milton, S.'),
  ('Misc.'),
  ('Mitchell, I.'),
  ('Mozart, W.A.'),
  ('Navarro, O.'),
  ('Nielsem C.'),
  ('Nystedt, K.'),
  ('Panufnik'),
  ('Poulenc, F.'),
  ('Prokofieff, S.'),
  ('Quantz, J.'),
  ('Reade, P.'),
  ('Reinecke, C.'),
  ('Reynolds, J.'),
  ('Rimsky-Korsakov, N.'),
  ('Rogers & Hammerstein'),
  ('Rose, C.'),
  ('Rossini, G.'),
  ('Rota, Nino'),
  ('Rutter, J.'),
  ('Saint-Saëns'),
  ('Schubert'),
  ('Schumann, R.'),
  ('Sherman, R.'),
  ('Spohr'),
  ('Stainer, J.'),
  ('Stanford, C.'),
  ('Sutermeister'),
  ('Tchaikovsky, P.'),
  ('Telemann, G.'),
  ('Uhl, A.'),
  ('Vaughan Williams, R.'),
  ('Voxman, H.'),
  ('Watts, S.'),
  ('Weber, C.M.'),
  ('Wedgwood, P.'),
  ('Weiner, L.'),
  ('Widmann'),
  ('Widor'),
  ('Wye, T.')
on conflict (name) do nothing;

insert into publishers (name) values
  ('A-RAM'),
  ('ABRSM'),
  ('Alfred'),
  ('Alphonse Leduc'),
  ('Associated Music Publishers, Inc.'),
  ('Augener Ltd.'),
  ('Boosey & Hawkes'),
  ('Bosworth'),
  ('Brass Wind Publications'),
  ('Breitkopf'),
  ('Bärenreiter'),
  ('C.F. Peters'),
  ('Camera Flauto Amadeus'),
  ('Carl Fischer'),
  ('Casio'),
  ('Chapell & Co.'),
  ('Chester Music'),
  ('Darok'),
  ('Durand'),
  ('EC'),
  ('EMB'),
  ('EMI'),
  ('Emerson'),
  ('Eulenburg'),
  ('Faber Music'),
  ('Fenette Music'),
  ('G. Schirmer, Inc.'),
  ('Gareth McLearnon'),
  ('Goodmusic Publishing'),
  ('H. Freeman & Co.'),
  ('Hal Leonard'),
  ('Heinrich Germer'),
  ('Henle Verlag'),
  ('Heugel & Co'),
  ('Hinrichsen'),
  ('Hunt'),
  ('I C Music'),
  ('International Music Company'),
  ('Kalmus'),
  ('Keith Prowse & Co.'),
  ('Lemanick'),
  ('Neil A. Kjos'),
  ('New World Publishers'),
  ('Novello'),
  ('Orina Publications'),
  ('Oxford University Press'),
  ('PWM'),
  ('RUG Limited'),
  ('Ricordi'),
  ('Rubank'),
  ('Ruddall Carter'),
  ('Salabert'),
  ('Schott'),
  ('Silhouette Music Corp'),
  ('Stainer & Bell'),
  ('Thames Publishing'),
  ('Universal'),
  ('Universal Music Publishing'),
  ('W. Bessel & Co'),
  ('Warren & Phillips'),
  ('Whirl Wind Press'),
  ('Wiener Urtext'),
  ('Williamson Music'),
  ('Wise Publications')
on conflict (name) do nothing;

insert into instruments (name) values
  ('Bass Clarinet'),
  ('Cello'),
  ('Clarinet'),
  ('Euphonium'),
  ('Flute'),
  ('Horn'),
  ('Orchestra'),
  ('Piano'),
  ('Trumpet'),
  ('Viola'),
  ('Violin'),
  ('Voice')
on conflict (name) do nothing;

with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Twenty-Six Selected Studies for the Flute', (select id from composers where name='Altès, H.'), (select id from publishers where name='G. Schirmer, Inc.'), null, 'Solo Flute') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('24 Studies for Flute Solo', (select id from composers where name='Andersen, J.'), (select id from publishers where name='International Music Company'), null, 'Solo Flute') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Partita for Solo Flute', (select id from composers where name='Bach, J.S.'), (select id from publishers where name='Wiener Urtext'), null, 'Solo Flute') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Image pour Flute Seule', (select id from composers where name='Bozza, E.'), (select id from publishers where name='Alphonse Leduc'), null, 'Solo Flute') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('The Great Train Race', (select id from composers where name='Clarke, I.'), (select id from publishers where name='I C Music'), null, 'Solo Flute') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Syrinx for Solo Flute', (select id from composers where name='Debussy, C.'), (select id from publishers where name='Henle Verlag'), null, 'Solo Flute') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Trois Pièces pour Flûte', (select id from composers where name='Ferrous, P.O.'), (select id from publishers where name='Salabert'), null, 'Solo Flute') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Top Register Studies for Flute', (select id from composers where name='Filas, T.'), (select id from publishers where name='Carl Fischer'), null, 'Solo Flute') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Acht Stücke', (select id from composers where name='Hindemith, P.'), (select id from publishers where name='Schott'), null, 'Solo Flute') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Danse de la Chèvre', (select id from composers where name='Honegger, A.'), (select id from publishers where name='Salabert'), null, 'Solo Flute') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Pièce pour flûte seule', (select id from composers where name='Ibert, J.'), (select id from publishers where name='Alphonse Leduc'), null, 'Solo Flute') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Sonata Appassionata for Solo Flute', (select id from composers where name='Karg-Elert, S.'), (select id from publishers where name='Whirl Wind Press'), null, 'Solo Flute') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Test Pieces for Orchestral Auditions', (select id from composers where name='Misc.'), (select id from publishers where name='C.F. Peters'), null, 'Solo Flute') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Twelve Fantasias for Flute Without Bass', (select id from composers where name='Telemann, G.'), (select id from publishers where name='Bärenreiter'), null, 'Solo Flute') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Practice Book for the Flute: Books 1-6', (select id from composers where name='Wye, T.'), (select id from publishers where name='Novello'), null, 'Solo Flute') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('ABBA Gold: Greatest Hits', (select id from composers where name='ABBA'), (select id from publishers where name='Wise Publications'), null, 'Popular Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Skyfall', (select id from composers where name='Adele'), (select id from publishers where name='Universal Music Publishing'), null, 'Popular Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Les Misérables: Piano/Vocal Selections', (select id from composers where name='Boublil & Schönberg'), (select id from publishers where name='Wise Publications'), null, 'Popular Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Rock Christmas', (select id from composers where name='Heumann, H-G.'), (select id from publishers where name='Bosworth'), null, 'Popular Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('La La Land: Music from the Motion Picture Soundtrack', (select id from composers where name='Hurwitz, J.'), (select id from publishers where name='Faber Music'), null, 'Popular Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('The Music of Michel Legrand', (select id from composers where name='Legrand, M.'), null, null, 'Popular Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('The Phantom of the Opera: Piano Vocal Selection', (select id from composers where name='Lloyd Webber, A.'), (select id from publishers where name='RUG Limited'), null, 'Popular Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('50 West End Songs', (select id from composers where name='Misc.'), (select id from publishers where name='Hal Leonard'), null, 'Popular Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Christmas Revisited', (select id from composers where name='Misc.'), (select id from publishers where name='Faber Music'), null, 'Popular Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Overture (Suite) No.2', (select id from composers where name='Bach, J.S.'), (select id from publishers where name='Hinrichsen'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Sonatas Nos. 1-3', (select id from composers where name='Bach, J.S.'), (select id from publishers where name='C.F. Peters'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Sonatas Nos. 4-6', (select id from composers where name='Bach, J.S.'), (select id from publishers where name='C.F. Peters'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Sonata No.2 in Eb major', (select id from composers where name='Bach, J.S.'), (select id from publishers where name='C.F. Peters'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Sonata for Flute and Piano', (select id from composers where name='Berkley, L.'), (select id from publishers where name='Chester Music'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Suite for Flute and Jazz Piano', (select id from composers where name='Bolling, C.'), (select id from publishers where name='Silhouette Music Corp'), 'FLUTE PART ONLY', 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Carmen Fantasy', (select id from composers where name='Borne, F.'), (select id from publishers where name='Camera Flauto Amadeus'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Flute Sonata Op.120', (select id from composers where name='Bowen, Y.'), null, null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Hungarian Pastoral Fantasy', (select id from composers where name='Doppler, F.'), (select id from publishers where name='Chester Music'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Fantasie for Flute and Piano', (select id from composers where name='Faure'), (select id from publishers where name='Chester Music'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Suite de Trois Morceaux', (select id from composers where name='Goddard, B.'), (select id from publishers where name='Chester Music'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('In Ireland for Flute and Piano', (select id from composers where name='Harty, H.'), (select id from publishers where name='Boosey & Hawkes'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Sonata for Flute and Piano', (select id from composers where name='Hindemith, P.'), (select id from publishers where name='Schott'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Concerto for Flute and Orchestra', (select id from composers where name='Ibert, J.'), (select id from publishers where name='Alphonse Leduc'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('First Sonata for Flute and Piano', (select id from composers where name='Martinu, B.'), (select id from publishers where name='Associated Music Publishers, Inc.'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Flute Music by French Composers', (select id from composers where name='Misc.'), (select id from publishers where name='G. Schirmer, Inc.'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('The Magic Flute of James Galway', (select id from composers where name='Misc.'), (select id from publishers where name='Novello'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Andante in C Major', (select id from composers where name='Mozart, W.A.'), (select id from publishers where name='Ruddall Carter'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Concerto No.1 in G Major', (select id from composers where name='Mozart, W.A.'), (select id from publishers where name='C.F. Peters'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Concerto No.1 in G Major', (select id from composers where name='Mozart, W.A.'), (select id from publishers where name='Ruddall Carter'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Concerto No.2 in D Major', (select id from composers where name='Mozart, W.A.'), (select id from publishers where name='Kalmus'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Rondo in D for Flute and Piano', (select id from composers where name='Mozart, W.A.'), (select id from publishers where name='Universal'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Concerto for Flute and Orchestra', (select id from composers where name='Nielsem C.'), null, null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Sonata for Flute and Piano', (select id from composers where name='Poulenc, F.'), (select id from publishers where name='Chester Music'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Sonata No.2, Op.94', (select id from composers where name='Prokofieff, S.'), (select id from publishers where name='Boosey & Hawkes'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Concerto for Flute, Strings and Basso Continuo', (select id from composers where name='Quantz, J.'), (select id from publishers where name='Breitkopf'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Undine Sonata', (select id from composers where name='Reinecke, C.'), (select id from publishers where name='Boosey & Hawkes'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Suite Antique', (select id from composers where name='Rutter, J.'), (select id from publishers where name='Oxford University Press'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Sonata in C', (select id from composers where name='Telemann, G.'), (select id from publishers where name='C.F. Peters'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Suite, Op.34', (select id from composers where name='Widor'), (select id from publishers where name='Henle Verlag'), null, 'Flute and Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Sonatina for Clarinet and Piano', (select id from composers where name='Arnold, M.'), (select id from publishers where name='Lemanick'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Adagio', (select id from composers where name='Baemann'), (select id from publishers where name='Breitkopf'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Sonata for Clarinet & Piano', (select id from composers where name='Bernstein, L.'), (select id from publishers where name='Boosey & Hawkes'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Clarinet Quintet in B Minor', (select id from composers where name='Brahms'), (select id from publishers where name='Fenette Music'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Clarinet Sonata, Op.109', (select id from composers where name='Bowen, Y.'), (select id from publishers where name='Emerson'), 'Clarinet part only', 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Concerto for Clarinet and Orchestra, Op.5', (select id from composers where name='Crusell, B.'), (select id from publishers where name='Universal'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Première Rhapsodie', (select id from composers where name='Debussy, C.'), (select id from publishers where name='Durand'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Alla Gitana', (select id from composers where name='Dukas, P.'), (select id from publishers where name='Alphonse Leduc'), 'Clarinet part only', 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Clarinet Concerto, Op.32', (select id from composers where name='Finzi, G.'), (select id from publishers where name='Boosey & Hawkes'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Five Bagatelles, Op.23', (select id from composers where name='Finzi, G.'), (select id from publishers where name='Boosey & Hawkes'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('The Really Easy Clarinet Book', (select id from composers where name='Harris, P.'), (select id from publishers where name='Faber Music'), 'Clarinet part only', 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('First Repertoire for Clarinet', (select id from composers where name='Harris, P.'), (select id from publishers where name='Faber Music'), 'TESSA''S', 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Music Through Time: Clarinet Book 1', (select id from composers where name='Harris, P.'), (select id from publishers where name='Oxford University Press'), 'TESSA''S', 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Concertino for Clarinet and Piano', (select id from composers where name='Has, S.'), (select id from publishers where name='PWM'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Sonata in Bb', (select id from composers where name='Hindemith, P.'), (select id from publishers where name='Schott'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Sonatina for Clarinet and Piano', (select id from composers where name='Horovitz, J.'), (select id from publishers where name='Novello'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('3 Preludes', (select id from composers where name='Gershwin, G.'), (select id from publishers where name='Schott'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Il Carnevale di Venezia', (select id from composers where name='Giampieri'), (select id from publishers where name='Ricordi'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Concertino pour Clarinette et Piano', (select id from composers where name='Grovlez, G.'), (select id from publishers where name='EC'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Lamento Et Tarentelle', (select id from composers where name='Grovlez, G.'), (select id from publishers where name='Alphonse Leduc'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('All Jazzed Up - Clarinet', (select id from composers where name='Ledbury, O.'), (select id from publishers where name='Brass Wind Publications'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Clarinet Concerto', (select id from composers where name='Lindberg, M.'), (select id from publishers where name='Boosey & Hawkes'), 'Full score', 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Dance Preludes for Clarinet and Piano', (select id from composers where name='Lutoslawski, W.'), (select id from publishers where name='Chester Music'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Duo Concertant', (select id from composers where name='Milhaud, D.'), (select id from publishers where name='Heugel & Co'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Carmen Fantasie', (select id from composers where name='Milton, S.'), (select id from publishers where name='Orina Publications'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Up Front', (select id from composers where name='Misc.'), (select id from publishers where name='Brass Wind Publications'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('25 Dixieland Songs', (select id from composers where name='Misc.'), (select id from publishers where name='EMI'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Clarinet Exam Pieces: Grade 4', (select id from composers where name='Misc.'), (select id from publishers where name='ABRSM'), 'TESSA''S', 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Clarinet Exam Pieces: Grade 5', (select id from composers where name='Misc.'), (select id from publishers where name='ABRSM'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Spectrum for Clarinet', (select id from composers where name='Mitchell, I.'), (select id from publishers where name='ABRSM'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Divertimento No.2', (select id from composers where name='Mozart, W.A.'), (select id from publishers where name='Chester Music'), 'Piano part only', 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Clarinet Quintet', (select id from composers where name='Mozart, W.A.'), (select id from publishers where name='C.F. Peters'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Il Concerto', (select id from composers where name='Navarro, O.'), null, null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Sonata', (select id from composers where name='Poulenc, F.'), (select id from publishers where name='Chester Music'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Suite from Victorian Kitchen Garden', (select id from composers where name='Reade, P.'), null, null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Introduction, Theme and Variations', (select id from composers where name='Rossini, G.'), (select id from publishers where name='Oxford University Press'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Sonata', (select id from composers where name='Rota, Nino'), (select id from publishers where name='Ricordi'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Sonata', (select id from composers where name='Saint-Saëns'), (select id from publishers where name='C.F. Peters'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Fantasy Pieces, Op.73', (select id from composers where name='Schumann, R.'), (select id from publishers where name='C.F. Peters'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Concerto No.1 in C Minor', (select id from composers where name='Spohr'), (select id from publishers where name='C.F. Peters'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Sonata', (select id from composers where name='Stanford, C.'), (select id from publishers where name='Stainer & Bell'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Christmas Razzamajazz - Clarinet', (select id from composers where name='Watts, S.'), null, null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Concertino for Clarinet and Piano', (select id from composers where name='Weber, C.M.'), (select id from publishers where name='Boosey & Hawkes'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Clarinet Quintet', (select id from composers where name='Weber, C.M.'), (select id from publishers where name='Breitkopf'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Grand Duo Concertant', (select id from composers where name='Weber, C.M.'), (select id from publishers where name='C.F. Peters'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Christmas Jazzin'' About', (select id from composers where name='Wedgwood, P.'), (select id from publishers where name='Faber Music'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Two Movements for Clarinet & Piano', (select id from composers where name='Weiner, L.'), (select id from publishers where name='EMB'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Peregi Verbunk', (select id from composers where name='Weiner, L.'), (select id from publishers where name='EMB'), null, 'Clarinet & Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Fantasy for Clarinet', (select id from composers where name='Arnold, M.'), (select id from publishers where name='Faber Music'), null, 'Solo Clarinet') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Cusp for Solo Clarinet', (select id from composers where name='Fitkin, G.'), null, null, 'Solo Clarinet') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Clarinet Basics', (select id from composers where name='Harris, P.'), (select id from publishers where name='Faber Music'), 'TESSA''S', 'Solo Clarinet') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('80 Graded Studies for Clarinet Book 1', (select id from composers where name='Harris, P.'), (select id from publishers where name='Faber Music'), 'TESSA''S', 'Solo Clarinet') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Improve Your Sight-Reading!', (select id from composers where name='Harris, P.'), (select id from publishers where name='Faber Music'), null, 'Solo Clarinet') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Clarinet Sight Reading', (select id from composers where name='Harvey, P.'), null, null, 'Solo Clarinet') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Hommages', (select id from composers where name='Kovacs, B.'), (select id from publishers where name='Darok'), null, 'Solo Clarinet') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Winner''s Galore', (select id from composers where name='Lawrance, P.'), (select id from publishers where name='Brass Wind Publications'), 'TESSA''S', 'Solo Clarinet') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Five Pieces for Solo Clarinet', (select id from composers where name='Jacob, G.'), (select id from publishers where name='Oxford University Press'), null, 'Solo Clarinet') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Specimen Sight Reading Tests Grades 3-8', (select id from composers where name='Misc.'), (select id from publishers where name='ABRSM'), null, 'Solo Clarinet') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Test Pieces for Orchestral Auditions', (select id from composers where name='Misc.'), (select id from publishers where name='C.F. Peters'), null, 'Solo Clarinet') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('90''s Hits Easy Playalong for Clarinet', (select id from composers where name='Misc.'), (select id from publishers where name='Wise Publications'), 'TESSA''S', 'Solo Clarinet') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('40 Studies for Clarinet Book 1', (select id from composers where name='Reynolds, J.'), (select id from publishers where name='Hunt'), 'TESSA''S', 'Solo Clarinet') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('40 Studies for Clarinet', (select id from composers where name='Rose, C.'), (select id from publishers where name='Carl Fischer'), null, 'Solo Clarinet') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Capriccio', (select id from composers where name='Sutermeister'), (select id from publishers where name='Schott'), null, 'Solo Clarinet') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('48 Studies for Clarinet', (select id from composers where name='Uhl, A.'), (select id from publishers where name='Schott'), null, 'Solo Clarinet') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Fantasie', (select id from composers where name='Widmann'), (select id from publishers where name='Schott'), null, 'Solo Clarinet') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Forty-Eight Preludes & Fugues: Book 1', (select id from composers where name='Bach, J.S.'), (select id from publishers where name='ABRSM'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Inventions & Preludes Book 1', (select id from composers where name='Bach, J.S.'), (select id from publishers where name='Heinrich Germer'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Sonata for Piano', (select id from composers where name='Barber, S.'), (select id from publishers where name='Chapell & Co.'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Moonlight Sonata, Op.27', (select id from composers where name='Beethoven, L.'), null, null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Douze grandes Etudes, Op.10', (select id from composers where name='Chopin'), (select id from publishers where name='Augener Ltd.'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Waltz''s & Nocturnes', (select id from composers where name='Chopin'), (select id from publishers where name='C.F. Peters'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Lyrische Stücke, Op.43', (select id from composers where name='Grieg, E.'), (select id from publishers where name='C.F. Peters'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Poetische Tonbilder', (select id from composers where name='Grieg, E.'), (select id from publishers where name='C.F. Peters'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('In Foreign Lands - Folk Songs and Dances arranged for Pianoforte', (select id from composers where name='Harris, C.'), (select id from publishers where name='Warren & Phillips'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Green Ways: Three Lyric Pieces for Piano', (select id from composers where name='Ireland, J.'), (select id from publishers where name='H. Freeman & Co.'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('London Pieces', (select id from composers where name='Ireland, J.'), (select id from publishers where name='Augener Ltd.'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Sonatina for Piano', (select id from composers where name='Ireland, J.'), (select id from publishers where name='Oxford University Press'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Suite for the Virginal', (select id from composers where name='Jacob, G.'), (select id from publishers where name='Oxford University Press'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Eight Concert Etudes', (select id from composers where name='Kapustin, N.'), (select id from publishers where name='A-RAM'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Classic & Romantinc Pianoforte Pieces', (select id from composers where name='Misc.'), (select id from publishers where name='ABRSM'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Music Library Piano Scores', (select id from composers where name='Misc.'), (select id from publishers where name='Casio'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Hours with the Masters: Book 3', (select id from composers where name='Misc.'), (select id from publishers where name='Bosworth'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Scales, Chords, Arpeggios & Cadences', (select id from composers where name='Misc.'), (select id from publishers where name='Alfred'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Pianoforte Scales & Arpeggios: Grade 8', (select id from composers where name='Misc.'), (select id from publishers where name='ABRSM'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Selected Piano Examination Pieces: Grade 8', (select id from composers where name='Misc.'), (select id from publishers where name='ABRSM'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Klavier Sonaten 2', (select id from composers where name='Mozart, W.A.'), (select id from publishers where name='C.F. Peters'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Serenade from Eine Kleine Nachtmusik', (select id from composers where name='Mozart, W.A.'), (select id from publishers where name='Augener Ltd.'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('The Home Series of the Great Masters (assorted pieces)', (select id from composers where name='Mozart, W.A.'), (select id from publishers where name='Keith Prowse & Co.'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Scenes from Childhood, Op.15', (select id from composers where name='Schumann, R.'), (select id from publishers where name='Neil A. Kjos'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Popular Waltzes', (select id from composers where name='Tchaikovsky, P.'), (select id from publishers where name='New World Publishers'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('The Lake in the Mountains', (select id from composers where name='Vaughan Williams, R.'), (select id from publishers where name='Oxford University Press'), null, 'Classical Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('The Sound of Music Vocal Selections', (select id from composers where name='Rogers & Hammerstein'), (select id from publishers where name='Williamson Music'), null, 'Popular Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Vocal Selections from Mary Poppins', (select id from composers where name='Sherman, R.'), (select id from publishers where name='Wise Publications'), null, 'Popular Piano') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Carmen Fantasy "The Best Bits"', (select id from composers where name='Bizet-Borne arr. McLearnon'), (select id from publishers where name='Gareth McLearnon'), 'Two flutes, piano', 'Chamber Music') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Phantasy Quintet, Op.93', (select id from composers where name='Bowen, Y.'), (select id from publishers where name='Emerson'), 'Bass clarinet & string quartet', 'Chamber Music') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Bass Clarinet', 'Violin', 'Viola', 'Cello');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Trois Mouvements for Flute and Clarinet', (select id from composers where name='Bozza, E.'), (select id from publishers where name='Alphonse Leduc'), 'Flute, Clarinet', 'Chamber Music') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Clarinet');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Aria for Piano, Flute and Clarinet', (select id from composers where name='Ibert, J.'), (select id from publishers where name='Alphonse Leduc'), 'Flute, Clarinet, piano', 'Chamber Music') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute', 'Clarinet', 'Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Quartet for the End of Time', (select id from composers where name='Messiaen, O.'), (select id from publishers where name='Durand'), 'FULL SCORE', 'Chamber Music') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Violin', 'Viola', 'Cello');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('The Magic Flute for two Flutes or Violins', (select id from composers where name='Mozart, W.A.'), null, 'Two flutes', 'Chamber Music') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Quintet in A Major', (select id from composers where name='Mozart, W.A.'), (select id from publishers where name='Bärenreiter'), 'Clarinet, 2 violins, viola, cello', 'Chamber Music') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Clarinet', 'Violin', 'Viola', 'Cello');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Piano works for Four Hands', (select id from composers where name='Schubert'), (select id from publishers where name='Henle Verlag'), 'Piano duet', 'Chamber Music') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Piano');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Selected Duets for Flute: Volume 1', (select id from composers where name='Voxman, H.'), (select id from publishers where name='Rubank'), 'Two flutes', 'Chamber Music') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Flute');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Cantata 68', (select id from composers where name='Bach, J.S.'), (select id from publishers where name='Eulenburg'), 'FULL SCORE', 'Choral') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Voice');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('A Ceremony of Carols', (select id from composers where name='Britten, B.'), (select id from publishers where name='Boosey & Hawkes'), null, 'Choral') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Voice');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Five Part-Songs', (select id from composers where name='Bridge, F.'), (select id from publishers where name='Thames Publishing'), null, 'Choral') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Voice');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('The Light We Cast', (select id from composers where name='Curry, J.'), (select id from publishers where name='Faber Music'), null, 'Choral') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Voice');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Messiah', (select id from composers where name='Handel, G.'), (select id from publishers where name='Novello'), null, 'Choral') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Voice');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Seasons of Love', (select id from composers where name='Larson, J.'), (select id from publishers where name='Hal Leonard'), null, 'Choral') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Voice');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Elijah', (select id from composers where name='Mendelssohn'), (select id from publishers where name='Novello'), null, 'Choral') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Voice');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Songs of Yale', (select id from composers where name='Misc.'), (select id from publishers where name='G. Schirmer, Inc.'), null, 'Choral') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Voice');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Mass in C Minor', (select id from composers where name='Mozart, W.A.'), (select id from publishers where name='C.F. Peters'), null, 'Choral') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Voice');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Requiem', (select id from composers where name='Mozart, W.A.'), (select id from publishers where name='Oxford University Press'), null, 'Choral') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Voice');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Missa Brevis', (select id from composers where name='Nystedt, K.'), (select id from publishers where name='Goodmusic Publishing'), null, 'Choral') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Voice');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('O Hearken', (select id from composers where name='Panufnik'), (select id from publishers where name='C.F. Peters'), null, 'Choral') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Voice');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Snow-Maiden', (select id from composers where name='Rimsky-Korsakov, N.'), (select id from publishers where name='W. Bessel & Co'), 'Vocal Score', 'Choral') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Voice');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('The Crucifixion', (select id from composers where name='Stainer, J.'), (select id from publishers where name='Novello'), null, 'Choral') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Voice');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Symphonie Fantastique', (select id from composers where name='Berlioz'), (select id from publishers where name='Eulenburg'), 'FULL SCORE', 'Other') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Orchestra');
with p as (
  insert into pieces (title, composer_id, publisher_id, notes, category)
  values ('Winners Galore for Brass', (select id from composers where name='Lawrance, P.'), (select id from publishers where name='Brass Wind Publications'), 'Trumpet/Horn/Euphonium', 'Other') returning id
)
insert into piece_instruments (piece_id, instrument_id)
select p.id, i.id from p join instruments i on i.name in ('Trumpet', 'Horn', 'Euphonium');

commit;
