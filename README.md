# TP_Redis


Programme developpé en RUBY qui permet d'ajouter des jobs dans une file d'attente (addJobs.rb) sur un bdd Redis. Un worker execute les jobs en attente présent dans Redis. Il recupere le title, l'url, les keywords et la description d'un site web et les stockent ces informations dans une bdd MongoDB ou Elasticsearch (doJobs.rb). Le nombre de jobs traité et en attente sont affichés a chaque traitement d'un job.

Le dossier [OLD] contient la première version du TP. SetJobs ajoute des jobs dans Redis et ExecJobs les traite un par un à chaque fois qu’on le lance. Pour le cas présent, après avoir fait le script SetJobs il faudra lancer ExecJobs deux fois car SetJobs ajoute deux éléments à traiter. Pour réinitialiser les deux listes il suffit de décommenter les deux lignes déjà présentes à cet effet dans ExecJobs.

**Gems utilisés :**

- json : *pour parser des objets en JSON*
- redis : *communication avec une bdd redis*
- mongo + mongoid : *communication avec une bdd mongo*
- nokogiri + open-uri + rubygems : *utilitaires pour recuperer une page web et recupérer les informations voulues*