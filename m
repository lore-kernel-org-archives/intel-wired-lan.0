From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 17 Apr 2018 00:54:41 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v7 09/10] igb: Add the
 skeletons for tc-flower offloading
References: <20180410174959.18757-1-vinicius.gomes@intel.com>
 <20180410174959.18757-10-vinicius.gomes@intel.com> 
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C83AFE4@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Brown, Aaron F
> Sent: Friday, April 13, 2018 7:23 PM
> To: 'Vinicius Costa Gomes' <vinicius.gomes@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; Sanchez-Palencia, Jesus <jesus.sanchez-
> palencia at intel.com>
> Subject: RE: [Intel-wired-lan] [next-queue PATCH v7 09/10] igb: Add the
> skeletons for tc-flower offloading
> 
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> > Behalf Of Vinicius Costa Gomes
> > Sent: Tuesday, April 10, 2018 10:50 AM
> > To: intel-wired-lan at lists.osuosl.org
> > Cc: netdev at vger.kernel.org; Sanchez-Palencia, Jesus <jesus.sanchez-
> > palencia at intel.com>
> > Subject: [Intel-wired-lan] [next-queue PATCH v7 09/10] igb: Add the
> > skeletons for tc-flower offloading
> >
> > This adds basic functions needed to implement offloading for filters
> > created by tc-flower.
> >
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > ---
> >  drivers/net/ethernet/intel/igb/igb_main.c | 66
> > +++++++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >
> 
> Tested by: Aaron Brown <aaron.f.brown@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
