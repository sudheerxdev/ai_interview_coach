create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, full_name)
  values (new.id, new.raw_user_meta_data ->> 'full_name')
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row execute procedure public.handle_new_user();

drop policy if exists "Users can manage their answers" on public.answers;
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

drop policy if exists "Users can manage their evaluations" on public.evaluations;
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
