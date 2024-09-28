import 'dart:math' show Random;

void main() async {
  print('Compute pi using the Monte Carlo method.');
  await for (final estimate in computePi().take(100)) {
    print('pi = $estimate');
  }
}


Stream<double> computePi({int batch = 100000}) async* {
  var total = 0; 
  var count = 0;
  while (true) {
    final points = generateRandom().take(batch);
    final inside = points.where((p) => p.isInsideUnitCircle);

    total += batch;
    count += inside.length;
    final ratio = count / total;

    
    yield ratio * 4;
  }
}

Iterable<Point> generateRandom([int? seed]) sync* {
  final random = Random(seed);
  while (true) {
    yield Point(random.nextDouble(), random.nextDouble());
  }
}

class Point {
  final double x;
  final double y;

  const Point(this.x, this.y);

  bool get isInsideUnitCircle => x * x + y * y <= 1;
}

/* NOTES
Main Function:
  computePi() calls the function to start generating points for Pi
  .take(100) only take 100 values from the stream of estimates
  await for is similar to a loop but instead waits for a specific action before
  executing the code within the loop.
Stream Function:
  Stream<double> returns a stream of double values 
  generateRandom().take(batch) takes a batch (collection?) of random points
  where(p) => p.isInsideUnitCircle chcecks if the points fall within the circle
GenerateRandom function:
  random.nextDouble() produces a random value between 0 & 1, it then creates point
  objects with these random values
Point class:
  this defines a point object with two properties (x & y) which represent coords
  isInsideUnitCircle() checks if the point is inside a circle 

LOGIC FLOW:
  generates random points
  checks how many fall inside a circle
  estimates pi based on the ratio of the points inside the circle to the total points 
  repeats this proess, refining the estimat as more points are considered
*/
