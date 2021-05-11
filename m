From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Tue, 11 May 2021 11:37:17 +0200
Subject: [Intel-wired-lan] [PATCH 00/53] Get rid of UTF-8 chars that can
 be mapped as ASCII
In-Reply-To: <YJmH2irxoRsyNudb@mit.edu>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
 <2ae366fdff4bd5910a2270823e8da70521c859af.camel@infradead.org>
 <20210510135518.305cc03d@coco.lan>
 <de6d1fa5b7934f4afd61370d9c58502bef588466.camel@infradead.org>
 <YJmH2irxoRsyNudb@mit.edu>
Message-ID: <20210511113717.5c8b68f7@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Em Mon, 10 May 2021 15:22:02 -0400
"Theodore Ts'o" <tytso@mit.edu> escreveu:

> On Mon, May 10, 2021 at 02:49:44PM +0100, David Woodhouse wrote:
> > On Mon, 2021-05-10 at 13:55 +0200, Mauro Carvalho Chehab wrote:  
> > > This patch series is doing conversion only when using ASCII makes
> > > more sense than using UTF-8. 
> > > 
> > > See, a number of converted documents ended with weird characters
> > > like ZERO WIDTH NO-BREAK SPACE (U+FEFF) character. This specific
> > > character doesn't do any good.
> > > 
> > > Others use NO-BREAK SPACE (U+A0) instead of 0x20. Harmless, until
> > > someone tries to use grep[1].  
> > 
> > Replacing those makes sense. But replacing emdashes ? which are a
> > distinct character that has no direct replacement in ASCII and which
> > people do *deliberately* use instead of hyphen-minus ? does not.  
> 
> I regularly use --- for em-dashes and -- for en-dashes.  Markdown will
> automatically translate 3 ASCII hypens to em-dashes, and 2 ASCII
> hyphens to en-dashes.  It's much, much easier for me to type 2 or 3
> hypens into my text editor of choice than trying to enter the UTF-8
> characters. 

Yeah, typing those UTF-8 chars are a lot harder than typing -- and ---
on several text editors ;-)

Here, I only type UTF-8 chars for accents (my US-layout keyboards are 
all set to US international, so typing those are easy).

> If we can make sphinx do this translation, maybe that's
> the best way of dealing with these two characters?

Sphinx already does that by default[1], using smartquotes:

	https://docutils.sourceforge.io/docs/user/smartquotes.html

Those are the conversions that are done there:

      - Straight quotes (" and ') turned into "curly" quote characters;
      - dashes (-- and ---) turned into en- and em-dash entities;
      - three consecutive dots (... or . . .) turned into an ellipsis char.

So, we can simply use single/double commas, hyphens and dots for
curly commas and ellipses.

[1] There's a way to disable it at conf.py, but at the Kernel this is
    kept on its default: to automatically do such conversions. 

Thanks,
Mauro
