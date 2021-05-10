From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Mon, 10 May 2021 13:55:18 +0200
Subject: [Intel-wired-lan] [PATCH 00/53] Get rid of UTF-8 chars that can
 be mapped as ASCII
In-Reply-To: <2ae366fdff4bd5910a2270823e8da70521c859af.camel@infradead.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
 <2ae366fdff4bd5910a2270823e8da70521c859af.camel@infradead.org>
Message-ID: <20210510135518.305cc03d@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi David,

Em Mon, 10 May 2021 11:54:02 +0100
David Woodhouse <dwmw2@infradead.org> escreveu:

> On Mon, 2021-05-10 at 12:26 +0200, Mauro Carvalho Chehab wrote:
> > There are several UTF-8 characters at the Kernel's documentation.
> > 
> > Several of them were due to the process of converting files from
> > DocBook, LaTeX, HTML and Markdown. They were probably introduced
> > by the conversion tools used on that time.
> > 
> > Other UTF-8 characters were added along the time, but they're easily
> > replaceable by ASCII chars.
> > 
> > As Linux developers are all around the globe, and not everybody has UTF-8
> > as their default charset, better to use UTF-8 only on cases where it is really
> > needed.  
> 
> No, that is absolutely the wrong approach.
> 
> If someone has a local setup which makes bogus assumptions about text
> encodings, that is their own mistake.
> 
> We don't do them any favours by trying to *hide* it in the common case
> so that they don't notice it for longer.
> 
> There really isn't much excuse for such brokenness, this far into the
> 21st century.
> 
> Even *before* UTF-8 came along in the final decade of the last
> millennium, it was important to know which character set a given piece
> of text was encoded in.
> 
> In fact it was even *more* important back then, we couldn't just assume
> UTF-8 everywhere like we can in modern times.
> 
> Git can already do things like CRLF conversion on checking files out to
> match local conventions; if you want to teach it to do character set
> conversions too then I suppose that might be useful to a few developers
> who've fallen through a time warp and still need it. But nobody's ever
> bothered before because it just isn't necessary these days.
> 
> Please *don't* attempt to address this anachronistic and esoteric
> "requirement" by dragging the kernel source back in time by three
> decades.

No. The idea is not to go back three decades ago. 

The goal is just to avoid use UTF-8 where it is not needed. See, the vast
majority of UTF-8 chars are kept:

	- Non-ASCII Latin and Greek chars;
	- Box drawings;
	- arrows;
	- most symbols.

There, it makes perfect sense to keep using UTF-8.

We should keep using UTF-8 on Kernel. This is something that it shouldn't
be changed.

---

This patch series is doing conversion only when using ASCII makes
more sense than using UTF-8. 

See, a number of converted documents ended with weird characters
like ZERO WIDTH NO-BREAK SPACE (U+FEFF) character. This specific
character doesn't do any good.

Others use NO-BREAK SPACE (U+A0) instead of 0x20. Harmless, until
someone tries to use grep[1].

[1] try to run:

    $ git grep "CPU 0 has been" Documentation/RCU/

    it will return nothing with current upstream.

    But it will work fine after the series is applied:

    $ git grep "CPU 0 has been" Documentation/RCU/
      Documentation/RCU/Design/Data-Structures/Data-Structures.rst:| #. CPU 0 has been in dyntick-idle mode for quite some time. When it   |
      Documentation/RCU/Design/Data-Structures/Data-Structures.rst:|    notices that CPU 0 has been in dyntick idle mode, which qualifies  |

The main point on this series is to replace just the occurrences
where ASCII represents the symbol equally well, e. g. it is limited
for those chars:

	- U+2010 ('?'): HYPHEN
	- U+00ad ('?'): SOFT HYPHEN
	- U+2013 ('?'): EN DASH
	- U+2014 ('?'): EM DASH

	- U+2018 ('?'): LEFT SINGLE QUOTATION MARK
	- U+2019 ('?'): RIGHT SINGLE QUOTATION MARK
	- U+00b4 ('?'): ACUTE ACCENT

	- U+201c ('?'): LEFT DOUBLE QUOTATION MARK
	- U+201d ('?'): RIGHT DOUBLE QUOTATION MARK

	- U+00d7 ('?'): MULTIPLICATION SIGN
	- U+2212 ('?'): MINUS SIGN

	- U+2217 ('?'): ASTERISK OPERATOR
	  (this one used as a pointer reference like "*foo" on C code
	   example inside a document converted from LaTeX)

	- U+00bb ('?'): RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
	  (this one also used wrongly on an ABI file, meaning '>')

	- U+00a0 ('?'): NO-BREAK SPACE
	- U+feff ('?'): ZERO WIDTH NO-BREAK SPACE

Using the above symbols will just trick tools like grep for no good
reason.

Thanks,
Mauro
