From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Jul 2015 21:44:31 +0000
Subject: [Intel-wired-lan] [e1000-patches][net-next PATCH S8 10/15]
 i40evf: Use the correct	defines to match the VF registers
In-Reply-To: <68C85B5FC2FE974B87244D7222BC92783EA1EB8C@ORSMSX102.amr.corp.intel.com>
References: <1436466416-95687-1-git-send-email-catherine.sullivan@intel.com>
 <1436466416-95687-10-git-send-email-catherine.sullivan@intel.com>
 <68C85B5FC2FE974B87244D7222BC92783EA1EB8C@ORSMSX102.amr.corp.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE7DA@ORSMSX104.amr.corp.intel.com>
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
> > Subject: [e1000-patches][net-next PATCH S8 10/15] i40evf: Use the
> > correct defines to match the VF registers
> >
> > From: Anjali Singhai Jain <anjali.singhai@intel.com>
> >
> > Use CTLN1 instead of CTLN for the VF relative register space.
> >
> > Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> > Change-ID: Iefba63faf0307af55fec8dbb64f26059f7d91318
> > ---
> >  drivers/net/ethernet/intel/i40evf/i40e_txrx.c   | 28 +++++++++---------
> >  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 38
> > ++++++++++++--------
> > -----
> >  2 files changed, 33 insertions(+), 33 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
