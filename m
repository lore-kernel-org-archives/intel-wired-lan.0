From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 18 Nov 2019 10:33:28 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: Fix virtchnl_queue_select
 bitmap validation
In-Reply-To: <9C221CD4-702F-4A6F-8475-2A67012ADD10@intel.com>
References: <20191113192817.531297-1-jeffrey.t.kirsher@intel.com>
 <d05e40a7ad5246cdba8f63a6825ce9d9@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B971758C2@ORSMSX103.amr.corp.intel.com>
 ,<897250446bee4cdc987a9478db97873a@intel.com>
 <9C221CD4-702F-4A6F-8475-2A67012ADD10@intel.com>
Message-ID: <65af69ddd8880c3c288cd90cb0298f2162b2c48c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2019-11-15 at 18:43 -0800, Brandeburg, Jesse wrote:
> Brett is out on vacation but you?re right Andrew, the code should use
> plural variables. 

Yep, it was my fault.  I fat fingered the typo when creating the patch.
I have fixed the patch on my tree, just have not sent an updated patch
to IWL yet, to properly reflect the change.

> 
> > On Nov 15, 2019, at 16:08, Bowers, AndrewX <
> > andrewx.bowers at intel.com> wrote:
> > 
> > I was getting the same thing. Taking the compiler's suggestion and
> > changing _queue to _queues and it compiles but nobody responded to
> > my comments. 
> > 
> > > -----Original Message-----
> > > From: Brown, Aaron F
> > > Sent: Friday, November 15, 2019 3:53 PM
> > > To: Bowers, AndrewX <andrewx.bowers@intel.com>; Kirsher, Jeffrey
> > > T
> > > <jeffrey.t.kirsher@intel.com>; intel-wired-lan at lists.osuosl.org
> > > Cc: Creeley, Brett <brett.creeley@intel.com>; Arkady Gilinksky
> > > <arkady.gilinsky@harmonicinc.com>
> > > Subject: RE: [Intel-wired-lan] [PATCH] i40e: Fix
> > > virtchnl_queue_select bitmap
> > > validation
> > > 
> > > This patch is causing a compile error for me.  If I pop revert it
> > > my compile
> > > error goes away:
> > > ---------------------------------------------------------------
> > > drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c: In function
> > > 'i40e_vc_validate_vqs_bitmaps':
> > > drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2333:9: error:
> > > 'struct
> > > virtchnl_queue_select' has no member named 'rx_queue'
> > >      vqs->rx_queue >= BIT(I40E_MAX_VF_QUEUES) ||
> > >         ^
> > > drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2334:9: error:
> > > 'struct
> > > virtchnl_queue_select' has no member named 'tx_queue'
> > >      vqs->tx_queue >= BIT(I40E_MAX_VF_QUEUES))
> > >         ^
> > > make[6]: *** [drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.o]
> > > Error 1
> > > make[6]: *** Waiting for unfinished jobs....
> > > make[5]: *** [drivers/net/ethernet/intel/i40e] Error 2
> > > make[4]: *** [drivers/net/ethernet/intel] Error 2
> > > make[4]: *** Waiting for unfinished jobs....
> > > make[3]: *** [drivers/net/ethernet] Error 2
> > > make[2]: *** [drivers/net] Error 2
> > > make[1]: *** [drivers] Error 2
> > > make: *** [sub-make] Error 2
> > > 
> > > > -----Original Message-----
> > > > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On
> > > > Behalf
> > > > Of Bowers, AndrewX
> > > > Sent: Thursday, November 14, 2019 5:17 PM
> > > > To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-
> > > > wired-
> > > > lan at lists.osuosl.org
> > > > Cc: Creeley, Brett <brett.creeley@intel.com>; Arkady Gilinksky
> > > > <arkady.gilinsky@harmonicinc.com>
> > > > Subject: Re: [Intel-wired-lan] [PATCH] i40e: Fix
> > > > virtchnl_queue_select
> > > > bitmap validation
> > > > 
> > > > Comments inline
> > > > 
> > > > > -----Original Message-----
> > > > > From: Intel-wired-lan [mailto:
> > > > > intel-wired-lan-bounces at osuosl.org] On
> > > > > Behalf Of Jeff Kirsher
> > > > > Sent: Wednesday, November 13, 2019 11:28 AM
> > > > > To: intel-wired-lan at lists.osuosl.org
> > > > > Cc: Creeley, Brett <brett.creeley@intel.com>; Arkady
> > > > > Gilinksky
> > > > > <arkady.gilinsky@harmonicinc.com>
> > > > > Subject: [Intel-wired-lan] [PATCH] i40e: Fix
> > > > > virtchnl_queue_select
> > > > > bitmap validation
> > > > > 
> > > > > From: Brett Creeley <brett.creeley@intel.com>
> > > > > 
> > > > > Currently in i40e_vc_disable_queues_msg() we are incorrectly
> > > > > validating
> > > > the
> > > > > virtchnl queue select bitmaps. The virtchnl_queue_select
> > > > > rx_queues
> > > > > and tx_queue bitmap is being compared against
> > > > > ICE_MAX_VF_QUEUES,
> > > but
> > > > the
> > > > > problem is that these bitmaps can have a value greater than
> > > > > I40E_MAX_VF_QUEUES.
> > > > > Fix this by comparing the bitmaps against
> > > > > BIT(I40E_MAX_VF_QUEUES).
> > > > > 
> > > > > Also, add the function i40e_vc_validate_vqs_bitmaps() that
> > > > > checks to
> > > > > see if both virtchnl_queue_select bitmaps are empty along
> > > > > with
> > > > > checking that
> > > > the
> > > > > bitmaps only have valid bits set. This function can then be
> > > > > used in
> > > > > both the queue enable and disable flows.
> > > > > 
> > > > > Suggested-by: Arkady Gilinksky <
> > > > > arkady.gilinsky at harmonicinc.com>
> > > > > Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> > > > > ---
> > > > > .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 22
> > > > > +++++++++++++++----
> > > > > 1 file changed, 18 insertions(+), 4 deletions(-)
> > > > > 
> > > <snip>
> > _______________________________________________
> > Intel-wired-lan mailing list
> > Intel-wired-lan at osuosl.org
> > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20191118/fcb4ade1/attachment.asc>
