
/*batch 1 606-3815 */
select * from dbo.fact_table as facts
WHERE facts.facts_key <=3815;

/*batch 2 3816-7025*/
select * from dbo.fact_table as facts
WHERE facts.facts_key BETWEEN 3816 AND 7025;

/*batch 3 7026-10234*/
select * from dbo.fact_table as facts
WHERE facts.facts_key BETWEEN 7026 AND 10234;

/*batch 4 10235-13444*/
select * from dbo.fact_table as facts
WHERE facts.facts_key BETWEEN 10235 AND 13444;

/*batch 5 13445-16650*/
select * from dbo.fact_table as facts
WHERE facts.facts_key >13444;