<?php
$host = 'postgresql-kadirisa.alwaysdata.net';
$dbname = 'kadirisa__netserieflix';
$username = 'kadirisa_admin';
$password = 'cR3GdEJ5uYguPBJ';
try {
    $dsn = new PDO ("pgsql:host=$host;port=5432;dbname=$dbname;user=$username;password=$password");
} catch (PDOException $e) {
    die("erreur de connexion:" . $e->getMessage());
}

?>
<!DOCTYPE html>
<html lang="fr" dir="ltr">
<head>
    <meta charset="utf-8">
    <title>BDD NetSerieFlix</title>

    <style type="text/css">
        body {
            font-family: sans-serif;
            font-size: 1.1em;
            margin-bottom: 50px;
        }

        h1 {
            color: #08457e;
        }

        h2 {
            color: #0198e1;
            margin-top: 40px;
            margin-bottom: 10px;
        }

        li {
            margin-top: 5px;
        }

        button[type='submit'] {
            font-weight: bold;
        }
    </style>
</head>

<body>
<h1>BDD NetSerieFlix</h1>

<h2>Liste des séries en base <i>(de la mieux notée à la moins bien notée)</i> :</h2>
<ul>
    <?php
        $sql = "SELECT * FROM serie ORDER BY note DESC";
        $result = $dsn->query($sql);
        while ($row = $result->fetch()) {
            echo "<li>". $row['nom_serie'] . ' (' . $row['note'] . ') ' . $row['synopsis'] . "</li>";
        }?>
</ul>

<h2>Liste des séries appartenant au genre Comique</i> :</h2>
<ul>
    <?php
        $sql = "SELECT * FROM genre,serie,appartenir WHERE genre.id_genre = '3' and serie.id_serie = appartenir.id_serie and genre.id_genre = appartenir.id_genre";
        $result = $dsn->query($sql);
        while ($row = $result->fetch()) {
            echo "<li>". $row['nom_serie'] . "</li>";
        }?>
</ul>

<h2>Afficher le nombre de saisons pour une série donnée :</h2>
<!-- (On ne définit pas la propriété "action" car on veut que
    ça recharge la même page) -->
<form method="get">
    <label for="cars">Choisir la série :
        <select name="nomSerie">
            <?php
            $sql = "SELECT * FROM serie";
            $result = $dsn->query($sql);
            while ($row = $result->fetch()) {
                echo "<option value='" . $row['nom_serie'] . "'>" . $row['nom_serie'] . "</option>";
            }?>
        </select>
    &nbsp;
    <button type="submit">Lancer la recherche</button>
    <?php if (isset($_GET['nomSerie'])){
    $sql = "SELECT DISTINCT count(saison.id_serie) as nb FROM saison,serie WHERE nom_serie = '" . $_GET['nomSerie'] . "' and serie.id_serie = saison.id_serie";
        $result = $dsn->query($sql);
        while ($row = $result->fetch()) {
            echo "<p>". "NetSerieFlix propose ". "<strong>" .  $row['nb'] . " saison(s) " .  "</strong>" . " de la serie " . "<strong>"  . $_GET['nomSerie']."</strong> "  . "</p>";
        }
    }?>
</form>

<h2>Nombre d'épisodes par saison de la série Black Mirror :</h2>
<!-- INDICATION : Vous n'avez besoin que des tables episode et serie
      pour cette requête -->
<ul>
    <?php
    $sql = "SELECT DISTINCT count(episode.id_serie) as nb, saison.num_saison FROM episode,serie,saison WHERE nom_serie = 'Black Mirror' and serie.id_serie = episode.id_serie and saison.id_serie = serie.id_serie and saison.id_serie = episode.id_serie and saison.num_saison = episode.num_saison GROUP BY saison.num_saison";
    $result = $dsn->query($sql);
    while ($row = $result->fetch()) {
        echo "<li>". "La saison " . "<strong>" . $row['num_saison'] . "</strong>" . " de Black Mirror comporte " . "<strong>" . $row['nb'] . " épisode(s)" . "</strong>" . "</li>";
    }?>

</ul>

</body>
</html>