From: Sullivan, Catherine <catherine.sullivan@intel.com>
Date: Tue, 29 Sep 2015 21:45:51 +0000
Subject: [Intel-wired-lan] [next PATCH S9 03/15] i40e: fixup padding
 issue	in get_cee_dcb_cfg_v1_resp
In-Reply-To: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE4A9@ORSMSX104.amr.corp.intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
 <1437684884-222825-4-git-send-email-catherine.sullivan@intel.com>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE4A9@ORSMSX104.amr.corp.intel.com>
Message-ID: <E8A77B2FB54C194393A5C2A8E3ED167827A54AEC@CRSMSX102.amr.corp.intel.com>
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
> > Subject: [Intel-wired-lan] [next PATCH S9 03/15] i40e: fixup padding
> > issue in get_cee_dcb_cfg_v1_resp
> >
> > From: Shannon Nelson <shannon.nelson@intel.com>
> >
> > The struct i40e_aqc_get_cee_dcb_cfg_v1_resp was originally defined
> > with word boundary layout issues, which most compilers deal with by
> > silently adding padding, making the actual struct larger than designed.
> > This patch adds an extra byte in fields reserved3 and reserved4 to
> > directly acknowledge that padding.
> >
> > Because the struct doesn't actually change in size or layout, this
> > doesn't constitute a change in the API.
> >
> > Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> > Change-ID: I53fa4741b73fa255621232a85fba000b0e223015

> Verified-by: Andrew Bowers <andrewx.bowers@intel.com>
> 
> Present in git log, code changes present in tree.

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

Already verified, but wasn't flagged as such in patchwork.
