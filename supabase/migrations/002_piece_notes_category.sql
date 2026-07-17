-- =============================================
-- Add notes + category to pieces, and surface them in piece_details
-- =============================================

alter table pieces add column if not exists notes    text;
alter table pieces add column if not exists category text;

-- Recreate the list view to include the new fields. New columns are appended
-- AFTER the existing ones — `create or replace view` cannot reorder or rename
-- existing view columns, only add to the end.
create or replace view piece_details as
select
  p.id,
  p.title,
  c.name   as composer,
  pub.name as publisher,
  array_remove(array_agg(i.name order by i.name), null) as instruments,
  p.notes,
  p.category
from pieces p
left join composers c     on c.id = p.composer_id
left join publishers pub  on pub.id = p.publisher_id
left join piece_instruments pi on pi.piece_id = p.id
left join instruments i   on i.id = pi.instrument_id
group by p.id, p.title, c.name, pub.name, p.notes, p.category;
