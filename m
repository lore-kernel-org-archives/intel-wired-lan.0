From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 17 Apr 2018 00:53:28 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v7 05/10] igb: Add support
 for enabling queue steering in filters
References: <20180410174959.18757-1-vinicius.gomes@intel.com>
 <20180410174959.18757-6-vinicius.gomes@intel.com> 
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C83AF98@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Brown, Aaron F
> Sent: Friday, April 13, 2018 7:20 PM
> To: 'Vinicius Costa Gomes' <vinicius.gomes@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; Sanchez-Palencia, Jesus <jesus.sanchez-
> palencia at intel.com>
> Subject: RE: [Intel-wired-lan] [next-queue PATCH v7 05/10] igb: Add support
> for enabling queue steering in filters
> 
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> > Behalf Of Vinicius Costa Gomes
> > Sent: Tuesday, April 10, 2018 10:50 AM
> > To: intel-wired-lan at lists.osuosl.org
> > Cc: netdev at vger.kernel.org; Sanchez-Palencia, Jesus <jesus.sanchez-
> > palencia at intel.com>
> > Subject: [Intel-wired-lan] [next-queue PATCH v7 05/10] igb: Add support
> for
> > enabling queue steering in filters
> >
> > On some igb models (82575 and i210) the MAC address filters can
> > control to which queue the packet will be assigned.
> >
> > This extends the 'state' with one more state to signify that queue
> > selection should be enabled for that filter.
> >
> > As 82575 parts are no longer easily obtained (and this was developed
> > against i210), only support for the i210 model is enabled.
> >
> > These functions are exported and will be used in the next patch.
> >
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > ---
> >  .../net/ethernet/intel/igb/e1000_defines.h    |  1 +
> >  drivers/net/ethernet/intel/igb/igb.h          |  6 +++++
> >  drivers/net/ethernet/intel/igb/igb_main.c     | 26 +++++++++++++++++++
> >  3 files changed, 33 insertions(+)
> 
> Tested by: Aaron Brown <aaron.f.brown@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
