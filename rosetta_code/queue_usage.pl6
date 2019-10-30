###########################################
############### QUEUE USAGE ###############
###########################################

my @queue = <a>;
@queue.push('b', 'c');

say @queue.shift;
say @queue.pop;
say @queue.perl;
say @queue.elems;

@queue.unshift('A');
@queue.push('C');
