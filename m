From: Sullivan, Catherine <catherine.sullivan@intel.com>
Date: Tue, 29 Sep 2015 21:44:15 +0000
Subject: [Intel-wired-lan] [next PATCH S9 01/15] i40e/i40evf: fix up
 type	clash in i40e_aq_rc_to_posix conversion
In-Reply-To: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE475@ORSMSX104.amr.corp.intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
 <1437684884-222825-2-git-send-email-catherine.sullivan@intel.com>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE475@ORSMSX104.amr.corp.intel.com>
Message-ID: <E8A77B2FB54C194393A5C2A8E3ED167827A54AD6@CRSMSX102.amr.corp.intel.com>
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
> > Subject: [Intel-wired-lan] [next PATCH S9 01/15] i40e/i40evf: fix up
> > type clash in i40e_aq_rc_to_posix conversion
> >
> > From: Shannon Nelson <shannon.nelson@intel.com>
> >
> > The error code sent into i40e_aq_rc_to_posix() are signed values, so
> > we really need to treat them as such.
> >
> > Reported-by: Helin Zhang <helin.zhang@intel.com>
> > Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> > Change-ID: I3d1ae0ee9ae0b1b6f5fc424f8b8cc58b0ea93203

> Verified-by: Andrew Bowers <andrewx.bowers@intel.com> Present in git log,
> code changes present in tree.

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

Already verified, but wasn't flagged as such in patchwork.
