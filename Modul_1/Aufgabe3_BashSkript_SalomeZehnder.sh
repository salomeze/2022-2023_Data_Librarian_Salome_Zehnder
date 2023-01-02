# Zuerst 2 Files machen, weil die Zeilen 32-39 «verschoben» sind. 

$ sed '32,39!d' 2022-11-28-Article_list_dirty.tsv > Articles_Lines_32_to_39.tsv
$ sed '32,39d' 2022-11-28-Article_list_dirty.tsv > Articles_Part_1.tsv

# Jetzt bei beiden Files die unnötigen Spalten löschen

$ cut -f 5,12 Articles_Part_1.tsv > Articles_Part_1_ISSN_Date.tsv
$ cut -f 7,14 Articles_Lines_32_to_39.tsv > Articles_Lines_32_to_39_ISSN_Date.tsv

# Jetzt beide Files zusammensetzen und in ein neues File speichern

$ cat Articles_Part_1_ISSN_Date.tsv Articles_Lines_32_to_39_ISSN_Date.tsv > ISSN_and_Dates.tsv

#Mit sed die Strings ISSN:, Leerzeichen und das # rauslöschen

$ sed "s/ISSN://gi" ISSN_and_Dates.tsv > ISSN_and_Dates_1.tsv
$ sed "s/ //gi" ISSN_and_Dates_1.tsv > ISSN_and_Dates_2.tsv
$ sed "s/#//gi" ISSN_and_Dates_2.tsv > ISSN_and_Dates_3.tsv

#Mit grep die leeren Zeilen rauslöschen

grep "\S" ISSN_and_Dates_3.tsv > ISSN_and_Dates_beinahe_def.tsv

#Mit unique die Doppelten Zeilen eliminieren und mit sort sortieren

$ uniq ISSN_and_Dates_beinahe_def.tsv > 2023-01-02-ISSN_and_Dates.tsv
$ sort 2023-01-02-ISSN_and_Dates.tsv > 2023-01-02-ISSN_and_Dates_1.tsv

#da es mir noch nicht alle Duplikate gelöscht hat, suche ich nach versteckten Zeichen

$ cat -v 2023-01-02_ISSN_and_Dates_1.tsv 

#mit $ sed kann ich die ^M rauslöschen

$ sed "s/^M//gi" 2023-01-02_ISSN_and_Dates_1.tsv > 2023-01-02_ISSN_and_Dates_2.tsv 

#ich elimieniere nochmals mit uniq

$ uniq 2023-01-02_ISSN_and_Dates_2.tsv > 2023-01-02_ISSN_and_Dates_3.tsv 

#am Ende lösche ich alle überflüssigen Files mit rm und benenne das End-File mit mv um in 2023-01-02-ISSN_and_Dates.tsv

