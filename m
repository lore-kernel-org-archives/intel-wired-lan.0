From: Sullivan, Catherine <catherine.sullivan@intel.com>
Date: Tue, 29 Sep 2015 21:47:16 +0000
Subject: [Intel-wired-lan] [next PATCH S9 05/15] i40e/i40evf: fix tx
 hang	workaround code
In-Reply-To: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE4C5@ORSMSX104.amr.corp.intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
 <1437684884-222825-6-git-send-email-catherine.sullivan@intel.com>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE4C5@ORSMSX104.amr.corp.intel.com>
Message-ID: <E8A77B2FB54C194393A5C2A8E3ED167827A54B02@CRSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> > -----Original Message-----
> > From: Intel-wired-lan
> > [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of
> > Catherine Sullivan
> > Sent: Thursday, July 23, 2015 1:55 PM
> > To: intel-wired-lan at lists.osuosl.org
> > Subject: [Intel-wired-lan] [next PATCH S9 05/15] i40e/i40evf: fix tx
> > hang workaround code
> >
> > From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> >
> > The arm writeback (arm_wb) code is used for kicking the tx ring to
> > make sure any pending work is completed even if interrupts are
> > disabled. It was running when it didn't need to, and not clearing the
> > ring->arm_wb state after it was set.  This caused tx hangs to still
> > occur occasionally when there really was no hang.
> > Fix this by resetting the variable right after it was used.
> >
> > Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> > Change-ID: I7bf75d552ba9c4bd203d40615213861a24bb5594

> Verified-by: Andrew Bowers <Andrewx.bowers@intel.com>
> 
> Present in git log, code changes present in tree.

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

Already verified, but wasn't flagged as such in patchwork.
