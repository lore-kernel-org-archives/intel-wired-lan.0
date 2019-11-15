From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 15 Nov 2019 23:52:50 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Fix virtchnl_queue_select
 bitmap validation
In-Reply-To: <d05e40a7ad5246cdba8f63a6825ce9d9@intel.com>
References: <20191113192817.531297-1-jeffrey.t.kirsher@intel.com>
 <d05e40a7ad5246cdba8f63a6825ce9d9@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971758C2@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch is causing a compile error for me.  If I pop revert it my compile error goes away:
---------------------------------------------------------------
drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c: In function 'i40e_vc_validate_vqs_bitmaps':
drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2333:9: error: 'struct virtchnl_queue_select' has no member named 'rx_queue'
      vqs->rx_queue >= BIT(I40E_MAX_VF_QUEUES) ||
         ^
drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2334:9: error: 'struct virtchnl_queue_select' has no member named 'tx_queue'
      vqs->tx_queue >= BIT(I40E_MAX_VF_QUEUES))
         ^
make[6]: *** [drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.o] Error 1
make[6]: *** Waiting for unfinished jobs....
make[5]: *** [drivers/net/ethernet/intel/i40e] Error 2
make[4]: *** [drivers/net/ethernet/intel] Error 2
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [drivers/net/ethernet] Error 2
make[2]: *** [drivers/net] Error 2
make[1]: *** [drivers] Error 2
make: *** [sub-make] Error 2

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Bowers, AndrewX
> Sent: Thursday, November 14, 2019 5:17 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Creeley, Brett <brett.creeley@intel.com>; Arkady Gilinksky
> <arkady.gilinsky@harmonicinc.com>
> Subject: Re: [Intel-wired-lan] [PATCH] i40e: Fix virtchnl_queue_select bitmap
> validation
> 
> Comments inline
> 
> > -----Original Message-----
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> > Behalf Of Jeff Kirsher
> > Sent: Wednesday, November 13, 2019 11:28 AM
> > To: intel-wired-lan at lists.osuosl.org
> > Cc: Creeley, Brett <brett.creeley@intel.com>; Arkady Gilinksky
> > <arkady.gilinsky@harmonicinc.com>
> > Subject: [Intel-wired-lan] [PATCH] i40e: Fix virtchnl_queue_select bitmap
> > validation
> >
> > From: Brett Creeley <brett.creeley@intel.com>
> >
> > Currently in i40e_vc_disable_queues_msg() we are incorrectly validating
> the
> > virtchnl queue select bitmaps. The virtchnl_queue_select rx_queues and
> > tx_queue bitmap is being compared against ICE_MAX_VF_QUEUES, but
> the
> > problem is that these bitmaps can have a value greater than
> > I40E_MAX_VF_QUEUES.
> > Fix this by comparing the bitmaps against BIT(I40E_MAX_VF_QUEUES).
> >
> > Also, add the function i40e_vc_validate_vqs_bitmaps() that checks to see if
> > both virtchnl_queue_select bitmaps are empty along with checking that
> the
> > bitmaps only have valid bits set. This function can then be used in both the
> > queue enable and disable flows.
> >
> > Suggested-by: Arkady Gilinksky <arkady.gilinsky@harmonicinc.com>
> > Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> > ---
> >  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 22 +++++++++++++++----
> >  1 file changed, 18 insertions(+), 4 deletions(-)
> >
<snip>
