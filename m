From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Sat, 15 May 2021 13:23:44 +0200
Subject: [Intel-wired-lan] [PATCH v2 00/40] Use ASCII subset instead of
 UTF-8 alternate symbols
In-Reply-To: <c2a4cb8457823685ecba6833d57047d059b36fbb.camel@infradead.org>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
 <d2fed242fbe200706b8d23a53512f0311d900297.camel@infradead.org>
 <20210514102118.1b71bec3@coco.lan>
 <61c286b7afd6c4acf71418feee4eecca2e6c80c8.camel@infradead.org>
 <20210515102239.2ffd0451@coco.lan>
 <c2a4cb8457823685ecba6833d57047d059b36fbb.camel@infradead.org>
Message-ID: <20210515132344.0206c8fc@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Em Sat, 15 May 2021 10:24:28 +0100
David Woodhouse <dwmw2@infradead.org> escreveu:

> On Sat, 2021-05-15 at 10:22 +0200, Mauro Carvalho Chehab wrote:
> > > >      Here, <CTRL><SHIFT>U is not working. No idea why. I haven't 
> > > >      test it for *years*, as I din't see any reason why I would
> > > >      need to type UTF-8 characters by numbers until we started
> > > >      this thread.    
> > > 
> > > Please provide the bug number for this; I'd like to track it.  
> > 
> > Just opened a BZ and added you as c/c.  
> 
> Thanks.
> 
> > Let's take one step back, in order to return to the intents of this
> > UTF-8, as the discussions here are not centered into the patches, but
> > instead, on what to do and why.
> > 
> > -
> > 
> > This discussion started originally at linux-doc ML.
> > 
> > While discussing about an issue when machine's locale was not set
> > to UTF-8 on a build VM,   
> 
> Stop. Stop *right* there before you go any further.
> 
> The machine's locale should have *nothing* to do with anything.
> 
> When you view this email, it comes with a Content-Type: header which
> explicitly tells you the character set that the message is encoded in, 
> which I think I've set to UTF-7.
> 
> When showing you the mail, your system has to interpret the bytes of
> the content using *that* character set encoding. Anything else is just
> fundamentally broken. Your system locale has *nothing* to do with it.
> 
> If your local system is running EBCDIC that doesn't *matter*.
> 
> Now, the character set encoding of the kernel source and documentation
> text files is UTF-8. It isn't EBCDIC, it isn't ISO8859-15 or any of the
> legacy crap. It isn't system locale either, unless your system locale
> *happens* to be UTF-8.
> 
> UTF-8 *happens* to be compatible with ASCII for the limited subset of
> characters which ASCII contains, sure ? just as *many*, but not all, of
> the legacy 8-bit character sets are also a superset of ASCII's 7 bits.
> 
> But if the docs contain *any* characters which aren't ASCII, and you
> build them with a broken build system which assumes ASCII, you are
> going to produce wrong output. There is *no* substitute for fixing the
> *actual* bug which started all this, and ensuring your build system (or
> whatever) uses the *actual* encoding of the text files it's processing,
> instead of making stupid and bogus assumptions based on a system
> default.
> 
> You concede keeping U+00a9 ? COPYRIGHT SIGN. And that's encoded in UTF-
> 8 as two bytes 0xC2 0xA9. If some broken build system *assumes* those
> bytes are ISO8859-15 it'll take them to mean two separate characters
> 
>     U+00C2 ? LATIN CAPITAL LETTER A WITH CIRCUMFLEX
>     U+00A9 ? COPYRIGHT SIGN
> 
> Your broken build system that started all this is never going to be
> *anything* other than broken. You can only paper over the cracks and
> make it slightly less likely that people will notice in the common
> case, perhaps? That's all you do by *reducing* the use of non-ASCII,
> unless you're going to drag us all the way back to the 1980s and
> strictly limit us to pure ASCII, using the equivalent of trigraphs for
> *anything* outside the 0-127 character ranges.
> 
> And even if you did that, systems which use EBCDIC as their local
> encoding would *still* be broken, if they have the same bug you started
> from. Because EBCDIC isn't compatible with ASCII *even* for the first 7
> bits.

Now, you're making a lot of wrong assumptions here ;-)

1. I didn't report the bug. Another person reported it at linux-doc;
2. I fully agree with you that the building system should work fine
   whatever locate the machine has;
3. Sphinx supported charset for the REST input and its output is UTF-8.

Despite of that, it seems that there are some issues at the building
tool set, at least under certain circunstances. One of the hypothesis 
that it was mentioned there is that the Sphinx logger crashes when it
tries to print an UTF-8 message when the machine's locale is not UTF-8.

That's said, I tried forcing a non-UTF-8 on some tests I did to try
to reproduce, but the build went fine.

So, I was not able to reproduce the issue.

This series doesn't address the issue. It is just a side effect of the
discussions, where, while trying to understand the bug, we noticed
several UTF-8 characters introduced during the conversion that were't
the original author's intent.

So, with regards to the original but report, if I find a way to
reproduce it and to address it, I'll post a separate series.

If you want to discuss this issue further, let's not discuss here, but
instead, at the linux-doc thread:

	https://lore.kernel.org/linux-doc/20210506103913.GE6564 at kitsune.suse.cz/

> 
> 
> > we discovered that some converted docs ended
> > with BOM characters. Those specific changes were introduced by some
> > of my convert patches, probably converted via pandoc.
> > 
> > So, I went ahead in order to check what other possible weird things
> > were introduced by the conversion, where several scripts and tools
> > were used on files that had already a different markup.
> > 
> > I actually checked the current UTF-8 issues, and asked people at
> > linux-doc to comment what of those are valid usecases, and what
> > should be replaced by plain ASCII.  
> 
> No, these aren't "UTF-8 issues". Those are *conversion* issues, and
> would still be there if the output of the conversion had been UTF-7,
> UCS-16, etc. Or *even* if the output of the conversion had been
> trigraph-like stuff like '--' for emdash. It's *nothing* to do with the
> encoding that we happen to be using.

Yes. That's what I said.

> 
> Fixing the conversion issues makes a lot of sense. Try to do it without
> making *any* mention of UTF-8 at all.
> 
> > In summary, based on the discussions we have so far, I suspect that
> > there's not much to be discussed for the above cases.
> > 
> > So, I'll post a v3 of this series, changing only:
> > 
> >         - U+00a0 (' '): NO-BREAK SPACE
> >         - U+feff ('?'): ZERO WIDTH NO-BREAK SPACE (BOM)  
> 
> Ack, as long as those make *no* mention of UTF-8. Except perhaps to
> note that BOM is redundant because UTF-8 doesn't have a byteorder.

I need to tell what UTF-8 codes are replaced, as otherwise the patch
wouldn't make much sense to reviewers, as both U+00a0 and whitespaces
are displayed the same way, and BOM is invisible.

> 
> > ---
> > 
> > Now, this specific patch series address also this extra case:
> > 
> > 5. curly commas:
> > 
> >         - U+2018 ('?'): LEFT SINGLE QUOTATION MARK
> >         - U+2019 ('?'): RIGHT SINGLE QUOTATION MARK
> >         - U+201c ('?'): LEFT DOUBLE QUOTATION MARK
> >         - U+201d ('?'): RIGHT DOUBLE QUOTATION MARK
> > 
> > IMO, those should be replaced by ASCII commas: ' and ".
> > 
> > The rationale is simple: 
> > 
> > - most were introduced during the conversion from Docbook,
> >   markdown and LaTex;
> > - they don't add any extra value, as using "foo" of ?foo? means
> >   the same thing;
> > - Sphinx already use "fancy" commas at the output. 
> > 
> > I guess I will put this on a separate series, as this is not a bug
> > fix, but just a cleanup from the conversion work.
> > 
> > I'll re-post those cleanups on a separate series, for patch per patch
> > review.  
> 
> Makes sense. 
> 
> The left/right quotation marks exists to make human-readable text much
> easier to read, but the key point here is that they are redundant
> because the tooling already emits them in the *output* so they don't
> need to be in the source, yes?

Yes.

> As long as the tooling gets it *right* and uses them where it should,
> that seems sane enough.
> 
> However, it *does* break 'grep', because if I cut/paste a snippet from
> the documentation and try to grep for it, it'll no longer match.

> 
> Consistency is good, but perhaps we should actually be consistent the
> other way round and always use the left/right versions in the source
> *instead* of relying on the tooling, to make searches work better?
> You claimed to care about that, right?

That's indeed a good point. It would be interesting to have more
opinions with that matter.

There are a couple of things to consider:

1. It is (usually) trivial to discover what document produced a
   certain page at the documentation.

   For instance, if you want to know where the text under this
   file came from, or to grep a text from it:

	https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html

   You can click at the "View page source" button at the first line.
   It will show the .rst file used to produce it:

	https://www.kernel.org/doc/html/latest/_sources/admin-guide/cgroup-v2.rst.txt

2. If all you want is to search for a text inside the docs,
   you can click at the "Search docs" box, which is part of the
   Read the Docs theme.

3. Kernel has several extensions for Sphinx, in order to make life 
   easier for Kernel developers:

	Documentation/sphinx/automarkup.py
	Documentation/sphinx/cdomain.py
	Documentation/sphinx/kernel_abi.py
	Documentation/sphinx/kernel_feat.py
	Documentation/sphinx/kernel_include.py
	Documentation/sphinx/kerneldoc.py
	Documentation/sphinx/kernellog.py
	Documentation/sphinx/kfigure.py
	Documentation/sphinx/load_config.py
	Documentation/sphinx/maintainers_include.py
	Documentation/sphinx/rstFlatTable.py

Those (in particular automarkup and kerneldoc) will also dynamically 
change things during ReST conversion, which may cause grep to not work. 

5. some PDF tools like evince will match curly commas if you
   type an ASCII comma on their search boxes.

6. Some developers prefer to only deal with the files inside the
   Kernel tree. Those are very unlikely to do grep with curly aspas.

My opinion on that matter is that we should make life easier for
developers to grep on text files, as the ones using the web interface
are already served by the search box in html format or by tools like
evince.

So, my vote here is to keep aspas as plain ASCII.

> 
> > The remaining cases are future work, outside the scope of this v2:
> > 
> > 6. Hyphen/Dashes and ellipsis
> > 
> >         - U+2212 ('?'): MINUS SIGN
> >         - U+00ad ('?'): SOFT HYPHEN
> >         - U+2010 ('?'): HYPHEN
> > 
> >             Those three are used on places where a normal ASCII hyphen/minus
> >             should be used instead. There are even a couple of C files which
> >             use them instead of '-' on comments.
> > 
> >             IMO are fixes/cleanups from conversions and bad cut-and-paste.  
> 
> That seems to make sense.
> 
> >         - U+2013 ('?'): EN DASH
> >         - U+2014 ('?'): EM DASH
> >         - U+2026 ('?'): HORIZONTAL ELLIPSIS
> > 
> >             Those are auto-replaced by Sphinx from "--", "---" and "...",
> >             respectively.
> > 
> >             I guess those are a matter of personal preference about
> >             weather using ASCII or UTF-8.
> > 
> >             My personal preference (and Ted seems to have a similar
> >             opinion) is to let Sphinx do the conversion.
> > 
> >             For those, I intend to post a separate series, to be
> >             reviewed patch per patch, as this is really a matter
> >             of personal taste. Hardly we'll reach a consensus here.
> >   
> 
> Again using the trigraph-like '--' and '...' instead of just using the
> plain text '?' and '?' breaks searching, because what's in the output
> doesn't match the input. Again consistency is good, but perhaps we
> should standardise on just putting these in their plain text form
> instead of the trigraphs?

Good point. 

While I don't have any strong preferences here, there's something that
annoys me with regards to EM/EN DASH:

With the monospaced fonts I'm using here - both at my e-mailer and
on my terminals, both EM and EN DASH are displayed look *exactly*
the same.

> 
> > 7. math symbols:
> > 
> >         - U+00d7 ('?'): MULTIPLICATION SIGN
> > 
> >            This one is used mostly do describe video resolutions, but this is
> >            on a smaller changeset than the ones that use "x" letter.  
> 
> I think standardising on ? for video resolutions in documentation would
> make it look better and be easier to read.
> 
> > 
> >         - U+2217 ('?'): ASTERISK OPERATOR
> > 
> >            This is used only here:
> >                 Documentation/filesystems/ext4/blockgroup.rst:filesystem size to 2^21 ? 2^27 = 2^48bytes or 256TiB.
> > 
> >            Probably added by some conversion tool. IMO, this one should
> >            also be replaced by an ASCII asterisk.
> > 
> > I guess I'll post a patch for the ASTERISK OPERATOR.  
> 
> That makes sense.



Thanks,
Mauro
