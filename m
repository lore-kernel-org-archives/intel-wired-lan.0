From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Jul 2015 21:45:46 +0000
Subject: [Intel-wired-lan] [e1000-patches][net-next PATCH S8 06/15]
 i40e: Fix ethtool offline	diagnostic with netqueues
In-Reply-To: <68C85B5FC2FE974B87244D7222BC92783EA1EBAA@ORSMSX102.amr.corp.intel.com>
References: <1436466416-95687-1-git-send-email-catherine.sullivan@intel.com>
 <1436466416-95687-6-git-send-email-catherine.sullivan@intel.com>
 <68C85B5FC2FE974B87244D7222BC92783EA1EBAA@ORSMSX102.amr.corp.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE80D@ORSMSX104.amr.corp.intel.com>
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
> > Subject: [e1000-patches][net-next PATCH S8 06/15] i40e: Fix ethtool
> > offline diagnostic with netqueues
> >
> > From: Greg Rose <gregory.v.rose@intel.com>
> >
> > Treat netqueues the same way we do virtual functions when someone
> > wants to run the ethtool offline diagnostic test.
> >
> > Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
> > Change-ID: Id48d2b933f1fd0db7be06305a93c6ebe3dc821f5
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 19
> > +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
