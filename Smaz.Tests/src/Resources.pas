unit Resources;

interface

type

  TResources = class(TObject)

  strict private
    class constructor CreateResources();

  public const
    /// <summary>
    /// Character Set for Random Tests
    /// </summary>
    TestCharSet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvxyz/. ';

  class var
    /// <summary>
    /// Strings used for Testing
    /// </summary>
    FTestStrings: TArray<String>;
    /// <summary>
    /// Verified encoded data for TestStrings (from original C Smaz code)
    /// </summary>
    FTestStringsCompressed: TArray<TArray<Byte>>;

  end;

implementation

class constructor TResources.CreateResources();
begin
  FTestStrings := TArray<String>.Create('This is a small string', 'foobar',
    'the end', 'not-a-g00d-Exampl333', 'Smaz is a simple compression library',
    'Nothing is more difficult, and therefore more precious, than to be able to decide',
    'this is an example of what works very well with smaz',
    '1000 numbers 2000 will 10 20 30 compress very little',
    'and now a few italian sentences:',
    'Nel mezzo del cammin di nostra vita, mi ritrovai in una selva oscura',
    'Mi illumino di immenso', 'L''autore di questa libreria vive in Sicilia',
    'try it against urls', 'http://google.com', 'http://programming.reddit.com',
    'http://github.com/antirez/smaz/tree/master',
    '/media/hdb1/music/Alben/The Bla');

  FTestStringsCompressed := TArray < TArray < Byte >>
    .Create( (* 'This is a small string' *)
    TArray<Byte>.Create(254, 84, 76, 56, 172, 62, 173, 152, 62, 195, 70),
    (* 'foobar' *)
    TArray<Byte>.Create(220, 6, 90, 79),
    (* 'the end' *)
    TArray<Byte>.Create(1, 171, 61),
    (* 'not-a-g00d-Exampl333' *)
    TArray<Byte>.Create(132, 204, 4, 204, 59, 255, 2, 48, 48, 24, 204, 254, 69,
    250, 4, 45, 60, 22, 255, 3, 51, 51, 51),
    (* 'Smaz is a simple compression library' *)
    TArray<Byte>.Create(254, 83, 173, 219, 56, 172, 62, 226, 60, 87, 161, 45,
    60, 33, 166, 107, 205, 8, 90, 130, 12, 83),
    (* 'Nothing is more difficult, and therefore more precious, than to be able to decide' *)
    TArray<Byte>.Create(254, 78, 223, 102, 99, 116, 45, 42, 11, 129, 44, 44,
    131, 38, 22, 3, 148, 63, 210, 68, 11, 45, 42, 11, 60, 33, 28, 144, 164, 36,
    203, 143, 96, 92, 25, 90, 87, 82, 165, 215, 237, 2),
    (* 'this is an example of what works very well with smaz' *)
    TArray<Byte>.Create(155, 56, 172, 41, 2, 250, 4, 45, 60, 87, 32, 159, 135,
    65, 42, 254, 107, 23, 231, 71, 145, 152, 243, 227, 10, 173, 219),
    (* '1000 numbers 2000 will 10 20 30 compress very little' *)
    TArray<Byte>.Create(255, 4, 49, 48, 48, 48, 236, 38, 45, 92, 221, 0, 255, 4,
    50, 48, 48, 48, 243, 152, 0, 255, 2, 49, 48, 0, 255, 2, 50, 48, 0, 255, 2,
    51, 48, 161, 45, 60, 33, 166, 0, 231, 71, 151, 3, 3, 87),
    (* 'and now a few italian sentences:' *)
    TArray<Byte>.Create(7, 236, 6, 65, 146, 44, 2, 65, 246, 88, 8, 26, 62, 97,
    51, 136, 10, 254, 58),
    (* 'Nel mezzo del cammin di nostra vita, mi ritrovai in una selva oscura' *)
    TArray<Byte>.Create(254, 78, 178, 123, 2, 219, 219, 96, 106, 180, 28, 4, 45,
    45, 105, 129, 236, 6, 77, 130, 0, 109, 47, 4, 36, 45, 8, 189, 47, 115, 109,
    4, 8, 78, 0, 224, 163, 95, 22, 109, 163, 6, 10, 28, 150, 4),
    (* 'Mi illumino di immenso' *)
    TArray<Byte>.Create(254, 77, 8, 56, 152, 38, 45, 15, 96, 129, 56, 45,
    252, 179),
    (* 'L'autore di questa libreria vive in Sicilia' *)
    TArray<Byte>.Create(255, 2, 76, 39, 4, 196, 42, 11, 129, 0, 254, 113, 38,
    54, 200, 205, 8, 90, 33, 114, 163, 109, 186, 11, 105, 254, 83, 131,
    240, 8, 4),
    (* 'try it against urls' *)
    TArray<Byte>.Create(195, 71, 47, 25, 59, 4, 15, 77, 0, 150, 22, 10),
    (* 'http://google.com' *)
    TArray<Byte>.Create(67, 59, 6, 6, 59, 87, 253),
    (* 'http://programming.reddit.com' *)
    TArray<Byte>.Create(67, 60, 115, 59, 130, 45, 45, 70, 110, 33, 24,
    129, 3, 253),
    (* 'http://github.com/antirez/smaz/tree/master' *)
    TArray<Byte>.Create(67, 59, 47, 18, 38, 90, 253, 197, 26, 74, 33, 219, 197,
    10, 173, 219, 197, 195, 235, 197, 173, 77, 27),
    (* '/media/hdb1/music/Alben/The Bla' *)
    TArray<Byte>.Create(197, 108, 129, 4, 197, 18, 24, 90, 254, 49, 197, 45,
    164, 131, 197, 254, 65, 22, 92, 9, 197, 72, 0, 254, 66, 137));
end;

end.
