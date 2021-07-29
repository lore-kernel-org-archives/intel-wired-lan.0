From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 29 Jul 2021 22:13:34 +0000
Subject: [Intel-wired-lan] [PATCH] ice: fix build issue if
 CONFIG_1588_PTP_CLOCk=m
In-Reply-To: <BYAPR11MB336788636E4860CD17D62CFEFCEB9@BYAPR11MB3367.namprd11.prod.outlook.com>
References: <BYAPR11MB336788636E4860CD17D62CFEFCEB9@BYAPR11MB3367.namprd11.prod.outlook.com>
Message-ID: <CO1PR11MB5089698E466593B8E7ACE34CD6EB9@CO1PR11MB5089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: G, GurucharanX <gurucharanx.g@intel.com>
> Sent: Thursday, July 29, 2021 8:57 AM
> To: intel-wired-lan at osuosl.org; intel-wired-lan at lists.osuosl.org; Keller, Jacob E
> <jacob.e.keller@intel.com>
> Subject: RE: [Intel-wired-lan] [PATCH] ice: fix build issue if
> CONFIG_1588_PTP_CLOCk=m
> 
> 
> > -----Original Message-----
> > From: Jacob Keller <jacob.e.keller@intel.com>
> > To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> > Subject: [Intel-wired-lan] [PATCH] ice: fix build issue if
> > 	CONFIG_1588_PTP_CLOCk=m
> > Message-ID: <20210709210726.224848-1-jacob.e.keller@intel.com>
> >
> > If the CONFIG_1588_PTP_CLOCK symbol is set to m, then the driver will
> > not compile ice_ptp.o and ice_ptp_hw.o because it adds them to ice-m
> > instead of ice-y, and nothing includes ice-m into the final kernel
> > objects.
> >
> > Fix this by using the ':m=y' so that we always compile the files and
> > link them to ice.o when CONFIG_1588_PTP_CLOCK is a module or a builtin.
> >
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > ---
> > This fixes the compilation errors that have appeared from lkp on Tony's
> > dev-queue. The lkp complains about other patches, but the root cause is this
> > issue. If we apply this, it should fix all of the lkp issues I've seen so
> > far.
> >
> >  drivers/net/ethernet/intel/ice/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> 
> Tested-by: Gurucharan  G <Gurucharanx.g@intel.com> (A Contingent Worker at
> Intel)

FWIW, this should probably be superseded with a v2 of Arnd's fix to modify the Kbuild instead.

Thanks,
Jake
