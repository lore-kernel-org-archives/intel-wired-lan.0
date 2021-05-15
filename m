From: David Woodhouse <dwmw2@infradead.org>
Date: Sat, 15 May 2021 10:24:28 +0100
Subject: [Intel-wired-lan] [PATCH v2 00/40] Use ASCII subset instead of
 UTF-8 alternate symbols
In-Reply-To: <20210515102239.2ffd0451@coco.lan>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
 <d2fed242fbe200706b8d23a53512f0311d900297.camel@infradead.org>
 <20210514102118.1b71bec3@coco.lan>
 <61c286b7afd6c4acf71418feee4eecca2e6c80c8.camel@infradead.org>
 <20210515102239.2ffd0451@coco.lan>
Message-ID: <c2a4cb8457823685ecba6833d57047d059b36fbb.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, 2021-05-15 at 10:22 +0200, Mauro Carvalho Chehab wrote:
> > >      Here, <CTRL><SHIFT>U is not working. No idea why. I haven't 
> > >      test it for *years*, as I din't see any reason why I would
> > >      need to type UTF-8 characters by numbers until we started
> > >      this thread.  
> > 
> > Please provide the bug number for this; I'd like to track it.
> 
> Just opened a BZ and added you as c/c.

Thanks.

> Let's take one step back, in order to return to the intents of this
> UTF-8, as the discussions here are not centered into the patches, but
> instead, on what to do and why.
> 
> -
> 
> This discussion started originally at linux-doc ML.
> 
> While discussing about an issue when machine's locale was not set
> to UTF-8 on a build VM, 

Stop. Stop *right* there before you go any further.

The machine's locale should have *nothing* to do with anything.

When you view this email, it comes with a Content-Type: header which
explicitly tells you the character set that the message is encoded in, 
which I think I've set to UTF-7.

When showing you the mail, your system has to interpret the bytes of
the content using *that* character set encoding. Anything else is just
fundamentally broken. Your system locale has *nothing* to do with it.

If your local system is running EBCDIC that doesn't *matter*.

Now, the character set encoding of the kernel source and documentation
text files is UTF-8. It isn't EBCDIC, it isn't ISO8859-15 or any of the
legacy crap. It isn't system locale either, unless your system locale
*happens* to be UTF-8.

UTF-8 *happens* to be compatible with ASCII for the limited subset of
characters which ASCII contains, sure ? just as *many*, but not all, of
the legacy 8-bit character sets are also a superset of ASCII's 7 bits.

But if the docs contain *any* characters which aren't ASCII, and you
build them with a broken build system which assumes ASCII, you are
going to produce wrong output. There is *no* substitute for fixing the
*actual* bug which started all this, and ensuring your build system (or
whatever) uses the *actual* encoding of the text files it's processing,
instead of making stupid and bogus assumptions based on a system
default.

You concede keeping U+00a9 ? COPYRIGHT SIGN. And that's encoded in UTF-
8 as two bytes 0xC2 0xA9. If some broken build system *assumes* those
bytes are ISO8859-15 it'll take them to mean two separate characters

    U+00C2 ? LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    U+00A9 ? COPYRIGHT SIGN

Your broken build system that started all this is never going to be
*anything* other than broken. You can only paper over the cracks and
make it slightly less likely that people will notice in the common
case, perhaps? That's all you do by *reducing* the use of non-ASCII,
unless you're going to drag us all the way back to the 1980s and
strictly limit us to pure ASCII, using the equivalent of trigraphs for
*anything* outside the 0-127 character ranges.

And even if you did that, systems which use EBCDIC as their local
encoding would *still* be broken, if they have the same bug you started
from. Because EBCDIC isn't compatible with ASCII *even* for the first 7
bits.


> we discovered that some converted docs ended
> with BOM characters. Those specific changes were introduced by some
> of my convert patches, probably converted via pandoc.
> 
> So, I went ahead in order to check what other possible weird things
> were introduced by the conversion, where several scripts and tools
> were used on files that had already a different markup.
> 
> I actually checked the current UTF-8 issues, and asked people at
> linux-doc to comment what of those are valid usecases, and what
> should be replaced by plain ASCII.

No, these aren't "UTF-8 issues". Those are *conversion* issues, and
would still be there if the output of the conversion had been UTF-7,
UCS-16, etc. Or *even* if the output of the conversion had been
trigraph-like stuff like '--' for emdash. It's *nothing* to do with the
encoding that we happen to be using.

Fixing the conversion issues makes a lot of sense. Try to do it without
making *any* mention of UTF-8 at all.

> In summary, based on the discussions we have so far, I suspect that
> there's not much to be discussed for the above cases.
> 
> So, I'll post a v3 of this series, changing only:
> 
>         - U+00a0 (' '): NO-BREAK SPACE
>         - U+feff ('?'): ZERO WIDTH NO-BREAK SPACE (BOM)

Ack, as long as those make *no* mention of UTF-8. Except perhaps to
note that BOM is redundant because UTF-8 doesn't have a byteorder.

> ---
> 
> Now, this specific patch series address also this extra case:
> 
> 5. curly commas:
> 
>         - U+2018 ('?'): LEFT SINGLE QUOTATION MARK
>         - U+2019 ('?'): RIGHT SINGLE QUOTATION MARK
>         - U+201c ('?'): LEFT DOUBLE QUOTATION MARK
>         - U+201d ('?'): RIGHT DOUBLE QUOTATION MARK
> 
> IMO, those should be replaced by ASCII commas: ' and ".
> 
> The rationale is simple: 
> 
> - most were introduced during the conversion from Docbook,
>   markdown and LaTex;
> - they don't add any extra value, as using "foo" of ?foo? means
>   the same thing;
> - Sphinx already use "fancy" commas at the output. 
> 
> I guess I will put this on a separate series, as this is not a bug
> fix, but just a cleanup from the conversion work.
> 
> I'll re-post those cleanups on a separate series, for patch per patch
> review.

Makes sense. 

The left/right quotation marks exists to make human-readable text much
easier to read, but the key point here is that they are redundant
because the tooling already emits them in the *output* so they don't
need to be in the source, yes?

As long as the tooling gets it *right* and uses them where it should,
that seems sane enough.

However, it *does* break 'grep', because if I cut/paste a snippet from
the documentation and try to grep for it, it'll no longer match.

Consistency is good, but perhaps we should actually be consistent the
other way round and always use the left/right versions in the source
*instead* of relying on the tooling, to make searches work better?
You claimed to care about that, right?

> The remaining cases are future work, outside the scope of this v2:
> 
> 6. Hyphen/Dashes and ellipsis
> 
>         - U+2212 ('?'): MINUS SIGN
>         - U+00ad ('?'): SOFT HYPHEN
>         - U+2010 ('?'): HYPHEN
> 
>             Those three are used on places where a normal ASCII hyphen/minus
>             should be used instead. There are even a couple of C files which
>             use them instead of '-' on comments.
> 
>             IMO are fixes/cleanups from conversions and bad cut-and-paste.

That seems to make sense.

>         - U+2013 ('?'): EN DASH
>         - U+2014 ('?'): EM DASH
>         - U+2026 ('?'): HORIZONTAL ELLIPSIS
> 
>             Those are auto-replaced by Sphinx from "--", "---" and "...",
>             respectively.
> 
>             I guess those are a matter of personal preference about
>             weather using ASCII or UTF-8.
> 
>             My personal preference (and Ted seems to have a similar
>             opinion) is to let Sphinx do the conversion.
> 
>             For those, I intend to post a separate series, to be
>             reviewed patch per patch, as this is really a matter
>             of personal taste. Hardly we'll reach a consensus here.
> 

Again using the trigraph-like '--' and '...' instead of just using the
plain text '?' and '?' breaks searching, because what's in the output
doesn't match the input. Again consistency is good, but perhaps we
should standardise on just putting these in their plain text form
instead of the trigraphs?

> 7. math symbols:
> 
>         - U+00d7 ('?'): MULTIPLICATION SIGN
> 
>            This one is used mostly do describe video resolutions, but this is
>            on a smaller changeset than the ones that use "x" letter.

I think standardising on ? for video resolutions in documentation would
make it look better and be easier to read.

> 
>         - U+2217 ('?'): ASTERISK OPERATOR
> 
>            This is used only here:
>                 Documentation/filesystems/ext4/blockgroup.rst:filesystem size to 2^21 ? 2^27 = 2^48bytes or 256TiB.
> 
>            Probably added by some conversion tool. IMO, this one should
>            also be replaced by an ASCII asterisk.
> 
> I guess I'll post a patch for the ASTERISK OPERATOR.

That makes sense.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5174 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210515/2108ef6e/attachment.bin>
