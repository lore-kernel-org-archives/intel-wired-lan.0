From: David Woodhouse <dwmw2@infradead.org>
Date: Mon, 10 May 2021 11:54:02 +0100
Subject: [Intel-wired-lan] [PATCH 00/53] Get rid of UTF-8 chars that can
 be mapped as ASCII
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
Message-ID: <2ae366fdff4bd5910a2270823e8da70521c859af.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-05-10 at 12:26 +0200, Mauro Carvalho Chehab wrote:
> There are several UTF-8 characters at the Kernel's documentation.
> 
> Several of them were due to the process of converting files from
> DocBook, LaTeX, HTML and Markdown. They were probably introduced
> by the conversion tools used on that time.
> 
> Other UTF-8 characters were added along the time, but they're easily
> replaceable by ASCII chars.
> 
> As Linux developers are all around the globe, and not everybody has UTF-8
> as their default charset, better to use UTF-8 only on cases where it is really
> needed.

No, that is absolutely the wrong approach.

If someone has a local setup which makes bogus assumptions about text
encodings, that is their own mistake.

We don't do them any favours by trying to *hide* it in the common case
so that they don't notice it for longer.

There really isn't much excuse for such brokenness, this far into the
21st century.

Even *before* UTF-8 came along in the final decade of the last
millennium, it was important to know which character set a given piece
of text was encoded in.

In fact it was even *more* important back then, we couldn't just assume
UTF-8 everywhere like we can in modern times.

Git can already do things like CRLF conversion on checking files out to
match local conventions; if you want to teach it to do character set
conversions too then I suppose that might be useful to a few developers
who've fallen through a time warp and still need it. But nobody's ever
bothered before because it just isn't necessary these days.

Please *don't* attempt to address this anachronistic and esoteric
"requirement" by dragging the kernel source back in time by three
decades.


-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5174 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210510/66ecbb60/attachment-0001.bin>
