From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 3 Aug 2015 15:48:26 +0000
Subject: [Intel-wired-lan] [e1000-patches][net-next PATCH S8 07/15]
 i40e/i40evf: Add capability	to gather VEB per TC stats
In-Reply-To: <68C85B5FC2FE974B87244D7222BC92783EA1EBA2@ORSMSX102.amr.corp.intel.com>
References: <1436466416-95687-1-git-send-email-catherine.sullivan@intel.com>
 <1436466416-95687-7-git-send-email-catherine.sullivan@intel.com>
 <68C85B5FC2FE974B87244D7222BC92783EA1EBA2@ORSMSX102.amr.corp.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BECA5@ORSMSX104.amr.corp.intel.com>
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
> > Subject: [e1000-patches][net-next PATCH S8 07/15] i40e/i40evf: Add
> > capability to gather VEB per TC stats
> >
> > From: Neerav Parikh <Neerav.Parikh@intel.com>
> >
> > This patch adds capability to update per VEB per TC statistics and
> > dump it via ethtool. It also adds a structure to hold VEB per TC statistics.
> > The fields can be filled by reading the GLVEBTC_* counters.
> >
> > Signed-off-by: Neerav Parikh <Neerav.Parikh@intel.com>
> > Change-ID: I28b4759b9ab6ad5a61f046a1bc9ef6b16fe31538
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e.h         |  2 ++
> >  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 23
> > ++++++++++++++++++++-
> >  drivers/net/ethernet/intel/i40e/i40e_main.c    | 28
> > +++++++++++++++++++++++++-
> >  drivers/net/ethernet/intel/i40e/i40e_type.h    |  8 ++++++++
> >  drivers/net/ethernet/intel/i40evf/i40e_type.h  |  8 ++++++++
> >  5 files changed, 67 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

FCOE patch, does not break base driver.
