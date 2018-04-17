From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 17 Apr 2018 00:54:01 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v7 07/10] igb: Enable nfc
 filters to specify MAC addresses
References: <20180410174959.18757-1-vinicius.gomes@intel.com>
 <20180410174959.18757-8-vinicius.gomes@intel.com> 
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C83AFBF@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Brown, Aaron F
> Sent: Friday, April 13, 2018 7:22 PM
> To: 'Vinicius Costa Gomes' <vinicius.gomes@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Gomes, Vinicius <vinicius.gomes@intel.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; netdev at vger.kernel.org; Sanchez-Palencia,
> Jesus <jesus.sanchez-palencia@intel.com>
> Subject: RE: [next-queue PATCH v7 07/10] igb: Enable nfc filters to specify
> MAC addresses
> 
> > From: netdev-owner at vger.kernel.org [mailto:netdev-
> > owner at vger.kernel.org] On Behalf Of Vinicius Costa Gomes
> > Sent: Tuesday, April 10, 2018 10:50 AM
> > To: intel-wired-lan at lists.osuosl.org
> > Cc: Gomes, Vinicius <vinicius.gomes@intel.com>; Kirsher, Jeffrey T
> > <jeffrey.t.kirsher@intel.com>; netdev at vger.kernel.org; Sanchez-Palencia,
> > Jesus <jesus.sanchez-palencia@intel.com>
> > Subject: [next-queue PATCH v7 07/10] igb: Enable nfc filters to specify MAC
> > addresses
> >
> > This allows igb_add_filter()/igb_erase_filter() to work on filters
> > that include MAC addresses (both source and destination).
> >
> > For now, this only exposes the functionality, the next commit glues
> > ethtool into this. Later in this series, these APIs are used to allow
> > offloading of cls_flower filters.
> >
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > ---
> >  drivers/net/ethernet/intel/igb/igb.h         |  4 +++
> >  drivers/net/ethernet/intel/igb/igb_ethtool.c | 28
> ++++++++++++++++++++
> >  2 files changed, 32 insertions(+)
> 
> Tested by: Aaron Brown <aaron.f.brown@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
