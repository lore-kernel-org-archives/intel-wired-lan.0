From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Jul 2015 21:47:15 +0000
Subject: [Intel-wired-lan] [e1000-patches][net-next PATCH S8 05/15]
 i40e: Fix legacy interrupt	mode in the driver
In-Reply-To: <68C85B5FC2FE974B87244D7222BC92783EA1EBEA@ORSMSX102.amr.corp.intel.com>
References: <1436466416-95687-1-git-send-email-catherine.sullivan@intel.com>
 <1436466416-95687-5-git-send-email-catherine.sullivan@intel.com>
 <68C85B5FC2FE974B87244D7222BC92783EA1EBEA@ORSMSX102.amr.corp.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE83C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> > -----Original Message-----
> > From: e1000-patches-bounces at isotope.jf.intel.com
> > [mailto:e1000-patches- bounces at isotope.jf.intel.com] On Behalf Of
> > Sullivan, Catherine
> > Sent: Thursday, July 09, 2015 11:27 AM
> > To: e1000-patches at isotope.jf.intel.com
> > Subject: [e1000-patches][net-next PATCH S8 05/15] i40e: Fix legacy
> > interrupt mode in the driver
> >
> > From: Anjali Singhai Jain <anjali.singhai@intel.com>
> >
> > This patch fixes the driver flow to take into account legacy interrupts.
> > Over time we added code that assumes MSIX is the only mode that the
> > driver runs in. It also enables a legacy workaround to trigger SWINT
> > when the TX ring has non-cache aligned descriptors pending and
> > interrupts are disabled.
> >
> > We work with a single vector in MSI mode too, so apply the same
> > restrictions as Legacy.
> >
> > Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> > Change-ID: I826ddff1f9bd45d2dbe11f56a3ddcef0dbf42563
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_main.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
