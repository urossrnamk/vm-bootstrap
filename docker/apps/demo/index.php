<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>PHP Test</title>
</head>
<body>

<h1>PHP test application</h1>

<p>PHP version: <?= htmlspecialchars(PHP_VERSION) ?></p>
<p>Container: <?= htmlspecialchars(gethostname()) ?></p>

</body>
</html>