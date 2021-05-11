From: David Woodhouse <dwmw2@infradead.org>
Date: Tue, 11 May 2021 10:19:40 +0100
Subject: [Intel-wired-lan] [PATCH 00/53] Get rid of UTF-8 chars that can
 be mapped as ASCII
In-Reply-To: <20210511110002.2f187f01@coco.lan>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
 <2ae366fdff4bd5910a2270823e8da70521c859af.camel@infradead.org>
 <20210510135518.305cc03d@coco.lan>
 <df6b4567-030c-a480-c5a6-fe579830e8c0@gmail.com>
 <YJk8LMFViV7Z3Uu7@casper.infradead.org>
 <ed65025c-1087-9672-7451-6d28e7ab8f92@gmail.com>
 <20210511110002.2f187f01@coco.lan>
Message-ID: <899f0da2727a131c3216ad0e03e9380b33b2d4ad.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2021-05-11 at 11:00 +0200, Mauro Carvalho Chehab wrote:
> Yet, this series has two positive side effects:
> 
>  - it helps people needing to touch the documents using non-utf8 locales[1];
>  - it makes easier to grep for a text;
> 
> [1] There are still some widely used distros nowadays (LTS ones?) that
>     don't set UTF-8 as default. Last time I installed a Debian machine
>     I had to explicitly set UTF-8 charset after install as the default
>     were using ASCII encoding (can't remember if it was Debian 10 or an
>     older version).

This whole line of thinking is fundamentally wrong.

A given set of characters in a "text file" are encoded with a specific
character set / encoding. To interpret that file and convert the bytes
back to characters, we need to use the *same* charset.

That charset is a property of the text file, and each text file or
piece of text in a system (like this email, which will contain a
Content-Type: header indicating the charset) might be encoded with a
*different* character set.

In the days before you could connect computers together ? or before you
could exchange data between computers in different countries, at least
? perhaps it made sense to store 'text' files without explicitly noting
their encoding. And to interpret them using some kind of "default"
character set.

Those days are long gone. You're trying to work around an egregiously
stupid bug, if you're trying to pander to "default" encodings. There
*is* no default encoding that even makes sense, except perhaps UTF-8.
To *speak* of them as you did shows a misunderstanding of how broken
they are. It's *precisely* that kind of half-baked thinking which
always used to lead to stupid assumptions and double conversions and
Mojibake. Before we just standardised on UTF-8 everywhere and it
stopped mattering so much.

Just don't.

Now, you *can* make this work if you really insist on it, even for
systems with EBCDIC as their default encoding. Just make git do the
"convert to local charset" on checkout, precisely the same way as it
does CRLF for Windows systems. But it's stupid and anachronistic, so I
don't really see the point.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5174 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210511/acf24092/attachment-0001.bin>
