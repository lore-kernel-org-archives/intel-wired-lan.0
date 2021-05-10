From: David Woodhouse <dwmw2@infradead.org>
Date: Mon, 10 May 2021 14:49:44 +0100
Subject: [Intel-wired-lan] [PATCH 00/53] Get rid of UTF-8 chars that can
 be mapped as ASCII
In-Reply-To: <20210510135518.305cc03d@coco.lan>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
 <2ae366fdff4bd5910a2270823e8da70521c859af.camel@infradead.org>
 <20210510135518.305cc03d@coco.lan>
Message-ID: <de6d1fa5b7934f4afd61370d9c58502bef588466.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-05-10 at 13:55 +0200, Mauro Carvalho Chehab wrote:
> This patch series is doing conversion only when using ASCII makes
> more sense than using UTF-8. 
> 
> See, a number of converted documents ended with weird characters
> like ZERO WIDTH NO-BREAK SPACE (U+FEFF) character. This specific
> character doesn't do any good.
> 
> Others use NO-BREAK SPACE (U+A0) instead of 0x20. Harmless, until
> someone tries to use grep[1].

Replacing those makes sense. But replacing emdashes ? which are a
distinct character that has no direct replacement in ASCII and which
people do *deliberately* use instead of hyphen-minus ? does not.

Perhaps stick to those two, and any cases where an emdash or endash has
been used where U+002D HYPHEN-MINUS *should* have been used.

And please fix your cover letter which made no reference to 'grep', and
only presented a completely bogus argument for the change instead.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5174 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210510/6929b0ec/attachment-0001.bin>
