defmodule Huffman do

  def sample() do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only habdle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off
    on the other hand we can use more words'
  end

  def sample2() do
    'voodoo'
  end

  def text() do
    'this is something that we should encode'
  end

  def text2() do
    'how are you'
  end

  def test() do
    sample = sample()
    tree = tree(sample)
    encode = encode_table(tree) ; encode
#    decode = decode_table(tree)
#    text = text2()
#    seq = encode(text, encode)
#    decode(seq, decode)
  end

  def tree(sample) do
    freq = freq(sample)
    sorted = Enum.sort(freq, fn({_, a}, {_, b}) -> a <= b end)
    huffman(sorted)
  end

  def huffman([{tree, _}]), do: tree
  def huffman([{a, af}, {b, bf} | rest]) do
    huffman(insert({{a,b}, af+bf}, rest))
  end

  def insert({a, af}, []), do: [{a, af}]
  def insert({a, af}, [{b, bf} | rest]) when af<bf do
    [{a,af}, {b, bf} | rest]
  end
  def insert({a, af}, [{b, bf} | rest]) do
    [{b, bf} | insert({a, af}, rest)]
  end

  def freq(sample) do freq(sample, []) end

  def freq([], freq) do freq end
  def freq([char|rest], freq) do
    freq(rest, add(char, freq))
  end

  def add(char, []) do [{char, 1}] end
  def add(char, [h | t]) do
    {letter, count} = h
    if char == letter do
      [{letter, count+1} | t]
    else
      [h | add(char, t)]
    end
  end

  # Traverse the Huffman tree and build binary encoding
  # for each character

  def encode_table(tree) do
    codes(tree, [])
  end

  def codes({a,b}, sofar) do
    as = codes(a, [0 | sofar])
    bs = codes(b, [1 | sofar])
    as ++ bs
  end
  def codes(a, code) do
    [{a, Enum.reverse(code)}]
  end

  # Parse a string of text and encode it with other
  # previously generated encoding table
  def encode([], _), do: []
  def encode([char | rest], table) do
    {_, code} = List.keyfind(table, char, 0)
    code ++ encode(rest, table)
  end

  # Decode a string of text using the same encoding
  # table as above. This is a shortcut and an
  # unrealistic situation.
  def decode_table(tree), do: codes(tree, [])

  def decode([], _), do: []
  def decode(seq, table) do
    {char, rest} = decode_char(seq, 1, table)
    [char | decode(rest, table)]
  end

  def decode_char(seq, n, table) do
    {code, rest} = Enum.split(seq, n)
    case List.keyfind(table, code, 1) do
      {char, _} ->
        {char, rest}

      nil ->
        decode_char(seq, n + 1, table)
    end
  end

end
