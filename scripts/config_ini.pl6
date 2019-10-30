##################################################
############### CONFIGURE INI FILE ###############
##################################################

grammar INI {
  token TOP {
    ^ <.eol>* <toplevels>? <sections>* <.eol>* $
  }

  token toplevel { <keyval>* }
  token sections { <headers> <keyval>* }
  token header { ^^ \h* '[' - ']' $<text>=<-[ \] \n ]>+ \h* <.eol>+ }

  token keyval { ^^ \h* <key> \h* '=' \h* <value>? \h* <.eol>+ }
  regex key { <![#\[]> <-[;=]>+ }
  regex value { [ <![#;]> \N ]+ }
  regex eol { [ <[#;]> \N* ]? \n }
}

grammar INIFile {
  token TOP { <section>* }
  token section {
    <header>
    <keyvalue>*
  }

  rule header {
    '[' <-[ \] \n ]>+ ']' <.eol>
  }

  rule keyvalue {
    ^^
    $<key>=[\w+]
    <[:=]>
    $<value>=[<-[\n;#]>*]
    <.eol>
  }

  token ws { <!ww> \h* }
  token eol {
    \n [\h*\n]*
  }
}

grammar VariableLists {
  token TOP {
    :my %*SYMBOLS;
    <statement>*
  }

  token ws { <!ww> \h* }

  token statement {
    | <declaration>
    | <block>
  }

  rule declaration {
    <identifier>
    { %*SYMBOLS{ $<identifier> } = True; }
    '=' <termlist>
    \n
  }

  rule block {
    :my %*SYMBOLS = CALLERS::<%*SYMBOLS>;
    '{' \n*
    <statement>*
    '}' \n*
  }

  rule termlist { <term> * % ',' }
  token term { <variable> | <number> }
  token variable {
    <identifier>
    <?{ %*SYMBOLS{$<identifier> } }>
  }
  token number { \d+ }
  token identifier { <alpha> \w* }
}
