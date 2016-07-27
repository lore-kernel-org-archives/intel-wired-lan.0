From: Wyborny, Carolyn <carolyn.wyborny@intel.com>
Date: Wed, 27 Jul 2016 15:52:47 +0000
Subject: [Intel-wired-lan] [PATCH V0] i40e: Program device correctly as
 part of adding flow director entry
In-Reply-To: <1469599316.2851.50.camel@intel.com>
References: <1469598563-42383-1-git-send-email-kiran.patil@intel.com>
 <1469599316.2851.50.camel@intel.com>
Message-ID: <9BBC4E0CF881AA4299206E2E1412B62650236576@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, July 26, 2016 11:02 PM
> To: Patil, Kiran <kiran.patil@intel.com>; intel-wired-lan at lists.osuosl.org;
> Bowers, AndrewX <andrewx.bowers@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH V0] i40e: Program device correctly as part
> of adding flow director entry
> 
> On Tue, 2016-07-26 at 22:49 -0700, Kiran Patil wrote:
> > This patch fixes the problem where driver was not programming
> > underlying device correctly when user specifies less than full tuple
> > set as part of adding flow director entry (for flow-type tcp4/udp4)
> > using ethtool.
> >
> > Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> > Change-Id: I90052508f8c172c0da5a4b78b949704b4a59ea78
> > Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
> > ---
> > ?drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 116
> > +++++++++++++++++++++++++
> > ?1 file changed, 116 insertions(+)
> 
> Andrew, I know your tested-by is already on this, but I also know it was
> not tested while in my dev-queue branch of my next-queue tree. ?Can you
> please verify this patch in my tree? ?No need to send another tested-by,
> just let me know if your tested-by still stands.

Please drop this patch.  The i40e team is redesigning this feature with a couple of others and it will be submitted at a future time.

Thanks,

Carolyn
