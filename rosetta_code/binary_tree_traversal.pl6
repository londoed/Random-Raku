#####################################################
############### BINARY TREE TRAVERSAL ###############
#####################################################

class TreeNode {
  has TreeNode $.parent;
  has TreeNode $.left;
  has TreeNode $.right;
  has $.value;

  method pre_order {
    flat gather {
      take $.value;
      take $.left.pre_order if $.left;
      take $.right.pre_order if $.right;
    }
  }

  method in_order {
    flat gather {
      take $.left.in_order if $.left;
      take $.value;
      take $.right.in_order if $.right;
    }
  }

  method post_order {
    flat gather {
      take $.left.post_order if $.left;
      take $.right.post_order if $.right;
      take $.value;
    }
  }

  method level_order {
    my TreeNode @queue = (self);
    flat gather while @queue.elems {
      my $n = @queue.shift;
      take $n.value;
      @queue.push($n.left) if $n.left;
      @queue.push($n.right) if $n.right;
    }
  }
}

my TreeNode $root .= new( value => 1,
                    left => TreeNode.new( value => 2,
                            left => TreeNode.new( value => 4, left => TreeNode.new(value => 7)),
                            right => TreeNode.new( value => 5)
                    ),
                    right => TreeNode.new( value => 3,
                             left => TreeNode.new( value => 6,
                                     left => TreeNode.new(value => 8),
                                     right => TreeNode.new(value => 9)
                                     )
                             )
                    );

say "preorder:  ",$root.pre-order.join(" ");
say "inorder:   ",$root.in-order.join(" ");
say "postorder: ",$root.post-order.join(" ");
say "levelorder:",$root.level-order.join(" ");
