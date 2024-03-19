
Mes remarques sur ce que j'aurais pu ameliorer

- A la ligne 30 et 31, au lieu de faire DateTime.new je pense que si on etait sur un projet rails, il aurait fallu gerer
la timezone. En utilisant par exemple `Time.zone.local(start_time.year, start_time.month, start_time.day, 9, 0, 0)`

- Je n'aurais pas eu besoin de faire un strftime et simplement un I18.l pour traduire du coup la date au bon format.

- J'ai fais un serializer pour gêrer le format de la donnée qu'on récupère

- Autre remarque, je ne sais pas si j'aurais du poser cette question mais actuellement on utilise deux fichier JSON
si on avait un nombre indefinis on aurait du faire un splat operator pour parser tous les fichiers.
mais si c'etait un call API on aurait pu avec la route recuperer tous les calendrier ?
