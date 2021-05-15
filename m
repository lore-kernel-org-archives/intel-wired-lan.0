From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Sat, 15 May 2021 10:22:39 +0200
Subject: [Intel-wired-lan] [PATCH v2 00/40] Use ASCII subset instead of
 UTF-8 alternate symbols
In-Reply-To: <61c286b7afd6c4acf71418feee4eecca2e6c80c8.camel@infradead.org>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
 <d2fed242fbe200706b8d23a53512f0311d900297.camel@infradead.org>
 <20210514102118.1b71bec3@coco.lan>
 <61c286b7afd6c4acf71418feee4eecca2e6c80c8.camel@infradead.org>
Message-ID: <20210515102239.2ffd0451@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Em Fri, 14 May 2021 10:06:01 +0100
David Woodhouse <dwmw2@infradead.org> escreveu:

> On Fri, 2021-05-14 at 10:21 +0200, Mauro Carvalho Chehab wrote:
> > Em Wed, 12 May 2021 18:07:04 +0100
> > David Woodhouse <dwmw2@infradead.org> escreveu:
> >   
> > > On Wed, 2021-05-12 at 14:50 +0200, Mauro Carvalho Chehab wrote:  
> > > > Such conversion tools - plus some text editor like LibreOffice  or similar  - have
> > > > a set of rules that turns some typed ASCII characters into UTF-8 alternatives,
> > > > for instance converting commas into curly commas and adding non-breakable
> > > > spaces. All of those are meant to produce better results when the text is
> > > > displayed in HTML or PDF formats.    
> > > 
> > > And don't we render our documentation into HTML or PDF formats?   
> > 
> > Yes.
> >   
> > > Are
> > > some of those non-breaking spaces not actually *useful* for their
> > > intended purpose?  
> > 
> > No.
> > 
> > The thing is: non-breaking space can cause a lot of problems.
> > 
> > We even had to disable Sphinx usage of non-breaking space for
> > PDF outputs, as this was causing bad LaTeX/PDF outputs.
> > 
> > See, commit: 3b4c963243b1 ("docs: conf.py: adjust the LaTeX document output")
> > 
> > The afore mentioned patch disables Sphinx default behavior of
> > using NON-BREAKABLE SPACE on literal blocks and strings, using this
> > special setting: "parsedliteralwraps=true".
> > 
> > When NON-BREAKABLE SPACE were used on PDF outputs, several parts of 
> > the media uAPI docs were violating the document margins by far,
> > causing texts to be truncated.
> > 
> > So, please **don't add NON-BREAKABLE SPACE**, unless you test
> > (and keep testing it from time to time) if outputs on all
> > formats are properly supporting it on different Sphinx versions.  
> 
> And there you have a specific change with a specific fix. Nothing to do
> with whether NON-BREAKABLE SPACE is ? ASCII, and *certainly* nothing to
> do with the fact that, like *every* character in every kernel file
> except the *binary* files, it's representable in UTF-8.
> 
> By all means fix the specific characters which are typographically
> wrong or which, like NON-BREAKABLE SPACE, cause problems for rendering
> the documentation.
> 
> 
> > Also, most of those came from conversion tools, together with other
> > eccentricities, like the usage of U+FEFF (BOM) character at the
> > start of some documents. The remaining ones seem to came from 
> > cut-and-paste.  
> 
> ... or which are just entirely redundant and gratuitous, like a BOM in
> an environment where all files are UTF-8 and never 16-bit encodings
> anyway.

Agreed.

> 
> > > > While it is perfectly fine to use UTF-8 characters in Linux, and specially at
> > > > the documentation,  it is better to  stick to the ASCII subset  on such
> > > > particular case,  due to a couple of reasons:
> > > > 
> > > > 1. it makes life easier for tools like grep;    
> > > 
> > > Barely, as noted, because of things like line feeds.  
> > 
> > You can use grep with "-z" to seek for multi-line strings(*), Like:
> > 
> > 	$ grep -Pzl 'grace period started,\s*then' $(find Documentation/ -type f)
> > 	Documentation/RCU/Design/Data-Structures/Data-Structures.rst  
> 
> Yeah, right. That works if you don't just use the text that you'll have
> seen in the HTML/PDF "grace period started, then", and if you instead
> craft a *regex* for it, replacing the spaces with '\s*'. Or is that
> [[:space:]]* if you don't want to use the experimental Perl regex
> feature?
> 
>  $ grep -zlr 'grace[[:space:]]\+period[[:space:]]\+started,[[:space:]]\+then' Documentation/RCU
> Documentation/RCU/Design/Data-Structures/Data-Structures.rst
> 
> And without '-l' it'll obviously just give you the whole file. No '-A5
> -B5' to see the surroundings... it's hardly a useful thing, is it?
> 
> > (*) Unfortunately, while "git grep" also has a "-z" flag, it
> >     seems that this is (currently?) broken with regards of handling multilines:
> > 
> > 	$ git grep -Pzl 'grace period started,\s*then'
> > 	$  
> 
> Even better. So no, multiline grep isn't really a commonly usable
> feature at all.
> 
> This is why we prefer to put user-visible strings on one line in C
> source code, even if it takes the lines over 80 characters ? to allow
> for grep to find them.

Makes sense, but in case of documentation, this is a little more
complex than that. 

Btw, the theme used when building html by default[1] has a search
box (written in Javascript) that could be able to find multi-line
patterns, working somewhat similar to "git grep foo -a bar".

[1] https://github.com/readthedocs/sphinx_rtd_theme

> > [1] If I have a table with UTF-8 codes handy, I could type the UTF-8 
> >     number manually... However, it seems that this is currently broken 
> >     at least on Fedora 33 (with Mate Desktop and US intl keyboard with 
> >     dead keys).
> > 
> >     Here, <CTRL><SHIFT>U is not working. No idea why. I haven't 
> >     test it for *years*, as I din't see any reason why I would
> >     need to type UTF-8 characters by numbers until we started
> >     this thread.  
> 
> Please provide the bug number for this; I'd like to track it.

Just opened a BZ and added you as c/c.

> > Now, I'm not arguing that you can't use whatever UTF-8 symbol you
> > want on your docs. I'm just saying that, now that the conversion 
> > is over and a lot of documents ended getting some UTF-8 characters
> > by accident, it is time for a cleanup.  
> 
> All text documents are *full* of UTF-8 characters. If there is a file
> in the source code which has *any* non-UTF8, we call that a 'binary
> file'.
> 
> Again, if you want to make specific fixes like removing non-breaking
> spaces and byte order marks, with specific reasons, then those make
> sense. But it's got very little to do with UTF-8 and how easy it is to
> type them. And the excuse you've put in the commit comment for your
> patches is utterly bogus.

Let's take one step back, in order to return to the intents of this
UTF-8, as the discussions here are not centered into the patches, but
instead, on what to do and why.

-

This discussion started originally at linux-doc ML.

While discussing about an issue when machine's locale was not set
to UTF-8 on a build VM, we discovered that some converted docs ended
with BOM characters. Those specific changes were introduced by some
of my convert patches, probably converted via pandoc.

So, I went ahead in order to check what other possible weird things
were introduced by the conversion, where several scripts and tools
were used on files that had already a different markup.

I actually checked the current UTF-8 issues, and asked people at
linux-doc to comment what of those are valid usecases, and what
should be replaced by plain ASCII.

Basically, this is the current situation (at docs/docs-next), for the
ReST files under Documentation/, excluding translations is:

1. Spaces and BOM

	- U+00a0 ('?'): NO-BREAK SPACE
	- U+feff ('?'): ZERO WIDTH NO-BREAK SPACE (BOM)

Based on the discussions there and on this thread, those should be
dropped, as BOM is useless and NO-BREAK SPACE can cause problems
at the html/pdf output;

2. Symbols

	- U+00a9 ('?'): COPYRIGHT SIGN
	- U+00ac ('?'): NOT SIGN
	- U+00ae ('?'): REGISTERED SIGN
	- U+00b0 ('?'): DEGREE SIGN
	- U+00b1 ('?'): PLUS-MINUS SIGN
	- U+00b2 ('?'): SUPERSCRIPT TWO
	- U+00b5 ('?'): MICRO SIGN
	- U+03bc ('?'): GREEK SMALL LETTER MU
	- U+00b7 ('?'): MIDDLE DOT
	- U+00bd ('?'): VULGAR FRACTION ONE HALF
	- U+2122 ('?'): TRADE MARK SIGN
	- U+2264 ('?'): LESS-THAN OR EQUAL TO
	- U+2265 ('?'): GREATER-THAN OR EQUAL TO
	- U+2b0d ('?'): UP DOWN BLACK ARROW

Those seem OK on my eyes.

On a side note, both MICRO SIGN and GREEK SMALL LETTER MU are
used several docs to represent microseconds, micro-volts and
micro-amp?res. If we write an orientation document, it probably
makes sense to recommend using MICRO SIGN on such cases.

3. Latin

	- U+00c7 ('?'): LATIN CAPITAL LETTER C WITH CEDILLA
	- U+00df ('?'): LATIN SMALL LETTER SHARP S
	- U+00e1 ('?'): LATIN SMALL LETTER A WITH ACUTE
	- U+00e4 ('?'): LATIN SMALL LETTER A WITH DIAERESIS
	- U+00e6 ('?'): LATIN SMALL LETTER AE
	- U+00e7 ('?'): LATIN SMALL LETTER C WITH CEDILLA
	- U+00e9 ('?'): LATIN SMALL LETTER E WITH ACUTE
	- U+00ea ('?'): LATIN SMALL LETTER E WITH CIRCUMFLEX
	- U+00eb ('?'): LATIN SMALL LETTER E WITH DIAERESIS
	- U+00f3 ('?'): LATIN SMALL LETTER O WITH ACUTE
	- U+00f4 ('?'): LATIN SMALL LETTER O WITH CIRCUMFLEX
	- U+00f6 ('?'): LATIN SMALL LETTER O WITH DIAERESIS
	- U+00f8 ('?'): LATIN SMALL LETTER O WITH STROKE
	- U+00fa ('?'): LATIN SMALL LETTER U WITH ACUTE
	- U+00fc ('?'): LATIN SMALL LETTER U WITH DIAERESIS
	- U+00fd ('?'): LATIN SMALL LETTER Y WITH ACUTE
	- U+011f ('?'): LATIN SMALL LETTER G WITH BREVE
	- U+0142 ('?'): LATIN SMALL LETTER L WITH STROKE

Those should be kept as well, as they're used for non-English names.

4. arrows and box drawing symbols:
	- U+2191 ('?'): UPWARDS ARROW
	- U+2192 ('?'): RIGHTWARDS ARROW
	- U+2193 ('?'): DOWNWARDS ARROW

	- U+2500 ('?'): BOX DRAWINGS LIGHT HORIZONTAL
	- U+2502 ('?'): BOX DRAWINGS LIGHT VERTICAL
	- U+2514 ('?'): BOX DRAWINGS LIGHT UP AND RIGHT
	- U+251c ('?'): BOX DRAWINGS LIGHT VERTICAL AND RIGHT

Also should be kept.

In summary, based on the discussions we have so far, I suspect that
there's not much to be discussed for the above cases.

So, I'll post a v3 of this series, changing only:

	- U+00a0 ('?'): NO-BREAK SPACE
	- U+feff ('?'): ZERO WIDTH NO-BREAK SPACE (BOM)

---

Now, this specific patch series address also this extra case:

5. curly commas:

	- U+2018 ('?'): LEFT SINGLE QUOTATION MARK
	- U+2019 ('?'): RIGHT SINGLE QUOTATION MARK
	- U+201c ('?'): LEFT DOUBLE QUOTATION MARK
	- U+201d ('?'): RIGHT DOUBLE QUOTATION MARK

IMO, those should be replaced by ASCII commas: ' and ".

The rationale is simple: 

- most were introduced during the conversion from Docbook,
  markdown and LaTex;
- they don't add any extra value, as using "foo" of ?foo? means
  the same thing;
- Sphinx already use "fancy" commas at the output. 

I guess I will put this on a separate series, as this is not a bug
fix, but just a cleanup from the conversion work.

I'll re-post those cleanups on a separate series, for patch per patch
review.

---

The remaining cases are future work, outside the scope of this v2:

6. Hyphen/Dashes and ellipsis

	- U+2212 ('?'): MINUS SIGN
	- U+00ad ('?'): SOFT HYPHEN
	- U+2010 ('?'): HYPHEN

	    Those three are used on places where a normal ASCII hyphen/minus
	    should be used instead. There are even a couple of C files which
	    use them instead of '-' on comments.

	    IMO are fixes/cleanups from conversions and bad cut-and-paste.

	- U+2013 ('?'): EN DASH
	- U+2014 ('?'): EM DASH
	- U+2026 ('?'): HORIZONTAL ELLIPSIS

	    Those are auto-replaced by Sphinx from "--", "---" and "...",
	    respectively.

	    I guess those are a matter of personal preference about
	    weather using ASCII or UTF-8.

            My personal preference (and Ted seems to have a similar
	    opinion) is to let Sphinx do the conversion.

	    For those, I intend to post a separate series, to be
	    reviewed patch per patch, as this is really a matter
	    of personal taste. Hardly we'll reach a consensus here.

7. math symbols:

	- U+00d7 ('?'): MULTIPLICATION SIGN

	   This one is used mostly do describe video resolutions, but this is
	   on a smaller changeset than the ones that use "x" letter.

	- U+2217 ('?'): ASTERISK OPERATOR

	   This is used only here:
		Documentation/filesystems/ext4/blockgroup.rst:filesystem size to 2^21 ? 2^27 = 2^48bytes or 256TiB.

	   Probably added by some conversion tool. IMO, this one should
	   also be replaced by an ASCII asterisk.

I guess I'll post a patch for the ASTERISK OPERATOR.
Thanks,
Mauro
