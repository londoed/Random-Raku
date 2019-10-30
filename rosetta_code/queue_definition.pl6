################################################
############### QUEUE/DEFINITION ###############
################################################

role FIFO {
  method enqueue(*@values) {
    self.push: @values;
    return @values.elems;
  }

  method dequeue {
    return self.elems ?? self.shift !! Nil;
  }

  method is_empty {
    return self.elems == 0;
  }
}

my @queue does FIFO;

say @queue.is_empty;

for <A B C> -> $i {
  say @queue.enqueue($i);
}

say @queue.enqueue(Any);
say @queue.enqueue(7, 8);
say @queue.is_empty;
say @queue.dequeue;
say @queue.elems;
say @queue.dequeue;
say @queue.is_empty;
say @queue.enqueue('OHAI!');
say @queue.dequeue until @queue.is_empty;
say @queue.is_empty;
say @queue.dequeue;
