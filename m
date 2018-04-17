From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 17 Apr 2018 00:52:26 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v7 02/10] igb: Fix queue
 selection on MAC filters on i210
References: <20180410174959.18757-1-vinicius.gomes@intel.com>
 <20180410174959.18757-3-vinicius.gomes@intel.com> 
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C83AF50@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Brown, Aaron F
> Sent: Friday, April 13, 2018 7:18 PM
> To: 'Vinicius Costa Gomes' <vinicius.gomes@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; Sanchez-Palencia, Jesus <jesus.sanchez-
> palencia at intel.com>
> Subject: RE: [Intel-wired-lan] [next-queue PATCH v7 02/10] igb: Fix queue
> selection on MAC filters on i210
> 
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> > Behalf Of Vinicius Costa Gomes
> > Sent: Tuesday, April 10, 2018 10:50 AM
> > To: intel-wired-lan at lists.osuosl.org
> > Cc: netdev at vger.kernel.org; Sanchez-Palencia, Jesus <jesus.sanchez-
> > palencia at intel.com>
> > Subject: [Intel-wired-lan] [next-queue PATCH v7 02/10] igb: Fix queue
> > selection on MAC filters on i210
> >
> > On the RAH registers there are semantic differences on the meaning of
> > the "queue" parameter for traffic steering depending on the controller
> > model: there is the 82575 meaning, which "queue" means a RX Hardware
> > Queue, and the i350 meaning, where it is a reception pool.
> >
> > The previous behaviour was having no effect for i210 based controllers
> > because the QSEL bit of the RAH register wasn't being set.
> >
> > This patch separates the condition in discrete cases, so the different
> > handling is clearer.
> >
> > Fixes: 83c21335c876 ("igb: improve MAC filter handling")
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > ---
> >  drivers/net/ethernet/intel/igb/igb_main.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> 
> Tested by: Aaron Brown <aaron.f.brown@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
