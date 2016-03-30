unit ComplianceTests;

interface

uses
  DUnitX.TestFramework, System.SysUtils, uSmaz, Resources;

type

  [TestFixture]
  TComplianceTests = class(TObject)
  public
    [Test]
    /// <summary>
    /// Tests SmazDelphi Compression (against original C implementation)
    /// </summary>
    procedure CompressTest();
    [Test]
    /// <summary>
    /// Tests SmazDelphi Decompression (against original C implementation)
    /// </summary>
    procedure DecompressTest();
    [Test]
    /// <summary>
    /// Tests that 100 random strings compress/decompress successfully
    /// </summary>
    procedure RandomTest();
  end;

implementation

procedure TComplianceTests.CompressTest();
var
  i, c: Integer;
  Test: String;
  compressedOk, compressedTest: TArray<Byte>;

begin
  for i := 0 to Pred(Length(TResources.FTestStrings)) do
  begin
    Test := TResources.FTestStrings[i];
    compressedOk := TResources.FTestStringsCompressed[i];
    compressedTest := TSmaz.Compress(Test);

    // Compare Length
    if (Length(compressedOk) <> Length(compressedTest)) then
      Assert.Fail(Format('Compression failed for: "%s"', [Test]));

    // Compare Data
    for c := 0 to Pred(Length(compressedOk)) do
    begin
      if (compressedOk[c] <> compressedTest[c]) then
        Assert.Fail(Format('Compression failed for: "%s"', [Test]));
    end;
  end;
end;

procedure TComplianceTests.DecompressTest();
var
  i: Integer;
  Test: TArray<Byte>;
  decompressedOk, decompressedTest: String;

begin
  for i := 0 to Pred(Length(TResources.FTestStringsCompressed)) do
  begin
    Test := TResources.FTestStringsCompressed[i];
    decompressedOk := TResources.FTestStrings[i];
    decompressedTest := TSmaz.Decompress(Test);

    Assert.AreEqual(decompressedOk, decompressedTest,
      Format('Decompression failed for: "%s"', [decompressedOk]));

  end;
end;

procedure TComplianceTests.RandomTest();
var
  charset, decompressed: String;
  Test: TStringBuilder;
  cycle, i, _length: Integer;
  compressed: TArray<Byte>;
begin
  Randomize;
  charset := TResources.TestCharSet;
  Test := TStringBuilder.Create(512);
  try
    cycle := 0;
    while cycle < 10 do
    begin
      i := 0;
      while i < 1000 do
      begin
        Test.Clear();
        _length := Random(512);

        while (_length > 0) do
        begin
          Test.Append(charset, Random(Length(charset)), 1);
          Dec(_length);
        end;

        compressed := TSmaz.Compress(Test.ToString());
        decompressed := TSmaz.Decompress(compressed);

        Assert.AreEqual(Test.ToString(), decompressed,
          Format('Random failed for: "%s"', [Test.ToString()]));

        Inc(i);
      end;

      Inc(cycle);
    end;

  finally
    Test.Free;
  end;
end;

initialization

TDUnitX.RegisterTestFixture(TComplianceTests);

end.
