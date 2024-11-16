<?php
header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Authorization, X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Request-Method");
header('Access-Control-Allow-Methods: POST, GET, PATCH, DELETE');
header("Allow: GET, POST, PATCH, DELETE");

date_default_timezone_set('America/Argentina/Buenos_Aires');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {    
   return 0;    
}  

spl_autoload_register(
    function ($nombre_clase) {
        include __DIR__.'/'.str_replace('\\', '/', $nombre_clase) . '.php';
    }
);

define('JWT_KEY', 'DayR7RxvEM4T4efkoEZBSVDjVqrmtdaQZHepj-D4L43GB7mzywkDtr7K-LpjvfKdRRGEqIcvYAPBjCVXñ.');
define('JWT_ALG', 'HS256');
define('JWT_EXP', 300); // segundos


use \Firebase\JWT\JWT;

$metodo = strtolower($_SERVER['REQUEST_METHOD']);
$comandos = explode('/', strtolower($_GET['comando']));
$funcionNombre = $metodo.ucfirst($comandos[0]);

$parametros = array_slice($comandos, 1);
if (count($parametros) >0 && $metodo == 'get') {
    $funcionNombre = $funcionNombre.'ConParametros';
}

if (function_exists($funcionNombre)) {
    call_user_func_array($funcionNombre, $parametros);
} else {
    header(' ', true, 400);
}



function outputJson($data, $codigo = 200)
{
    header('', true, $codigo);
    header('Content-type: application/json');
    print json_encode($data);
}


function outputError($codigo = 500)
{
    switch ($codigo) {
        case 400:
            header($_SERVER["SERVER_PROTOCOL"] . " 400 Bad request", true, 400);
            die;
        case 401:
            header($_SERVER["SERVER_PROTOCOL"] . " 401 Unauthorized", true, 401);
            die;
        case 404:
            header($_SERVER["SERVER_PROTOCOL"] . " 404 Not Found", true, 404);
            die;
        default:
            header($_SERVER["SERVER_PROTOCOL"] . " 500 Internal Server Error", true, 500);
            die;
            break;
    }
}

function autenticar($usuario, $clave)
{
    if ($usuario=='pepe@pepe.com' && $clave=='123') {
        return [
            'nombre' => 'Pepe',
            'id'     => 15,
        ];
    }
    if ($usuario=='coco@coco.com' && $clave=='456') {
        return [
            'nombre' => 'Coco',
            'id'     => 12,
        ];
    }
    return false;
}


function requiereLogin()
{
    try {
        $headers = getallheaders();
        if (!isset($headers['Authorization'])) {
            throw new Exception("Token requerido", 1);
        }
        list($jwt) = sscanf($headers['Authorization'], 'Bearer %s');
        $decoded = JWT::decode($jwt, JWT_KEY, [JWT_ALG]);
    } catch(Exception $e) {
        outputError(401);
    }
    return $decoded;
}

function getPrivado()
{
    $payload = requiereLogin();
    outputJson(['data' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.']);
}

function getPerfil()
{
    $payload = requiereLogin();
    outputJson(['id' => $payload->uid, 'nombre' => $payload->nombre]);
}

function postLogin()
{
    $loginData = json_decode(file_get_contents("php://input"), true);
    $logged = autenticar($loginData['email'], $loginData['clave']);

    if ($logged===false) {
        outputError(401);
    }
    $payload = [
        'uid'       => $logged['id'],
        'nombre'    => $logged['nombre'],
        'exp'       => time() + JWT_EXP,
    ];
    $jwt = JWT::encode($payload, JWT_KEY, JWT_ALG);
    outputJson(['jwt'=>$jwt]);
}

function postRefresh()
{
    $payload = requiereLogin();
    $payload->exp = time() + JWT_EXP;
    $jwt = JWT::encode($payload, JWT_KEY);
    outputJson(['jwt'=>$jwt]);
}


/******************* INICIALIZACION Y RESTABLECIMIENTO **********************************************/
function inicializarBBDD()
{
    return $bd = new SQLite3(__DIR__ . '/../../adicional/SHOPTIENDACM.db');
}

function postRestablecer()
{
    $bd = inicializarBBDD();
    $sql = file_get_contents(__DIR__ . '/../../adicional/dump.sql');
    $result = $bd->exec($sql);
    outputJson([]);
}

/***************************** GET, POST, PATCH Y DELETE **************************************************/
function getGeneros()
{
    $bd = inicializarBBDD();
    $result = $bd->query('SELECT * FROM generos');
    $ret = [];
    while ($fila = $result->fetchArray(SQLITE3_ASSOC)) {
        settype($fila['id'], 'integer');
        $ret[] = $fila;
    }
    outputJson($ret);
}

function getPeliculas()
{
    $bd = inicializarBBDD();
    $result = $bd->query('select * from localidad');
    $ret = [];
    while ($fila = $result->fetchArray(SQLITE3_ASSOC)) {
        settype($fila['id'], 'integer');
        //$fila['generos'] = $fila['generos']=='' ? [] : explode(',', $fila['generos']);
        $ret[] = $fila;
    }
    outputJson($ret);
}

function getPeliculasConParametros($id)
{
    $bd = inicializarBBDD();
    settype($id, 'integer');
    $result = $bd->query("SELECT peliculas.id AS id, peliculas.titulo AS titulo, peliculas.anio AS anio, GROUP_CONCAT(peliculas_generos.id_genero) AS generos FROM peliculas LEFT JOIN peliculas_generos ON peliculas.id=peliculas_generos.id_pelicula WHERE id=$id GROUP BY peliculas.id ");
    $ret = [];
    $fila = $result->fetchArray(SQLITE3_ASSOC);
    settype($fila['id'], 'integer');
    $fila['generos'] = $fila['generos']=='' ? [] : array_map(function ($v) { return $v+0;},  explode(',', $fila['generos']));
    outputJson($fila);
}

function postPeliculas()
{
    $bd = inicializarBBDD();
    $datos = json_decode(file_get_contents('php://input'), true);
    
    $titulo = $bd->escapeString($datos['titulo']);
    $anio = $datos['anio']+0;
    $generos = implode(',', $datos['generos']);

    $result = @$bd->exec("INSERT INTO peliculas (titulo, anio) VALUES ('$titulo', $anio)");
    $id = $bd->lastInsertRowID();
    $result = @$bd->exec("INSERT INTO peliculas_generos (id_pelicula, id_genero) SELECT $id as id_pelicula, generos.id AS id_genero FROM generos WHERE generos.id in ($generos)");
    outputJson(['id' => $id]);
}

function patchPeliculas($id)
{
    settype($id, 'integer');
    $bd = inicializarBBDD();
    $datos = json_decode(file_get_contents('php://input'), true);
    
    $titulo = $bd->escapeString($datos['titulo']);
    $anio = $datos['anio']+0;
    $generos = implode(',', $datos['generos']);

    $result = @$bd->exec("UPDATE peliculas SET titulo='$titulo', anio=$anio WHERE id=$id");
    $result = $bd->query("DELETE FROM peliculas_generos WHERE id_pelicula=$id");
    $result = @$bd->exec("INSERT INTO peliculas_generos (id_pelicula, id_genero) SELECT $id as id_pelicula, generos.id AS id_genero FROM generos WHERE generos.id in ($generos)");
    outputJson(['id' => $id]);
}

function deletePeliculas($id)
{
    settype($id, 'integer');
    $bd = inicializarBBDD();
    $result = $bd->query("DELETE FROM peliculas WHERE id=$id");
    outputJson([]);
}
