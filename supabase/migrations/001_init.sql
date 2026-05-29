-- =============================================
-- Music Library DB — Initial Schema
-- =============================================

-- Reference tables
create table instruments (
  id   uuid primary key default gen_random_uuid(),
  name text not null unique
);

create table composers (
  id   uuid primary key default gen_random_uuid(),
  name text not null unique
);

create table publishers (
  id   uuid primary key default gen_random_uuid(),
  name text not null unique
);

-- Main pieces table
create table pieces (
  id           uuid primary key default gen_random_uuid(),
  title        text not null,
  composer_id  uuid references composers(id) on delete set null,
  publisher_id uuid references publishers(id) on delete set null,
  created_at   timestamptz default now(),
  updated_at   timestamptz default now()
);

-- Many-to-many: pieces <-> instruments
create table piece_instruments (
  piece_id      uuid references pieces(id) on delete cascade,
  instrument_id uuid references instruments(id) on delete cascade,
  primary key (piece_id, instrument_id)
);

-- Auto-update updated_at
create or replace function set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger pieces_updated_at
  before update on pieces
  for each row execute procedure set_updated_at();

-- =============================================
-- Convenience view for list pages
-- =============================================
create view piece_details as
select
  p.id,
  p.title,
  c.name   as composer,
  pub.name as publisher,
  array_remove(array_agg(i.name order by i.name), null) as instruments
from pieces p
left join composers c     on c.id = p.composer_id
left join publishers pub  on pub.id = p.publisher_id
left join piece_instruments pi on pi.piece_id = p.id
left join instruments i   on i.id = pi.instrument_id
group by p.id, p.title, c.name, pub.name;

-- =============================================
-- Row Level Security
-- =============================================
alter table pieces            enable row level security;
alter table piece_instruments enable row level security;
alter table composers         enable row level security;
alter table publishers        enable row level security;
alter table instruments       enable row level security;

-- Public SELECT on all tables
create policy "public read pieces"
  on pieces for select using (true);

create policy "public read piece_instruments"
  on piece_instruments for select using (true);

create policy "public read composers"
  on composers for select using (true);

create policy "public read publishers"
  on publishers for select using (true);

create policy "public read instruments"
  on instruments for select using (true);

-- Authenticated write on pieces
create policy "auth insert pieces"
  on pieces for insert with check (auth.role() = 'authenticated');

create policy "auth update pieces"
  on pieces for update using (auth.role() = 'authenticated');

create policy "auth delete pieces"
  on pieces for delete using (auth.role() = 'authenticated');

-- Authenticated write on piece_instruments
create policy "auth insert piece_instruments"
  on piece_instruments for insert with check (auth.role() = 'authenticated');

create policy "auth delete piece_instruments"
  on piece_instruments for delete using (auth.role() = 'authenticated');

-- Authenticated write on reference tables
create policy "auth insert composers"
  on composers for insert with check (auth.role() = 'authenticated');

create policy "auth insert publishers"
  on publishers for insert with check (auth.role() = 'authenticated');

create policy "auth insert instruments"
  on instruments for insert with check (auth.role() = 'authenticated');
