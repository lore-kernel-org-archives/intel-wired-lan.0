From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 17 Apr 2018 00:52:04 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v7 01/10] igb: Fix not
 adding filter elements to the list
References: <20180410174959.18757-1-vinicius.gomes@intel.com>
 <20180410174959.18757-2-vinicius.gomes@intel.com> 
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C83AF42@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Brown, Aaron F
> Sent: Friday, April 13, 2018 7:17 PM
> To: 'Vinicius Costa Gomes' <vinicius.gomes@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Gomes, Vinicius <vinicius.gomes@intel.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; netdev at vger.kernel.org; Sanchez-Palencia,
> Jesus <jesus.sanchez-palencia@intel.com>
> Subject: RE: [next-queue PATCH v7 01/10] igb: Fix not adding filter elements
> to the list
> 
> > From: netdev-owner at vger.kernel.org [mailto:netdev-
> > owner at vger.kernel.org] On Behalf Of Vinicius Costa Gomes
> > Sent: Tuesday, April 10, 2018 10:50 AM
> > To: intel-wired-lan at lists.osuosl.org
> > Cc: Gomes, Vinicius <vinicius.gomes@intel.com>; Kirsher, Jeffrey T
> > <jeffrey.t.kirsher@intel.com>; netdev at vger.kernel.org; Sanchez-Palencia,
> > Jesus <jesus.sanchez-palencia@intel.com>
> > Subject: [next-queue PATCH v7 01/10] igb: Fix not adding filter elements to
> > the list
> >
> > Because the order of the parameters passes to 'hlist_add_behind()' was
> > inverted, the 'parent' node was added "behind" the 'input', as input
> > is not in the list, this causes the 'input' node to be lost.
> >
> > Fixes: 0e71def25281 ("igb: add support of RX network flow classification")
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > ---
> >  drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Tested by: Aaron Brown <aaron.f.brown@intel.com>
Resending with "Tested-by..." rather then "Tested by..." so that patchwork actually picks it up.  What I get for signing off on the mails late Friday.
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
