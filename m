From: Theodore Ts'o <tytso@mit.edu>
Date: Mon, 10 May 2021 15:22:02 -0400
Subject: [Intel-wired-lan] [PATCH 00/53] Get rid of UTF-8 chars that can
 be mapped as ASCII
In-Reply-To: <de6d1fa5b7934f4afd61370d9c58502bef588466.camel@infradead.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
 <2ae366fdff4bd5910a2270823e8da70521c859af.camel@infradead.org>
 <20210510135518.305cc03d@coco.lan>
 <de6d1fa5b7934f4afd61370d9c58502bef588466.camel@infradead.org>
Message-ID: <YJmH2irxoRsyNudb@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, May 10, 2021 at 02:49:44PM +0100, David Woodhouse wrote:
> On Mon, 2021-05-10 at 13:55 +0200, Mauro Carvalho Chehab wrote:
> > This patch series is doing conversion only when using ASCII makes
> > more sense than using UTF-8. 
> > 
> > See, a number of converted documents ended with weird characters
> > like ZERO WIDTH NO-BREAK SPACE (U+FEFF) character. This specific
> > character doesn't do any good.
> > 
> > Others use NO-BREAK SPACE (U+A0) instead of 0x20. Harmless, until
> > someone tries to use grep[1].
> 
> Replacing those makes sense. But replacing emdashes ? which are a
> distinct character that has no direct replacement in ASCII and which
> people do *deliberately* use instead of hyphen-minus ? does not.

I regularly use --- for em-dashes and -- for en-dashes.  Markdown will
automatically translate 3 ASCII hypens to em-dashes, and 2 ASCII
hyphens to en-dashes.  It's much, much easier for me to type 2 or 3
hypens into my text editor of choice than trying to enter the UTF-8
characters.  If we can make sphinx do this translation, maybe that's
the best way of dealing with these two characters?

Cheers,

					- Ted
