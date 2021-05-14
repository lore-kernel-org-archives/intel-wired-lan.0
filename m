From: David Woodhouse <dwmw2@infradead.org>
Date: Fri, 14 May 2021 10:06:01 +0100
Subject: [Intel-wired-lan] [PATCH v2 00/40] Use ASCII subset instead of
 UTF-8 alternate symbols
In-Reply-To: <20210514102118.1b71bec3@coco.lan>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
 <d2fed242fbe200706b8d23a53512f0311d900297.camel@infradead.org>
 <20210514102118.1b71bec3@coco.lan>
Message-ID: <61c286b7afd6c4acf71418feee4eecca2e6c80c8.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2021-05-14 at 10:21 +0200, Mauro Carvalho Chehab wrote:
> Em Wed, 12 May 2021 18:07:04 +0100
> David Woodhouse <dwmw2@infradead.org> escreveu:
> 
> > On Wed, 2021-05-12 at 14:50 +0200, Mauro Carvalho Chehab wrote:
> > > Such conversion tools - plus some text editor like LibreOffice  or similar  - have
> > > a set of rules that turns some typed ASCII characters into UTF-8 alternatives,
> > > for instance converting commas into curly commas and adding non-breakable
> > > spaces. All of those are meant to produce better results when the text is
> > > displayed in HTML or PDF formats.  
> > 
> > And don't we render our documentation into HTML or PDF formats? 
> 
> Yes.
> 
> > Are
> > some of those non-breaking spaces not actually *useful* for their
> > intended purpose?
> 
> No.
> 
> The thing is: non-breaking space can cause a lot of problems.
> 
> We even had to disable Sphinx usage of non-breaking space for
> PDF outputs, as this was causing bad LaTeX/PDF outputs.
> 
> See, commit: 3b4c963243b1 ("docs: conf.py: adjust the LaTeX document output")
> 
> The afore mentioned patch disables Sphinx default behavior of
> using NON-BREAKABLE SPACE on literal blocks and strings, using this
> special setting: "parsedliteralwraps=true".
> 
> When NON-BREAKABLE SPACE were used on PDF outputs, several parts of 
> the media uAPI docs were violating the document margins by far,
> causing texts to be truncated.
> 
> So, please **don't add NON-BREAKABLE SPACE**, unless you test
> (and keep testing it from time to time) if outputs on all
> formats are properly supporting it on different Sphinx versions.

And there you have a specific change with a specific fix. Nothing to do
with whether NON-BREAKABLE SPACE is ? ASCII, and *certainly* nothing to
do with the fact that, like *every* character in every kernel file
except the *binary* files, it's representable in UTF-8.

By all means fix the specific characters which are typographically
wrong or which, like NON-BREAKABLE SPACE, cause problems for rendering
the documentation.


> Also, most of those came from conversion tools, together with other
> eccentricities, like the usage of U+FEFF (BOM) character at the
> start of some documents. The remaining ones seem to came from 
> cut-and-paste.

... or which are just entirely redundant and gratuitous, like a BOM in
an environment where all files are UTF-8 and never 16-bit encodings
anyway.

> > > While it is perfectly fine to use UTF-8 characters in Linux, and specially at
> > > the documentation,  it is better to  stick to the ASCII subset  on such
> > > particular case,  due to a couple of reasons:
> > > 
> > > 1. it makes life easier for tools like grep;  
> > 
> > Barely, as noted, because of things like line feeds.
> 
> You can use grep with "-z" to seek for multi-line strings(*), Like:
> 
> 	$ grep -Pzl 'grace period started,\s*then' $(find Documentation/ -type f)
> 	Documentation/RCU/Design/Data-Structures/Data-Structures.rst

Yeah, right. That works if you don't just use the text that you'll have
seen in the HTML/PDF "grace period started, then", and if you instead
craft a *regex* for it, replacing the spaces with '\s*'. Or is that
[[:space:]]* if you don't want to use the experimental Perl regex
feature?

 $ grep -zlr 'grace[[:space:]]\+period[[:space:]]\+started,[[:space:]]\+then' Documentation/RCU
Documentation/RCU/Design/Data-Structures/Data-Structures.rst

And without '-l' it'll obviously just give you the whole file. No '-A5
-B5' to see the surroundings... it's hardly a useful thing, is it?

> (*) Unfortunately, while "git grep" also has a "-z" flag, it
>     seems that this is (currently?) broken with regards of handling multilines:
> 
> 	$ git grep -Pzl 'grace period started,\s*then'
> 	$

Even better. So no, multiline grep isn't really a commonly usable
feature at all.

This is why we prefer to put user-visible strings on one line in C
source code, even if it takes the lines over 80 characters ? to allow
for grep to find them.

> > > 2. they easier to edit with the some commonly used text/source
> > >    code editors.  
> > 
> > That is nonsense. Any but the most broken and/or anachronistic
> > environments and editors will be just fine.
> 
> Not really.
> 
> I do use a lot of UTF-8 here, as I type texts in Portuguese, but I rely
> on the US-intl keyboard settings, that allow me to type as "'a" for ?.
> However, there's no shortcut for non-Latin UTF-codes, as far as I know.
> 
> So, if would need to type a curly comma on the text editors I normally 
> use for development (vim, nano, kate), I would need to cut-and-paste
> it from somewhere[1].

That's entirely irrelevant. You don't need to be able to *type* every
character that you see in front of you, as long as your editor will
render it correctly and perhaps let you cut/paste it as you're editing
the document if you're moving things around.

> [1] If I have a table with UTF-8 codes handy, I could type the UTF-8 
>     number manually... However, it seems that this is currently broken 
>     at least on Fedora 33 (with Mate Desktop and US intl keyboard with 
>     dead keys).
> 
>     Here, <CTRL><SHIFT>U is not working. No idea why. I haven't 
>     test it for *years*, as I din't see any reason why I would
>     need to type UTF-8 characters by numbers until we started
>     this thread.

Please provide the bug number for this; I'd like to track it.

> But even in the best case scenario where I know the UTF-8 and
> <CTRL><SHIFT>U works, if I wanted to use, for instance, a curly
> comma, the keystroke sequence would be:
> 
> 	<CTRL><SHIFT>U201csome string<CTRL><SHIFT>U201d
> 
> That's a lot harder than typing and has a higher chances of
> mistakenly add a wrong symbol than just typing:
> 
> 	"some string"
> 
> Knowing that both will produce *exactly* the same output, why
> should I bother doing it the hard way?

Nobody's asked you to do it the "hard way". That's completely
irrelevant to the discussion we were having.

> Now, I'm not arguing that you can't use whatever UTF-8 symbol you
> want on your docs. I'm just saying that, now that the conversion 
> is over and a lot of documents ended getting some UTF-8 characters
> by accident, it is time for a cleanup.

All text documents are *full* of UTF-8 characters. If there is a file
in the source code which has *any* non-UTF8, we call that a 'binary
file'.

Again, if you want to make specific fixes like removing non-breaking
spaces and byte order marks, with specific reasons, then those make
sense. But it's got very little to do with UTF-8 and how easy it is to
type them. And the excuse you've put in the commit comment for your
patches is utterly bogus.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5174 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210514/7dc14634/attachment-0001.bin>
