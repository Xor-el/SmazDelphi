SmazDelphi - Delphi Compression For Very Small Strings
-------------------------------------------------

*based on [SmazSharp](https://github.com/garysharp/SmazSharp) -  CSharp implementation by Gary Sharp*

SmazDelphi is a simple compression library suitable for compressing very short
strings. General purpose compression libraries will build the state needed
for compressing data dynamically, in order to be able to compress every kind
of data. This is a very good idea, but not for a specific problem: compressing
small strings will not work.

SmazDelphi instead is not good for compressing general purpose data, but can compress
text by 40-50% in the average case (works better with English), and is able to
perform a bit of compression for HTML and urls as well. The important point is
that Smaz is able to compress even strings of two or three bytes!

For example the string "the" is compressed into a single byte.

To compare this with other libraries, think that like zlib will usually not be able to compress text shorter than 100 bytes.

COMPRESSION EXAMPLES
--------------------

- 'This is a small string' compressed by 50%
- 'foobar' compressed by 34%
- 'the end' compressed by 58%
- 'not-a-g00d-Exampl333' enlarged by 15%
- 'Smaz is a simple compression library' compressed by 39%
- 'Nothing is more difficult, and therefore more precious, than to be able to decide' compressed by 49%
- 'this is an example of what works very well with smaz' compressed by 49%
- '1000 numbers 2000 will 10 20 30 compress very little' compressed by 10%

In general, lowercase English will work very well. It will degrade with a lot
of numbers inside the strings. Other languages are compressed pretty well too,
the following is Italian, not very similar to English but still compressible
by SmazDelphi:

- 'Nel mezzo del cammin di nostra vita, mi ritrovai in una selva oscura' compressed by 33%
- 'Mi illumino di immenso' compressed by 37%
- 'L'autore di questa libreria vive in Sicilia' compressed by 28%

It can compress URLS pretty well:

- 'http://google.com' compressed by 59%
- 'http://programming.reddit.com' compressed by 52%
- 'http://github.com/antirez/smaz/tree/master' compressed by 46%

USAGE
-----

The library consists of two primary functions:

```pascal
class function TSmaz.Compress(const Input: String): TArray<Byte>;
```

Compress the `Input` string and return the compressed data in a byte array.

```pascal
class function TSmaz.Decompress(Input: TArray<Byte>): String;
```

Decompress the `Input` byte array and return the decompressed data as a string.


###Unit Tests

    Unit Tests can be found in Smaz.Tests Folder.
    The unit tests makes use of DUnitX and TestInsight.

###License

This "Software" is Licensed Under  **`MIT License (MIT)`** .

#### Tip Jar
* :dollar: **Bitcoin**: `1MhFfW7tDuEHQSgie65uJcAfJgCNchGeKf`
* :euro: **Ethereum**: `0x6c1DC21aeC49A822A4f1E3bf07c623C2C1978a98`
* :pound: **Pascalcoin**: `345367-40`

###Conclusion


   Special Thanks to [Gary Sharp](https://github.com/garysharp/) for [this](https://github.com/garysharp/SmazSharp) awesome library.
(Thanks to the developers of [DUnitX Testing Framework](https://github.com/VSoftTechnologies/DUnitX/) and [TestInsight](https://bitbucket.org/sglienke/testinsight/wiki/Home/) for making tools that simplifies unit testing.
