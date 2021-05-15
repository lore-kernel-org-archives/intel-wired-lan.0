From: David Woodhouse <dwmw2@infradead.org>
Date: Sat, 15 May 2021 13:02:18 +0100
Subject: [Intel-wired-lan] [PATCH v2 00/40] Use ASCII subset instead of
 UTF-8 alternate symbols
In-Reply-To: <20210515132344.0206c8fc@coco.lan>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
 <d2fed242fbe200706b8d23a53512f0311d900297.camel@infradead.org>
 <20210514102118.1b71bec3@coco.lan>
 <61c286b7afd6c4acf71418feee4eecca2e6c80c8.camel@infradead.org>
 <20210515102239.2ffd0451@coco.lan>
 <c2a4cb8457823685ecba6833d57047d059b36fbb.camel@infradead.org>
 <20210515132344.0206c8fc@coco.lan>
Message-ID: <74696d9a8906e3c16dcdff558aaab4f9663b06f5.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, 2021-05-15 at 13:23 +0200, Mauro Carvalho Chehab wrote:
> Em Sat, 15 May 2021 10:24:28 +0100
> David Woodhouse <dwmw2@infradead.org> escreveu:
> > > Let's take one step back, in order to return to the intents of this
> > > UTF-8, as the discussions here are not centered into the patches, but
> > > instead, on what to do and why.
> > > 
> > > This discussion started originally at linux-doc ML.
> > > 
> > > While discussing about an issue when machine's locale was not set
> > > to UTF-8 on a build VM,   
> > 
> > Stop. Stop *right* there before you go any further.
> > 
> > The machine's locale should have *nothing* to do with anything.
>
> Now, you're making a lot of wrong assumptions here ;-)
> 
> 1. I didn't report the bug. Another person reported it at linux-doc;
> 2. I fully agree with you that the building system should work fine
>    whatever locate the machine has;
> 3. Sphinx supported charset for the REST input and its output is UTF-8.

OK, fine. So that's an unrelated issue really, and just happened to be
what historically triggered the discussion. Let's set it aside.

> > > I actually checked the current UTF-8 issues ? 
> > 
> > No, these aren't "UTF-8 issues". Those are *conversion* issues, and 
> > ? *nothing* to do with the encoding that we happen to be using.
> 
> Yes. That's what I said.

Er? I'm fairly sure you *did* call them "UTF-8 issues". Whatever.




> > 
> > Fixing the conversion issues makes a lot of sense. Try to do it without
> > making *any* mention of UTF-8 at all.
> > 
> > > In summary, based on the discussions we have so far, I suspect that
> > > there's not much to be discussed for the above cases.
> > > 
> > > So, I'll post a v3 of this series, changing only:
> > > 
> > >         - U+00a0 (' '): NO-BREAK SPACE
> > >         - U+feff ('?'): ZERO WIDTH NO-BREAK SPACE (BOM)  
> > 
> > Ack, as long as those make *no* mention of UTF-8. Except perhaps to
> > note that BOM is redundant because UTF-8 doesn't have a byteorder.
> 
> I need to tell what UTF-8 codes are replaced, as otherwise the patch
> wouldn't make much sense to reviewers, as both U+00a0 and whitespaces
> are displayed the same way, and BOM is invisible.
> 

No. Again, this is *nothing* to do with UTF-8. The encoding we choose
to map between byte in the file and characters is *utterly* irrelevant
here. If we were using UTF-7, UTF-16, or even (in the case of non-
breaking space) one of the legacy 8-bit charsets that includes it like
ISO8859-1, the issue would be precisely the same. 

It's about the *character* U+00A0 NO-BREAK SPACE; nothing to do with
UTF-8 at all. Don't mention UTF-8. It's *irrelevant* and just shows
that you can't actually bothered to stop and do any critical thinking
about the matter at all.

As I said, the only time that it makes sense to mention UTF-8 in this
context is when talking about *why* the BOM is not needed. And even
then, you could say "because we *aren't* using an encoding where
endianness matters, such as UTF-16", instead of actually mentioning
UTF-8. Try it ?

> > 
> > > ---
> > > 
> > > Now, this specific patch series address also this extra case:
> > > 
> > > 5. curly commas:
> > > 
> > >         - U+2018 ('?'): LEFT SINGLE QUOTATION MARK
> > >         - U+2019 ('?'): RIGHT SINGLE QUOTATION MARK
> > >         - U+201c ('?'): LEFT DOUBLE QUOTATION MARK
> > >         - U+201d ('?'): RIGHT DOUBLE QUOTATION MARK
> > > 
> > > IMO, those should be replaced by ASCII commas: ' and ".
> > > 
> > > The rationale is simple: 
> > > 
> > > - most were introduced during the conversion from Docbook,
> > >   markdown and LaTex;
> > > - they don't add any extra value, as using "foo" of ?foo? means
> > >   the same thing;
> > > - Sphinx already use "fancy" commas at the output. 
> > > 
> > > I guess I will put this on a separate series, as this is not a bug
> > > fix, but just a cleanup from the conversion work.
> > > 
> > > I'll re-post those cleanups on a separate series, for patch per patch
> > > review.  
> > 
> > Makes sense. 
> > 
> > The left/right quotation marks exists to make human-readable text much
> > easier to read, but the key point here is that they are redundant
> > because the tooling already emits them in the *output* so they don't
> > need to be in the source, yes?
> 
> Yes.
> 
> > As long as the tooling gets it *right* and uses them where it should,
> > that seems sane enough.
> > 
> > However, it *does* break 'grep', because if I cut/paste a snippet from
> > the documentation and try to grep for it, it'll no longer match.
> > 
> > Consistency is good, but perhaps we should actually be consistent the
> > other way round and always use the left/right versions in the source
> > *instead* of relying on the tooling, to make searches work better?
> > You claimed to care about that, right?
> 
> That's indeed a good point. It would be interesting to have more
> opinions with that matter.
> 
> There are a couple of things to consider:
> 
> 1. It is (usually) trivial to discover what document produced a
>    certain page at the documentation.
> 
>    For instance, if you want to know where the text under this
>    file came from, or to grep a text from it:
> 
> 	https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html
> 
>    You can click at the "View page source" button at the first line.
>    It will show the .rst file used to produce it:
> 
> 	https://www.kernel.org/doc/html/latest/_sources/admin-guide/cgroup-v2.rst.txt
> 
> 2. If all you want is to search for a text inside the docs,
>    you can click at the "Search docs" box, which is part of the
>    Read the Docs theme.
> 
> 3. Kernel has several extensions for Sphinx, in order to make life 
>    easier for Kernel developers:
> 
> 	Documentation/sphinx/automarkup.py
> 	Documentation/sphinx/cdomain.py
> 	Documentation/sphinx/kernel_abi.py
> 	Documentation/sphinx/kernel_feat.py
> 	Documentation/sphinx/kernel_include.py
> 	Documentation/sphinx/kerneldoc.py
> 	Documentation/sphinx/kernellog.py
> 	Documentation/sphinx/kfigure.py
> 	Documentation/sphinx/load_config.py
> 	Documentation/sphinx/maintainers_include.py
> 	Documentation/sphinx/rstFlatTable.py
> 
> Those (in particular automarkup and kerneldoc) will also dynamically 
> change things during ReST conversion, which may cause grep to not work. 
> 
> 5. some PDF tools like evince will match curly commas if you
>    type an ASCII comma on their search boxes.
> 
> 6. Some developers prefer to only deal with the files inside the
>    Kernel tree. Those are very unlikely to do grep with curly aspas.
> 
> My opinion on that matter is that we should make life easier for
> developers to grep on text files, as the ones using the web interface
> are already served by the search box in html format or by tools like
> evince.
> 
> So, my vote here is to keep aspas as plain ASCII.

OK, but all your reasoning is about the *character* used, not the
encoding. So try to do it without mentioning ASCII, and especially
without mentioning UTF-8.

Your point is that the *character* is the one easily reachable on
standard keyboard layouts, and the one which people are most likely to
enter manually. It has *nothing* to do with charset encodings, so don't
conflate is with talking about charset encodings.

> 
> > 
> > > The remaining cases are future work, outside the scope of this v2:
> > > 
> > > 6. Hyphen/Dashes and ellipsis
> > > 
> > >         - U+2212 ('?'): MINUS SIGN
> > >         - U+00ad ('?'): SOFT HYPHEN
> > >         - U+2010 ('?'): HYPHEN
> > > 
> > >             Those three are used on places where a normal ASCII hyphen/minus
> > >             should be used instead. There are even a couple of C files which
> > >             use them instead of '-' on comments.
> > > 
> > >             IMO are fixes/cleanups from conversions and bad cut-and-paste.  
> > 
> > That seems to make sense.
> > 
> > >         - U+2013 ('?'): EN DASH
> > >         - U+2014 ('?'): EM DASH
> > >         - U+2026 ('?'): HORIZONTAL ELLIPSIS
> > > 
> > >             Those are auto-replaced by Sphinx from "--", "---" and "...",
> > >             respectively.
> > > 
> > >             I guess those are a matter of personal preference about
> > >             weather using ASCII or UTF-8.
> > > 
> > >             My personal preference (and Ted seems to have a similar
> > >             opinion) is to let Sphinx do the conversion.
> > > 
> > >             For those, I intend to post a separate series, to be
> > >             reviewed patch per patch, as this is really a matter
> > >             of personal taste. Hardly we'll reach a consensus here.
> > >   
> > 
> > Again using the trigraph-like '--' and '...' instead of just using the
> > plain text '?' and '?' breaks searching, because what's in the output
> > doesn't match the input. Again consistency is good, but perhaps we
> > should standardise on just putting these in their plain text form
> > instead of the trigraphs?
> 
> Good point. 
> 
> While I don't have any strong preferences here, there's something that
> annoys me with regards to EM/EN DASH:
> 
> With the monospaced fonts I'm using here - both at my e-mailer and
> on my terminals, both EM and EN DASH are displayed look *exactly*
> the same.

Interesting. They definitely show differently in my terminal, and in
the monospaced font in email.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5174 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210515/5715f4a5/attachment.bin>
