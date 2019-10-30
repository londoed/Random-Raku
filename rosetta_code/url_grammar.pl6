###########################################
############### URL GRAMMAR ###############
###########################################

grammar Url {
  token TOP {
    <protocol> <domain> <path> <query> <fragment>
  }

  token protocol {
    <(<[a..z]> ** 3..10)>
    '://'
  }

  token domain_segment { <-[?#/.]>+ }
  token domain {
    <domain_segment> ** 2..*
      % '.'

    <?{@<domain_segment>.tail.chars >= 3}>
  }

  token path_segment { <-[?#/\\]>+ }
  token path {
    [
      <[/\\]>
      <path_segment>*
        %% <[/\\]>
    ]?
  }

  token query_segment {
    $<key> = ( <-[#=&]>+ )
    '='
    $<value> = ( <-[#=&]>+ )
    {
      make ~$<key> => val(~$<value>)
    }
  }

  token query {
    [
      '?'
      <(
        <query_segment>*
          % '&'
      )>
    ]?
    {
      make Map.new: (@<query_segment>>>.ast if @<query_segment>.elems)
    }
  }

  token fragment {
    [
      '#'
      <( .* )>
    ]?
  }
}
