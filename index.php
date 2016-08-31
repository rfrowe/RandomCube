<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="I created a program that generates random formulae using the sin, cos, average, and multiplication functions. These functions always return values in the interval [-1,1]. The functions are generated at a recursive level of complexity. The program then uses three formulae to calclate RGB values for different (x,y,z) coordinates on a cube. The results look amazing and have incredible sinusoidal patterns.">
    <title>Ryan Rowe's Portfolio</title>

    <style>
    section input[type="text"] {
		float: left;
		margin-right: 2em;
		margin-top: 3em;
		padding: 0.5em;
		border: solid 1px #515151;
		display: block;
		margin-bottom: 2em;
		font-size: 1em;
	} section h3 {
		float: right;
		margin-top: 3em;
		margin-left: 0.5em;
		display: inline-block
	} section input[type="button"] {
		float: left;
		margin-top: 3em;
    	-webkit-transition: all 0.3s ease-out;
		-o-transition: all 0.3s ease-out;
		transition: all 0.3s ease-out;

        color: #212121;
		padding: 0.5em;
    	font-size: 1em;
        border: 1px solid #455A64;
	} section input[type="button"]:hover, section input[type="button"]:active {
    	background-color: #455A64;
		color: #FDFDFD;
    } section canvas {
		background-color: #FFF;
		display: block;
		margin-left: auto;
		margin-right: auto;
		margin-bottom: 2em;
	} section canvas:focus {
		outline: none;
	} section {
		min-width: 30em !important;
	} section p {
		clear: both;
		text-align: center;
	}
	@media only screen and (max-width: 768px) {
		section {
			min-width: unset !important;
		} section h3 {
			float: left;
		}
	}
    </style>

	<?php include($_SERVER['DOCUMENT_ROOT'] . "/files/common.php") ?>
	<script src="/files/js/processing.js"></script>

    <script>
	function setComplexity(delta) {
		var pjs = Processing.getInstanceById('rand-cube');
		var complexity = pjs.getComplexity();
		var newComplexity = complexity + delta;

		if(newComplexity < 10 && newComplexity > 0) {
			pjs.setComplexity(newComplexity);
			document.getElementById('label').innerHTML = "Complexity: " + newComplexity;
		}
	}
	</script>
</head>

<body>
<?php readfile($_SERVER['DOCUMENT_ROOT'] . "/files/header.html") ?>
<main class="container">
	<article class="content offset">
    <section class="main">
    	<h1>Random Cube</h1>
		<h4>CSE 390</h4>
    	<section>
        	<h3 style="float:left; margin-right:1em;">Change complexity: </h3>
			<p class="range-field">
			<input type="range" id="complexity" min="1" max="9" value="1"/>
			</p>
            <h3 id="label">Complexity: 1</h3>
            <p style="padding-top: 1em;"><b>Drag the cube around with your mouse!</b></p>
            <p>For the purpose of this website, the cubes have been pre-generated.</p>
            <canvas data-processing-sources="RandomCube.pde" class="card grey lighten-3" id="rand-cube"></canvas>
        </section>
        <section class="code-block dropshadow">
        <?php echo str_replace("\t","&nbsp;&nbsp;",nl2br(htmlspecialchars(file_get_contents("./Original.pde")))); ?>
        </section>
    </section>
  </article> <!-- end .content -->
</main>
<?php include($_SERVER['DOCUMENT_ROOT'] . "/files/footer.php") ?>
</body>
</html>
