unit uSmaz;

interface

uses
  System.SysUtils, System.Classes;

type
  /// <summary>
  /// Compression for very small strings
  /// </summary>
  TSmaz = class(TObject)

  strict private
    class var FencoderLookup, FdecoderLookup: TArray<TArray<Byte>>;
    class constructor CreateSmaz();

  public
    /// <summary>
    /// Compresses a byte array using Smaz encoding
    /// </summary>
    /// <param name="Input">ASCII encoded Data to be compressed</param>
    /// <returns>Compressed data as a byte array</returns>
    class function Compress(Input: TArray<Byte>): TArray<Byte>;
      overload; static;
    /// <summary>
    /// Compresses an ASCII string to a Smaz encoded byte array
    /// </summary>
    /// <param name="Input">String to compress</param>
    /// <returns>Compressed data as a byte array</returns>
    class function Compress(const Input: String): TArray<Byte>;
      overload; static;
    /// <summary>
    /// Decompresses a Smaz encoded byte array and returns the original string
    /// </summary>
    /// <param name="Input">Smaz encoded byte array</param>
    /// <returns>Decompressed string</returns>
    class function Decompress(Input: TArray<Byte>): String; overload; static;

  end;

implementation

class constructor TSmaz.CreateSmaz();
begin
{$REGION 'Lookup Data'}
  FencoderLookup := TArray < TArray < Byte >>
    .Create(TArray<Byte>.Create(2, 115, 44, 182), TArray<Byte>.Create(3, 104,
    97, 100, 154, 2, 108, 101, 87), TArray<Byte>.Create(3, 111, 110, 32, 142),
    Nil, TArray<Byte>.Create(1, 121, 83), TArray<Byte>.Create(2, 109, 97, 173,
    2, 108, 105, 151), TArray<Byte>.Create(3, 111, 114, 32, 176), Nil,
    TArray<Byte>.Create(2, 108, 108, 152, 3, 115, 32, 116, 191),
    TArray<Byte>.Create(4, 102, 114, 111, 109, 103, 2, 109, 101, 108), Nil,
    TArray<Byte>.Create(3, 105, 116, 115, 218), TArray<Byte>.Create(1, 122,
    219), TArray<Byte>.Create(3, 105, 110, 103, 70), TArray<Byte>.Create(1, 62,
    222), TArray<Byte>.Create(1, 32, 0, 3, 32, 32, 32, 40, 2, 110, 99, 228),
    TArray<Byte>.Create(2, 110, 100, 61, 3, 32, 111, 110, 202),
    TArray<Byte>.Create(2, 110, 101, 139, 3, 104, 97, 116, 190, 3, 114, 101, 32,
    113), Nil, TArray<Byte>.Create(2, 110, 103, 84, 3, 104, 101, 114, 122, 4,
    104, 97, 118, 101, 198, 3, 115, 32, 111, 149), Nil,
    TArray<Byte>.Create(3, 105, 111, 110, 107, 3, 115, 32, 97, 172, 2, 108, 121,
    234), TArray<Byte>.Create(3, 104, 105, 115, 76, 3, 32, 105, 110, 78, 3, 32,
    98, 101, 170), Nil, TArray<Byte>.Create(3, 32, 102, 111, 213, 3, 32, 111,
    102, 32, 3, 32, 104, 97, 201), Nil, TArray<Byte>.Create(2, 111, 102, 5),
    TArray<Byte>.Create(3, 32, 99, 111, 161, 2, 110, 111, 183, 3, 32, 109, 97,
    248), Nil, Nil, TArray<Byte>.Create(3, 32, 99, 108, 238, 3, 101, 110, 116,
    97, 3, 32, 97, 110, 55), TArray<Byte>.Create(2, 110, 115, 192, 1, 34, 101),
    TArray<Byte>.Create(3, 110, 32, 116, 143, 2, 110, 116, 80, 3, 115, 44, 32,
    133), TArray<Byte>.Create(2, 112, 101, 208, 3, 32, 119, 101, 233, 2, 111,
    109, 147), TArray<Byte>.Create(2, 111, 110, 31), Nil,
    TArray<Byte>.Create(2, 121, 32, 71), TArray<Byte>.Create(3, 32, 119, 97,
    185), TArray<Byte>.Create(3, 32, 114, 101, 209, 2, 111, 114, 42), Nil,
    TArray<Byte>.Create(2, 61, 34, 169, 2, 111, 116, 223),
    TArray<Byte>.Create(3, 102, 111, 114, 68, 2, 111, 117, 91),
    TArray<Byte>.Create(3, 32, 116, 111, 82), TArray<Byte>.Create(3, 32, 116,
    104, 13), TArray<Byte>.Create(3, 32, 105, 116, 246),
    TArray<Byte>.Create(3, 98, 117, 116, 177, 2, 114, 97, 130, 3, 32, 119, 105,
    243, 2, 60, 47, 241), TArray<Byte>.Create(3, 32, 119, 104, 159),
    TArray<Byte>.Create(2, 32, 32, 52), TArray<Byte>.Create(3, 110, 100, 32,
    63), TArray<Byte>.Create(2, 114, 101, 33), Nil, TArray<Byte>.Create(3, 110,
    103, 32, 99), Nil, TArray<Byte>.Create(3, 108, 121, 32, 199, 3, 97, 115,
    115, 211, 1, 97, 4, 2, 114, 105, 114), Nil, Nil, Nil,
    TArray<Byte>.Create(2, 115, 101, 95), TArray<Byte>.Create(3, 111, 102, 32,
    34), TArray<Byte>.Create(3, 100, 105, 118, 244, 2, 114, 111, 115, 3, 101,
    114, 101, 160), Nil, TArray<Byte>.Create(2, 116, 97, 200, 1, 98, 90, 2, 115,
    105, 212), Nil, TArray<Byte>.Create(3, 97, 110, 100, 7, 2, 114, 115, 221),
    TArray<Byte>.Create(2, 114, 116, 242), TArray<Byte>.Create(2, 116, 101, 69),
    TArray<Byte>.Create(3, 97, 116, 105, 206), TArray<Byte>.Create(2, 115, 111,
    179), TArray<Byte>.Create(2, 116, 104, 17), TArray<Byte>.Create(2, 116, 105,
    74, 1, 99, 28, 3, 97, 108, 108, 112), TArray<Byte>.Create(3, 97, 116, 101,
    229), TArray<Byte>.Create(2, 115, 115, 166), TArray<Byte>.Create(2, 115,
    116, 77), Nil, TArray<Byte>.Create(2, 62, 60, 230),
    TArray<Byte>.Create(2, 116, 111, 20), TArray<Byte>.Create(3, 97, 114, 101,
    119), TArray<Byte>.Create(1, 100, 24), TArray<Byte>.Create(2, 116, 114,
    195), Nil, TArray<Byte>.Create(1, 10, 49, 3, 32, 97, 32, 146),
    TArray<Byte>.Create(3, 102, 32, 116, 118, 2, 118, 101, 111),
    TArray<Byte>.Create(2, 117, 110, 224), Nil, TArray<Byte>.Create(3, 101, 32,
    111, 162), TArray<Byte>.Create(2, 97, 32, 163, 2, 119, 97, 214, 1, 101, 2),
    TArray<Byte>.Create(2, 117, 114, 150, 3, 101, 32, 97, 188),
    TArray<Byte>.Create(2, 117, 115, 164, 3, 10, 13, 10, 167),
    TArray<Byte>.Create(2, 117, 116, 196, 3, 101, 32, 99, 251),
    TArray<Byte>.Create(2, 119, 101, 145), Nil, Nil, TArray<Byte>.Create(2, 119,
    104, 194), TArray<Byte>.Create(1, 102, 44), Nil, Nil, Nil,
    TArray<Byte>.Create(3, 100, 32, 116, 134), Nil, Nil,
    TArray<Byte>.Create(3, 116, 104, 32, 227), TArray<Byte>.Create(1, 103, 59),
    Nil, Nil, TArray<Byte>.Create(1, 13, 57, 3, 101, 32, 115, 181),
    TArray<Byte>.Create(3, 101, 32, 116, 156), Nil, TArray<Byte>.Create(3, 116,
    111, 32, 89), TArray<Byte>.Create(3, 101, 13, 10, 158),
    TArray<Byte>.Create(2, 100, 32, 30, 1, 104, 18), Nil,
    TArray<Byte>.Create(1, 44, 81), TArray<Byte>.Create(2, 32, 97, 25),
    TArray<Byte>.Create(2, 32, 98, 94), TArray<Byte>.Create(2, 13, 10, 21, 2,
    32, 99, 73), TArray<Byte>.Create(2, 32, 100, 165),
    TArray<Byte>.Create(2, 32, 101, 171), TArray<Byte>.Create(2, 32, 102, 104,
    1, 105, 8, 2, 101, 32, 11), Nil, TArray<Byte>.Create(2, 32, 104, 85, 1, 45,
    204), TArray<Byte>.Create(2, 32, 105, 56), Nil, Nil,
    TArray<Byte>.Create(2, 32, 108, 205), TArray<Byte>.Create(2, 32, 109, 123),
    TArray<Byte>.Create(2, 102, 32, 58, 2, 32, 110, 236),
    TArray<Byte>.Create(2, 32, 111, 29), TArray<Byte>.Create(2, 32, 112, 125, 1,
    46, 110, 3, 13, 10, 13, 168), Nil, TArray<Byte>.Create(2, 32, 114, 189),
    TArray<Byte>.Create(2, 32, 115, 62), TArray<Byte>.Create(2, 32, 116, 14),
    Nil, TArray<Byte>.Create(2, 103, 32, 157, 5, 119, 104, 105, 99, 104, 43, 3,
    119, 104, 105, 247), TArray<Byte>.Create(2, 32, 119, 53),
    TArray<Byte>.Create(1, 47, 197), TArray<Byte>.Create(3, 97, 115, 32, 140),
    TArray<Byte>.Create(3, 97, 116, 32, 135), Nil, TArray<Byte>.Create(3, 119,
    104, 111, 217), Nil, TArray<Byte>.Create(1, 108, 22, 2, 104, 32, 138), Nil,
    TArray<Byte>.Create(2, 44, 32, 36), Nil, TArray<Byte>.Create(4, 119, 105,
    116, 104, 86), Nil, Nil, Nil, TArray<Byte>.Create(1, 109, 45), Nil, Nil,
    TArray<Byte>.Create(2, 97, 99, 239), TArray<Byte>.Create(2, 97, 100, 232),
    TArray<Byte>.Create(3, 84, 104, 101, 72), Nil, Nil,
    TArray<Byte>.Create(4, 116, 104, 105, 115, 155, 1, 110, 9), Nil,
    TArray<Byte>.Create(2, 46, 32, 121), Nil, TArray<Byte>.Create(2, 97, 108,
    88, 3, 101, 44, 32, 245), TArray<Byte>.Create(3, 116, 105, 111, 141, 2, 98,
    101, 92), TArray<Byte>.Create(2, 97, 110, 26, 3, 118, 101, 114, 231), Nil,
    TArray<Byte>.Create(4, 116, 104, 97, 116, 48, 3, 116, 104, 97, 203, 1, 111,
    6), TArray<Byte>.Create(3, 119, 97, 115, 50), TArray<Byte>.Create(2, 97,
    114, 79), TArray<Byte>.Create(2, 97, 115, 46), TArray<Byte>.Create(2, 97,
    116, 39, 3, 116, 104, 101, 1, 4, 116, 104, 101, 121, 128, 5, 116, 104, 101,
    114, 101, 210, 5, 116, 104, 101, 105, 114, 100), TArray<Byte>.Create(2, 99,
    101, 136), TArray<Byte>.Create(4, 119, 101, 114, 101, 93), Nil,
    TArray<Byte>.Create(2, 99, 104, 153, 2, 108, 32, 180, 1, 112, 60), Nil, Nil,
    TArray<Byte>.Create(3, 111, 110, 101, 174), Nil, TArray<Byte>.Create(3, 104,
    101, 32, 19, 2, 100, 101, 106), TArray<Byte>.Create(3, 116, 101, 114, 184),
    TArray<Byte>.Create(2, 99, 111, 117), Nil, TArray<Byte>.Create(2, 98, 121,
    127, 2, 100, 105, 129, 2, 101, 97, 120), Nil, TArray<Byte>.Create(2, 101,
    99, 215), TArray<Byte>.Create(2, 101, 100, 66), TArray<Byte>.Create(2, 101,
    101, 235), Nil, Nil, TArray<Byte>.Create(1, 114, 12, 2, 110, 32, 41), Nil,
    Nil, Nil, TArray<Byte>.Create(2, 101, 108, 178), Nil,
    TArray<Byte>.Create(3, 105, 110, 32, 105, 2, 101, 110, 51), Nil,
    TArray<Byte>.Create(2, 111, 32, 96, 1, 115, 10), Nil,
    TArray<Byte>.Create(2, 101, 114, 27), TArray<Byte>.Create(3, 105, 115, 32,
    116, 2, 101, 115, 54), Nil, TArray<Byte>.Create(2, 103, 101, 249),
    TArray<Byte>.Create(4, 46, 99, 111, 109, 253), TArray<Byte>.Create(2, 102,
    111, 220, 3, 111, 117, 114, 216), TArray<Byte>.Create(3, 99, 104, 32, 193,
    1, 116, 3), TArray<Byte>.Create(2, 104, 97, 98), Nil,
    TArray<Byte>.Create(3, 109, 101, 110, 252), Nil, TArray<Byte>.Create(2, 104,
    101, 16), Nil, Nil, TArray<Byte>.Create(1, 117, 38),
    TArray<Byte>.Create(2, 104, 105, 102), Nil, TArray<Byte>.Create(3, 110, 111,
    116, 132, 2, 105, 99, 131), TArray<Byte>.Create(3, 101, 100, 32, 64, 2, 105,
    100, 237), Nil, Nil, TArray<Byte>.Create(2, 104, 111, 187),
    TArray<Byte>.Create(2, 114, 32, 75, 1, 118, 109), Nil, Nil, Nil,
    TArray<Byte>.Create(3, 116, 32, 116, 175, 2, 105, 108, 240),
    TArray<Byte>.Create(2, 105, 109, 226), TArray<Byte>.Create(3, 101, 110, 32,
    207, 2, 105, 110, 15), TArray<Byte>.Create(2, 105, 111, 144),
    TArray<Byte>.Create(2, 115, 32, 23, 1, 119, 65), Nil,
    TArray<Byte>.Create(3, 101, 114, 32, 124), TArray<Byte>.Create(3, 101, 115,
    32, 126, 2, 105, 115, 37), TArray<Byte>.Create(2, 105, 116, 47), Nil,
    TArray<Byte>.Create(2, 105, 118, 186), Nil, TArray<Byte>.Create(2, 116, 32,
    35, 7, 104, 116, 116, 112, 58, 47, 47, 67, 1, 120, 250),
    TArray<Byte>.Create(2, 108, 97, 137), TArray<Byte>.Create(1, 60, 225),
    TArray<Byte>.Create(3, 44, 32, 97, 148));

  (* Decode List
    000 = <space>                 051 = en                      102 = hi                      153 = ch                      204 = -
    001 = the                     052 = <space><space>          103 = from                    154 = had                     205 = <space>l
    002 = e                       053 = <space>w                104 = <space>f                155 = this                    206 = ati
    003 = t                       054 = es                      105 = in<space>               156 = e<space>t               207 = en<space>
    004 = a                       055 = <space>an               106 = de                      157 = g<space>                208 = pe
    005 = of                      056 = <space>i                107 = ion                     158 = e<cr><lf>               209 = <space>re
    006 = o                       057 = <cr>                    108 = me                      159 = <space>wh               210 = there
    007 = and                     058 = f<space>                109 = v                       160 = ere                     211 = ass
    008 = i                       059 = g                       110 = .                       161 = <space>co               212 = si
    009 = n                       060 = p                       111 = ve                      162 = e<space>o               213 = <space>fo
    010 = s                       061 = nd                      112 = all                     163 = a<space>                214 = wa
    011 = e<space>                062 = <space>s                113 = re<space>               164 = us                      215 = ec
    012 = r                       063 = nd<space>               114 = ri                      165 = <space>d                216 = our
    013 = <space>th               064 = ed<space>               115 = ro                      166 = ss                      217 = who
    014 = <space>t                065 = w                       116 = is<space>               167 = <lf><cr><lf>            218 = its
    015 = in                      066 = ed                      117 = co                      168 = <cr><lf><cr>            219 = z
    016 = he                      067 = http://                 118 = f<space>t               169 = ="                      220 = fo
    017 = th                      068 = for                     119 = are                     170 = <space>be               221 = rs
    018 = h                       069 = te                      120 = ea                      171 = <space>e                222 = >
    019 = he<space>               070 = ing                     121 = .<space>                172 = s<space>a               223 = ot
    020 = to                      071 = y<space>                122 = her                     173 = ma                      224 = un
    021 = <cr><lf>                072 = The                     123 = <space>m                174 = one                     225 = <
    022 = l                       073 = <space>c                124 = er<space>               175 = t<space>t               226 = im
    023 = s<space>                074 = ti                      125 = <space>p                176 = or<space>               227 = th<space>
    024 = d                       075 = r<space>                126 = es<space>               177 = but                     228 = nc
    025 = <space>a                076 = his                     127 = by                      178 = el                      229 = ate
    026 = an                      077 = st                      128 = they                    179 = so                      230 = ><
    027 = er                      078 = <space>in               129 = di                      180 = l<space>                231 = ver
    028 = c                       079 = ar                      130 = ra                      181 = e<space>s               232 = ad
    029 = <space>o                080 = nt                      131 = ic                      182 = s,                      233 = <space>we
    030 = d<space>                081 = ,                       132 = not                     183 = no                      234 = ly
    031 = on                      082 = <space>to               133 = s,<space>               184 = ter                     235 = ee
    032 = <space>of               083 = y                       134 = d<space>t               185 = <space>wa               236 = <space>n
    033 = re                      084 = ng                      135 = at<space>               186 = iv                      237 = id
    034 = of<space>               085 = <space>h                136 = ce                      187 = ho                      238 = <space>cl
    035 = t<space>                086 = with                    137 = la                      188 = e<space>a               239 = ac
    036 = ,<space>                087 = le                      138 = h<space>                189 = <space>r                240 = il
    037 = is                      088 = al                      139 = ne                      190 = hat                     241 = </
    038 = u                       089 = to<space>               140 = as<space>               191 = s<space>t               242 = rt
    039 = at                      090 = b                       141 = tio                     192 = ns                      243 = <space>wi
    040 = <space><space><space>   091 = ou                      142 = on<space>               193 = ch<space>               244 = div
    041 = n<space>                092 = be                      143 = n<space>t               194 = wh                      245 = e,<space>
    042 = or                      093 = were                    144 = io                      195 = tr                      246 = <space>it
    043 = which                   094 = <space>b                145 = we                      196 = ut                      247 = whi
    044 = f                       095 = se                      146 = <space>a<space>         197 = /                       248 = <space>ma
    045 = m                       096 = o<space>                147 = om                      198 = have                    249 = ge
    046 = as                      097 = ent                     148 = ,<space>a               199 = ly<space>               250 = x
    047 = it                      098 = ha                      149 = s<space>o               200 = ta                      251 = e<space>c
    048 = that                    099 = ng<space>               150 = ur                      201 = <space>ha               252 = men
    049 = <lf>                    100 = their                   151 = li                      202 = <space>on               253 = .com
    050 = was                     101 = "                       152 = ll                      203 = tha
  *)

  FdecoderLookup := TArray < TArray < Byte >> .Create(TArray<Byte>.Create(32),
    TArray<Byte>.Create(116, 104, 101), TArray<Byte>.Create(101),
    TArray<Byte>.Create(116), TArray<Byte>.Create(97),
    TArray<Byte>.Create(111, 102), TArray<Byte>.Create(111),
    TArray<Byte>.Create(97, 110, 100), TArray<Byte>.Create(105),
    TArray<Byte>.Create(110), TArray<Byte>.Create(115),
    TArray<Byte>.Create(101, 32), TArray<Byte>.Create(114),
    TArray<Byte>.Create(32, 116, 104), TArray<Byte>.Create(32, 116),
    TArray<Byte>.Create(105, 110), TArray<Byte>.Create(104, 101),
    TArray<Byte>.Create(116, 104), TArray<Byte>.Create(104),
    TArray<Byte>.Create(104, 101, 32), TArray<Byte>.Create(116, 111),
    TArray<Byte>.Create(13, 10), TArray<Byte>.Create(108),
    TArray<Byte>.Create(115, 32), TArray<Byte>.Create(100),
    TArray<Byte>.Create(32, 97), TArray<Byte>.Create(97, 110),
    TArray<Byte>.Create(101, 114), TArray<Byte>.Create(99),
    TArray<Byte>.Create(32, 111), TArray<Byte>.Create(100, 32),
    TArray<Byte>.Create(111, 110), TArray<Byte>.Create(32, 111, 102),
    TArray<Byte>.Create(114, 101), TArray<Byte>.Create(111, 102, 32),
    TArray<Byte>.Create(116, 32), TArray<Byte>.Create(44, 32),
    TArray<Byte>.Create(105, 115), TArray<Byte>.Create(117),
    TArray<Byte>.Create(97, 116), TArray<Byte>.Create(32, 32, 32),
    TArray<Byte>.Create(110, 32), TArray<Byte>.Create(111, 114),
    TArray<Byte>.Create(119, 104, 105, 99, 104), TArray<Byte>.Create(102),
    TArray<Byte>.Create(109), TArray<Byte>.Create(97, 115),
    TArray<Byte>.Create(105, 116), TArray<Byte>.Create(116, 104, 97, 116),
    TArray<Byte>.Create(10), TArray<Byte>.Create(119, 97, 115),
    TArray<Byte>.Create(101, 110), TArray<Byte>.Create(32, 32),
    TArray<Byte>.Create(32, 119), TArray<Byte>.Create(101, 115),
    TArray<Byte>.Create(32, 97, 110), TArray<Byte>.Create(32, 105),
    TArray<Byte>.Create(13), TArray<Byte>.Create(102, 32),
    TArray<Byte>.Create(103), TArray<Byte>.Create(112),
    TArray<Byte>.Create(110, 100), TArray<Byte>.Create(32, 115),
    TArray<Byte>.Create(110, 100, 32), TArray<Byte>.Create(101, 100, 32),
    TArray<Byte>.Create(119), TArray<Byte>.Create(101, 100),
    TArray<Byte>.Create(104, 116, 116, 112, 58, 47, 47),
    TArray<Byte>.Create(102, 111, 114), TArray<Byte>.Create(116, 101),
    TArray<Byte>.Create(105, 110, 103), TArray<Byte>.Create(121, 32),
    TArray<Byte>.Create(84, 104, 101), TArray<Byte>.Create(32, 99),
    TArray<Byte>.Create(116, 105), TArray<Byte>.Create(114, 32),
    TArray<Byte>.Create(104, 105, 115), TArray<Byte>.Create(115, 116),
    TArray<Byte>.Create(32, 105, 110), TArray<Byte>.Create(97, 114),
    TArray<Byte>.Create(110, 116), TArray<Byte>.Create(44),
    TArray<Byte>.Create(32, 116, 111), TArray<Byte>.Create(121),
    TArray<Byte>.Create(110, 103), TArray<Byte>.Create(32, 104),
    TArray<Byte>.Create(119, 105, 116, 104), TArray<Byte>.Create(108, 101),
    TArray<Byte>.Create(97, 108), TArray<Byte>.Create(116, 111, 32),
    TArray<Byte>.Create(98), TArray<Byte>.Create(111, 117),
    TArray<Byte>.Create(98, 101), TArray<Byte>.Create(119, 101, 114, 101),
    TArray<Byte>.Create(32, 98), TArray<Byte>.Create(115, 101),
    TArray<Byte>.Create(111, 32), TArray<Byte>.Create(101, 110, 116),
    TArray<Byte>.Create(104, 97), TArray<Byte>.Create(110, 103, 32),
    TArray<Byte>.Create(116, 104, 101, 105, 114), TArray<Byte>.Create(34),
    TArray<Byte>.Create(104, 105), TArray<Byte>.Create(102, 114, 111, 109),
    TArray<Byte>.Create(32, 102), TArray<Byte>.Create(105, 110, 32),
    TArray<Byte>.Create(100, 101), TArray<Byte>.Create(105, 111, 110),
    TArray<Byte>.Create(109, 101), TArray<Byte>.Create(118),
    TArray<Byte>.Create(46), TArray<Byte>.Create(118, 101),
    TArray<Byte>.Create(97, 108, 108), TArray<Byte>.Create(114, 101, 32),
    TArray<Byte>.Create(114, 105), TArray<Byte>.Create(114, 111),
    TArray<Byte>.Create(105, 115, 32), TArray<Byte>.Create(99, 111),
    TArray<Byte>.Create(102, 32, 116), TArray<Byte>.Create(97, 114, 101),
    TArray<Byte>.Create(101, 97), TArray<Byte>.Create(46, 32),
    TArray<Byte>.Create(104, 101, 114), TArray<Byte>.Create(32, 109),
    TArray<Byte>.Create(101, 114, 32), TArray<Byte>.Create(32, 112),
    TArray<Byte>.Create(101, 115, 32), TArray<Byte>.Create(98, 121),
    TArray<Byte>.Create(116, 104, 101, 121), TArray<Byte>.Create(100, 105),
    TArray<Byte>.Create(114, 97), TArray<Byte>.Create(105, 99),
    TArray<Byte>.Create(110, 111, 116), TArray<Byte>.Create(115, 44, 32),
    TArray<Byte>.Create(100, 32, 116), TArray<Byte>.Create(97, 116, 32),
    TArray<Byte>.Create(99, 101), TArray<Byte>.Create(108, 97),
    TArray<Byte>.Create(104, 32), TArray<Byte>.Create(110, 101),
    TArray<Byte>.Create(97, 115, 32), TArray<Byte>.Create(116, 105, 111),
    TArray<Byte>.Create(111, 110, 32), TArray<Byte>.Create(110, 32, 116),
    TArray<Byte>.Create(105, 111), TArray<Byte>.Create(119, 101),
    TArray<Byte>.Create(32, 97, 32), TArray<Byte>.Create(111, 109),
    TArray<Byte>.Create(44, 32, 97), TArray<Byte>.Create(115, 32, 111),
    TArray<Byte>.Create(117, 114), TArray<Byte>.Create(108, 105),
    TArray<Byte>.Create(108, 108), TArray<Byte>.Create(99, 104),
    TArray<Byte>.Create(104, 97, 100), TArray<Byte>.Create(116, 104, 105, 115),
    TArray<Byte>.Create(101, 32, 116), TArray<Byte>.Create(103, 32),
    TArray<Byte>.Create(101, 13, 10), TArray<Byte>.Create(32, 119, 104),
    TArray<Byte>.Create(101, 114, 101), TArray<Byte>.Create(32, 99, 111),
    TArray<Byte>.Create(101, 32, 111), TArray<Byte>.Create(97, 32),
    TArray<Byte>.Create(117, 115), TArray<Byte>.Create(32, 100),
    TArray<Byte>.Create(115, 115), TArray<Byte>.Create(10, 13, 10),
    TArray<Byte>.Create(13, 10, 13), TArray<Byte>.Create(61, 34),
    TArray<Byte>.Create(32, 98, 101), TArray<Byte>.Create(32, 101),
    TArray<Byte>.Create(115, 32, 97), TArray<Byte>.Create(109, 97),
    TArray<Byte>.Create(111, 110, 101), TArray<Byte>.Create(116, 32, 116),
    TArray<Byte>.Create(111, 114, 32), TArray<Byte>.Create(98, 117, 116),
    TArray<Byte>.Create(101, 108), TArray<Byte>.Create(115, 111),
    TArray<Byte>.Create(108, 32), TArray<Byte>.Create(101, 32, 115),
    TArray<Byte>.Create(115, 44), TArray<Byte>.Create(110, 111),
    TArray<Byte>.Create(116, 101, 114), TArray<Byte>.Create(32, 119, 97),
    TArray<Byte>.Create(105, 118), TArray<Byte>.Create(104, 111),
    TArray<Byte>.Create(101, 32, 97), TArray<Byte>.Create(32, 114),
    TArray<Byte>.Create(104, 97, 116), TArray<Byte>.Create(115, 32, 116),
    TArray<Byte>.Create(110, 115), TArray<Byte>.Create(99, 104, 32),
    TArray<Byte>.Create(119, 104), TArray<Byte>.Create(116, 114),
    TArray<Byte>.Create(117, 116), TArray<Byte>.Create(47),
    TArray<Byte>.Create(104, 97, 118, 101), TArray<Byte>.Create(108, 121, 32),
    TArray<Byte>.Create(116, 97), TArray<Byte>.Create(32, 104, 97),
    TArray<Byte>.Create(32, 111, 110), TArray<Byte>.Create(116, 104, 97),
    TArray<Byte>.Create(45), TArray<Byte>.Create(32, 108),
    TArray<Byte>.Create(97, 116, 105), TArray<Byte>.Create(101, 110, 32),
    TArray<Byte>.Create(112, 101), TArray<Byte>.Create(32, 114, 101),
    TArray<Byte>.Create(116, 104, 101, 114, 101), TArray<Byte>.Create(97, 115,
    115), TArray<Byte>.Create(115, 105), TArray<Byte>.Create(32, 102, 111),
    TArray<Byte>.Create(119, 97), TArray<Byte>.Create(101, 99),
    TArray<Byte>.Create(111, 117, 114), TArray<Byte>.Create(119, 104, 111),
    TArray<Byte>.Create(105, 116, 115), TArray<Byte>.Create(122),
    TArray<Byte>.Create(102, 111), TArray<Byte>.Create(114, 115),
    TArray<Byte>.Create(62), TArray<Byte>.Create(111, 116),
    TArray<Byte>.Create(117, 110), TArray<Byte>.Create(60),
    TArray<Byte>.Create(105, 109), TArray<Byte>.Create(116, 104, 32),
    TArray<Byte>.Create(110, 99), TArray<Byte>.Create(97, 116, 101),
    TArray<Byte>.Create(62, 60), TArray<Byte>.Create(118, 101, 114),
    TArray<Byte>.Create(97, 100), TArray<Byte>.Create(32, 119, 101),
    TArray<Byte>.Create(108, 121), TArray<Byte>.Create(101, 101),
    TArray<Byte>.Create(32, 110), TArray<Byte>.Create(105, 100),
    TArray<Byte>.Create(32, 99, 108), TArray<Byte>.Create(97, 99),
    TArray<Byte>.Create(105, 108), TArray<Byte>.Create(60, 47),
    TArray<Byte>.Create(114, 116), TArray<Byte>.Create(32, 119, 105),
    TArray<Byte>.Create(100, 105, 118), TArray<Byte>.Create(101, 44, 32),
    TArray<Byte>.Create(32, 105, 116), TArray<Byte>.Create(119, 104, 105),
    TArray<Byte>.Create(32, 109, 97), TArray<Byte>.Create(103, 101),
    TArray<Byte>.Create(120), TArray<Byte>.Create(101, 32, 99),
    TArray<Byte>.Create(109, 101, 110), TArray<Byte>.Create(46, 99, 111, 109));

{$ENDREGION}
end;

class function TSmaz.Compress(Input: TArray<Byte>): TArray<Byte>;
var
  buf, slot: TArray<Byte>;
  bufPos, inLen, inPos, verbPos, h1, h2, h3, j, slotPos, i: Integer;
  verbLen: Byte;
  found: Boolean;

begin
  // Output buffer
  SetLength(buf, Length(Input));
  bufPos := 0;
  inLen := Length(Input);
  inPos := 0;
  verbPos := 0;
  verbLen := 0;
  h3 := 0;

  // Loop through each input character
  while (inLen > 0) do
  begin
    j := 7;
    found := false;

    // Determine encoder lookup index
    h2 := Input[inPos] shl 3;
    h1 := h2;
    if (inLen > 1) then
    begin
      h2 := h2 + Input[inPos + 1];
    end;
    if (inLen > 2) then
    begin
      h3 := h2 xor Input[inPos + 2];
    end;
    if (j > inLen) then
    begin
      j := inLen;
    end;

    // Search for encoder words (from largest (7) to smallest (1))
    while j > 0 do
    begin
      // Fetch relevant encoder slot (based on word length (j) and input data (h1, h2, h3))
      case (j) of

        1:
          slot := FencoderLookup[h1 mod 241];

        2:
          slot := FencoderLookup[h2 mod 241];

      else
        slot := FencoderLookup[h3 mod 241];

      end;

      // Skip if slot is null
      if (slot <> Nil) then
      begin
        // Iterate through all slot word entries
        slotPos := 0;
        while (Length(slot) > slotPos) do
        begin
          // Check slot word length's match
          if (slot[slotPos] = j) then
          begin
            // Byte-wise compare slot word to input
            found := true;
            i := 0;
            while i < j do

            begin
              if (Input[inPos + i] <> slot[slotPos + i + 1]) then
              begin
                // Doesn't match, break and try next slot word
                found := false;
                break;
              end;
              Inc(i);
            end;

            if (found) then
            begin
              // Check if output buffer resize is required
              if ((bufPos + verbLen + 3) > Length(buf)) then
              begin
                SetLength(buf, Length(buf) * 2);
              end;

              // Write verbatim data (where no encoder word is available)
              if (verbLen > 0) then
              begin
                if (verbLen = 1) then
                begin
                  // Single byte, prefix with [254]
                  buf[bufPos] := 254;
                  Inc(bufPos);
                  buf[bufPos] := Input[verbPos];
                  Inc(bufPos);
                end
                else
                begin
                  // Multiple bytes, prefix with [255] and [length]
                  buf[bufPos] := 255;
                  Inc(bufPos);
                  buf[bufPos] := verbLen;
                  Inc(bufPos);
                  Move(Input[Length(Input) - inLen - verbLen],
                    buf[bufPos], verbLen);

                  // Did not use Move since it bypasses ref counting for "managed" types.
                  { CopyArray(@buf[bufPos],
                    @Input[Length(Input) - inLen - verbLen],
                    TypeInfo(TArray<Byte>), verbLen); }

                  bufPos := bufPos + verbLen;
                end;
              end;

              // Write encoded word index
              buf[bufPos] := slot[slot[slotPos] + slotPos + 1];
              Inc(bufPos);

              // Move input position forward (by the length of the encoded word)
              inLen := inLen - j;
              inPos := inPos + j;

              // Reset verbatim position (to the current input position)
              verbPos := inPos;
              verbLen := 0;

              // Found word, so break slot loop, and continue at new input position
              break;
            end;
          end;

          // Try next word in slot
          slotPos := slotPos + slot[slotPos] + 2;
        end;

        if (found) then
        begin
          // Word found, so break word-length loop, and continue at new input position
          break;
        end;
      end;

      Dec(j);
    end;

    if (not found) then
    begin
      // No encoder word was found, so increase verbatim length,
      // and continue at the new input position
      Inc(verbLen);
      Dec(inLen);
      Inc(inPos);
    end;

    // If verbatim length is maximum (255), or if the end is reached
    // then flush the verbatim data to the output buffer
    if ((verbLen = 255) or ((verbLen > 0) and (inLen = 0))) then
    begin
      // Check if output buffer resize is required
      if ((bufPos + verbLen + 2) > Length(buf)) then
      begin
        SetLength(buf, (Length(buf) * 2));
      end;

      // Write verbatim data to the output buffer
      if (verbLen = 1) then
      begin
        // Single byte, prefix with [254]
        buf[bufPos] := 254;
        Inc(bufPos);
        buf[bufPos] := Input[verbPos];
        Inc(bufPos);
      end

      else
      begin
        // Multiple bytes, prefix with [255] and [length]
        buf[bufPos] := 255;
        Inc(bufPos);
        buf[bufPos] := verbLen;
        Inc(bufPos);
        Move(Input[Length(Input) - inLen - verbLen], buf[bufPos], verbLen);

        // Did not use Move since it bypasses ref counting for "managed" types.
        { CopyArray(@buf[bufPos], @Input[Length(Input) - inLen - verbLen],
          TypeInfo(TArray<Byte>), verbLen); }
        bufPos := bufPos + verbLen;
      end;

      // Reset verbatim position (to the current input position)
      verbPos := inPos;
      verbLen := 0;
    end;
  end;

  // Size output buffer to final size
  if (bufPos <> Length(buf)) then
  begin
    SetLength(buf, bufPos);
  end;

  // Return output buffer
  result := buf;

end;

class function TSmaz.Compress(const Input: String): TArray<Byte>;
begin
  result := Compress(TEncoding.ASCII.GetBytes(Input));
end;

class function TSmaz.Decompress(Input: TArray<Byte>): String;
var
  output: TMemoryStream;
  i: Integer;
  w, tempArray: TArray<Byte>;
begin
  output := TMemoryStream.Create();
  try
    i := 0;
    while i < Length(Input) do
    begin
      case Input[i] of

        254:
          begin
            // Verbatim Byte
            output.Write(Input[i + 1], 1);
            Inc(i);
          end;

        255:
          begin
            // Verbatim Byte
            output.Write(Input, i + 2, Input[i + 1]);
            i := i + Input[i + 1] + 1;
          end;

      else
        begin
          // Write Encoded Byte
          w := FdecoderLookup[Input[i]];
          output.Write(w, 0, Length(w));

        end;

      end;
      Inc(i);
    end;
    output.Position := 0;
    SetLength(tempArray, output.Size);
    output.ReadBuffer(tempArray[0], output.Size);
    result := TEncoding.ASCII.GetString(tempArray);
  finally
    output.Free;
  end;
end;

end.
