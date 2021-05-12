From: David Woodhouse <dwmw2@infradead.org>
Date: Wed, 12 May 2021 18:12:27 +0100
Subject: [Intel-wired-lan] [PATCH v2 00/40] Use ASCII subset instead of
 UTF-8 alternate symbols
In-Reply-To: <20210512171741.2870bcbc@coco.lan>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
 <YJvi1L2ss5Tfi+My@mit.edu> <20210512171741.2870bcbc@coco.lan>
Message-ID: <cca519da5a3af70297bf1b75b9dbcb0c98ed3eaf.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-05-12 at 17:17 +0200, Mauro Carvalho Chehab wrote:
> Em Wed, 12 May 2021 10:14:44 -0400
> "Theodore Ts'o" <tytso@mit.edu> escreveu:
> 
> > On Wed, May 12, 2021 at 02:50:04PM +0200, Mauro Carvalho Chehab wrote:
> > > v2:
> > > - removed EM/EN DASH conversion from this patchset;  
> > 
> > Are you still thinking about doing the
> > 
> > EN DASH --> "--"
> > EM DASH --> "---"
> > 
> > conversion?  
> 
> Yes, but I intend to submit it on a separate patch series, probably after
> having this one merged. Let's first cleanup the large part of the 
> conversion-generated UTF-8 char noise ;-)
> 
> > That's not going to change what the documentation will
> > look like in the HTML and PDF output forms, and I think it would make
> > life easier for people are reading and editing the Documentation/*
> > files in text form.
> 
> Agreed. I'm also considering to add a couple of cases of this char:
> 
> 	- U+2026 ('?'): HORIZONTAL ELLIPSIS
> 
> As Sphinx also replaces "..." into HORIZONTAL ELLIPSIS.

Er, what?

The *only* part of this whole enterprise that actually seemed to make
even a tiny bit of sense ? rather than seeming like a thinly veiled
retrospective excuse for dragging us back in time by 30 years ? was the
bit about making it easier to grep.

But if I understand you correctly, you're talking about using something
like C trigraphs to represent the perfectly reasonable text emdash
character ("?") as two hyphen-minuses ("--") in the source code of the
documentation? Isn't that going to achieve precisely the *opposite*? If
I select some text in the HTML output of the docs and then search for
it in the source code, that's going to *stop* it matching my search?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5174 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210512/9afdb33d/attachment.bin>
