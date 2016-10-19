From: Henrik Austad <henrik@austad.us>
Date: Wed, 19 Oct 2016 17:08:03 +0200
Subject: [Intel-wired-lan] [PATCH] igb: add missing fields to
 TXDCTL-register
In-Reply-To: <20161019072510.00002b0e@intel.com>
References: <1476880679-16221-1-git-send-email-henrik@austad.us>
 <20161019072510.00002b0e@intel.com>
Message-ID: <20161019150803.GA20691@icarus.home.austad.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Oct 19, 2016 at 07:25:10AM -0700, Jesse Brandeburg wrote:
> On Wed, 19 Oct 2016 14:37:59 +0200
> Henrik Austad <henrik@austad.us> wrote:
> 
> > The current list of E1000_TXDCTL-registers is incomplete. This adds
> > the missing parts for the Transmit Descriptor Control (TXDCTL)
> > register.
> > 
> > The rest of these values (threshold for descriptor read/write) for
> > TXDCTL seems to be defined in igb/igb.h, not sure why this is split
> > though.
> 
> Hi Henrik, thanks for helping with our code.
> 
> While totally correct, having defines added to the kernel that are not
> being used anywhere in the code isn't really very useful.  Often the
> upstream maintainers/reviewers will reject a patch like this that just
> adds to a .h file, because there are no actual users of the defines.

Yes, I agree, best to avoid bloat whenever possible.

> If the transmit or ethtool code were to use these (via the same patch)
> or something like that, then the patch would be more likely to be
> accepted.

Ah, good to know. I am in the process of spinning out a new set of 
TSN-patches (previous version: see [1]) and setting the priority-bit for 
the Tx-queues is required. This means that I'm hacking more at igb_main.c.

So this was more about laying the groundwork for the series.

I'll leave this patch in the tsn-series then, and resend once I'm ready and 
hope you can provide some feedback on the rest of the series then :)

> Jesse
> 
> PS In the future no need to copy linux-kernel for patches going to our
> submaintainer list.

Ok, I'll remember that, thanks!

1) https://lkml.org/lkml/2016/6/11/187

-- 
Henrik Austad
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161019/8eb0f082/attachment.asc>
