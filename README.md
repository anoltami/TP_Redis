# TP_Redis


Programme developpé en RUBY qui permet d'ajouter des jobs dans une file d'attente (addJobs.rb) sur un bdd Redis. Un worker execute les jobs en attente présent dans Redis. Il recupere le title, l'url, les keywords et la description d'un site web et les stockent ces informations dans une bdd MongoDB ou Elasticsearch (doJobs.rb). Le nombre de jobs traité et en attente sont affichés a chaque traitement d'un job.