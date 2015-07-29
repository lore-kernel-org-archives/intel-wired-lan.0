From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Jul 2015 21:48:35 +0000
Subject: [Intel-wired-lan] [e1000-patches][net-next PATCH S8 02/15]
 i40e: add RX to port CRC	errors label
In-Reply-To: <68C85B5FC2FE974B87244D7222BC92783EA1EC15@ORSMSX102.amr.corp.intel.com>
References: <1436466416-95687-1-git-send-email-catherine.sullivan@intel.com>
 <1436466416-95687-2-git-send-email-catherine.sullivan@intel.com>
 <68C85B5FC2FE974B87244D7222BC92783EA1EC15@ORSMSX102.amr.corp.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE86E@ORSMSX104.amr.corp.intel.com>
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
> > Subject: [e1000-patches][net-next PATCH S8 02/15] i40e: add RX to port
> > CRC errors label
> >
> > From: Shannon Nelson <shannon.nelson@intel.com>
> >
> > The port.crc_errors is really an RX counter, so let's mark it as such.
> >
> > Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> > Change-ID: I179afd3f8a95d45229bb4163a6aeb01f0d2d250b
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
