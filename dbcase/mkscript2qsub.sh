for i in `seq 22` X Y M;do echo "perl create_dbcase_sql.pl chr$i > chr$i.sql" > run.chr$i.sh;sqlite3 rd.chr$i.db < chr$i.sql;qsub -cwd -l vf=1g -l num_proc=1 -q st.q -P st_md run.chr$i.sh;done
