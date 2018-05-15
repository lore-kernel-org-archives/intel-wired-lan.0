From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 15 May 2018 10:47:48 -0700
Subject: [Intel-wired-lan] [PATCH] ethtool: stop the line wrapping
 madness
In-Reply-To: <ab0e04cf-e3e0-ed15-900c-5d1a3eab4f1c@molgen.mpg.de>
References: <20180515173208.20352-1-mitch.a.williams@intel.com>
 <ab0e04cf-e3e0-ed15-900c-5d1a3eab4f1c@molgen.mpg.de>
Message-ID: <1c7667a30ecdb7f31e3a6ff9131f22bbde45d5b1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2018-05-15 at 19:37 +0200, Paul Menzel wrote:
> On 05/15/18 19:32, Mitch Williams wrote:
> > Folks, we have a hard limit of 80 characters per line in the
> kernel,
> > mostly due to Linus' insistence on printing out each release on
> greenbar
> > with his Decwriter. So why do we have function and macro names that
> are
> > over 30 characters long? Add a tab or two and a few parameters and
> boom!
> > you're wrapping lines.
> > 
> > This patch is a search-n-replace of the newly-added ethtool link
> > settings API with shorter names. In general, I replaced 'ksettings'
> with
> > 'ks' and elided some unnecessary verbiage. In nearly every instance
> I
> > unwrapped lines and made the code easier to read, especially on a
> VT102.
> 
> Nice, let?s see what the others think.
> 
> > In the case of the Amazon Ethernet driver, I found a bug where they
> were
> > setting bits in the 'settings' field twice. Almost certainly this
> > was supposed to set bits in the 'advertising' field instead. So I
> fixed
> > it.
> 
> Please split this out into a separate patch.

Actually, I dusted the cobwebs off Mitch's original patch and in this
version of the patch, the Amazon driver was not fixed.  So I need to
fix up the patch description to remove the reference to the fix and I
will put together a patch to fix the Amazon driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180515/7da98fd3/attachment.asc>
