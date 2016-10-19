From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 19 Oct 2016 07:25:10 -0700
Subject: [Intel-wired-lan] [PATCH] igb: add missing fields to
 TXDCTL-register
In-Reply-To: <1476880679-16221-1-git-send-email-henrik@austad.us>
References: <1476880679-16221-1-git-send-email-henrik@austad.us>
Message-ID: <20161019072510.00002b0e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 19 Oct 2016 14:37:59 +0200
Henrik Austad <henrik@austad.us> wrote:

> The current list of E1000_TXDCTL-registers is incomplete. This adds
> the missing parts for the Transmit Descriptor Control (TXDCTL)
> register.
> 
> The rest of these values (threshold for descriptor read/write) for
> TXDCTL seems to be defined in igb/igb.h, not sure why this is split
> though.

Hi Henrik, thanks for helping with our code.

While totally correct, having defines added to the kernel that are not
being used anywhere in the code isn't really very useful.  Often the
upstream maintainers/reviewers will reject a patch like this that just
adds to a .h file, because there are no actual users of the defines.

If the transmit or ethtool code were to use these (via the same patch)
or something like that, then the patch would be more likely to be
accepted.

Jesse

PS In the future no need to copy linux-kernel for patches going to our
submaintainer list.
