create extension if not exists "pgcrypto";

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  avatar_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, full_name)
  values (new.id, new.raw_user_meta_data ->> 'full_name');
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

create table if not exists public.interviews (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  role text not null,
  interview_type text not null,
  difficulty text not null,
  status text not null default 'completed'
    check (status in ('draft', 'in_progress', 'completed', 'cancelled')),
  overall_score integer check (overall_score between 0 and 100),
  started_at timestamptz not null default now(),
  completed_at timestamptz,
  created_at timestamptz not null default now()
);

create table if not exists public.questions (
  id uuid primary key default gen_random_uuid(),
  interview_id uuid not null references public.interviews(id) on delete cascade,
  question_order integer not null check (question_order > 0),
  question_text text not null,
  created_at timestamptz not null default now(),
  unique (interview_id, question_order)
);

create table if not exists public.answers (
  id uuid primary key default gen_random_uuid(),
  question_id uuid not null references public.questions(id) on delete cascade,
  user_id uuid not null references public.profiles(id) on delete cascade,
  answer_text text not null default '',
  transcript text,
  duration_seconds integer not null default 0 check (duration_seconds >= 0),
  word_count integer not null default 0 check (word_count >= 0),
  filler_word_count integer not null default 0 check (filler_word_count >= 0),
  speaking_speed_wpm integer check (speaking_speed_wpm >= 0),
  created_at timestamptz not null default now()
);

create table if not exists public.evaluations (
  id uuid primary key default gen_random_uuid(),
  answer_id uuid not null unique references public.answers(id) on delete cascade,
  user_id uuid not null references public.profiles(id) on delete cascade,
  overall_score integer check (overall_score between 0 and 100),
  relevance integer check (relevance between 0 and 100),
  clarity integer check (clarity between 0 and 100),
  grammar integer check (grammar between 0 and 100),
  confidence integer check (confidence between 0 and 100),
  completeness integer check (completeness between 0 and 100),
  technical_accuracy integer check (technical_accuracy between 0 and 100),
  feedback text,
  created_at timestamptz not null default now()
);

create table if not exists public.resumes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  file_path text,
  resume_text text,
  analysis jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.job_descriptions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  title text,
  description_text text not null,
  analysis jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.subscriptions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null unique references public.profiles(id) on delete cascade,
  plan text not null default 'free' check (plan in ('free', 'premium')),
  status text not null default 'active'
    check (status in ('active', 'inactive', 'past_due', 'cancelled')),
  current_period_start timestamptz,
  current_period_end timestamptz,
  provider_customer_id text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.usage (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  period_start date not null,
  interview_count integer not null default 0 check (interview_count >= 0),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (user_id, period_start)
);

create index if not exists interviews_user_created_idx
  on public.interviews(user_id, created_at desc);
create index if not exists questions_interview_order_idx
  on public.questions(interview_id, question_order);
create index if not exists answers_user_created_idx
  on public.answers(user_id, created_at desc);

alter table public.profiles enable row level security;
alter table public.interviews enable row level security;
alter table public.questions enable row level security;
alter table public.answers enable row level security;
alter table public.evaluations enable row level security;
alter table public.resumes enable row level security;
alter table public.job_descriptions enable row level security;
alter table public.subscriptions enable row level security;
alter table public.usage enable row level security;

create policy "Users can view their profile"
  on public.profiles for select using (auth.uid() = id);
create policy "Users can update their profile"
  on public.profiles for update using (auth.uid() = id);

create policy "Users can manage their interviews"
  on public.interviews for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "Users can view their questions"
  on public.questions for select using (
    exists (select 1 from public.interviews i
      where i.id = interview_id and i.user_id = auth.uid())
  );
create policy "Users can create questions for their interviews"
  on public.questions for insert with check (
    exists (select 1 from public.interviews i
      where i.id = interview_id and i.user_id = auth.uid())
  );
create policy "Users can manage their answers"
  on public.answers for all
  using (
    auth.uid() = user_id and exists (
      select 1 from public.questions q
      join public.interviews i on i.id = q.interview_id
      where q.id = question_id and i.user_id = auth.uid()
    )
  )
  with check (
    auth.uid() = user_id and exists (
      select 1 from public.questions q
      join public.interviews i on i.id = q.interview_id
      where q.id = question_id and i.user_id = auth.uid()
    )
  );
create policy "Users can manage their evaluations"
  on public.evaluations for all
  using (
    auth.uid() = user_id and exists (
      select 1 from public.answers a
      where a.id = answer_id and a.user_id = auth.uid()
    )
  )
  with check (
    auth.uid() = user_id and exists (
      select 1 from public.answers a
      where a.id = answer_id and a.user_id = auth.uid()
    )
  );
create policy "Users can manage their resumes"
  on public.resumes for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "Users can manage their job descriptions"
  on public.job_descriptions for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "Users can view their subscription"
  on public.subscriptions for select using (auth.uid() = user_id);
create policy "Users can view their usage"
  on public.usage for select using (auth.uid() = user_id);

insert into storage.buckets (id, name, public)
values ('user-files', 'user-files', false)
on conflict (id) do nothing;

create policy "Users can manage their files"
  on storage.objects for all using (
    bucket_id = 'user-files' and (storage.foldername(name))[1] = auth.uid()::text
  ) with check (
    bucket_id = 'user-files' and (storage.foldername(name))[1] = auth.uid()::text
  );