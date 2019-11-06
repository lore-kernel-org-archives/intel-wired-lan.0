From: Arkady Gilinsky <arkady.gilinsky@harmonicinc.com>
Date: Wed, 6 Nov 2019 05:30:20 +0000
Subject: [Intel-wired-lan] [EXTERNAL] RE: [PATCH net] i40e/iavf: Fix msg
 interface between VF and PF
In-Reply-To: <3508A0C5D531054DBDD98909F6FA64FA11B39863@ORSMSX113.amr.corp.intel.com>
References: <1572845537.13810.225.camel@harmonicinc.com>
 <3508A0C5D531054DBDD98909F6FA64FA11B3936D@ORSMSX113.amr.corp.intel.com>
 <1572931430.13810.227.camel@harmonicinc.com>
 <3508A0C5D531054DBDD98909F6FA64FA11B39863@ORSMSX113.amr.corp.intel.com>
Message-ID: <1573018214.10368.1.camel@harmonicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2019-11-05 at 16:55 +0000, Creeley, Brett wrote:
> > -----Original Message-----
> > From: Arkady Gilinsky <arkady.gilinsky@harmonicinc.com>
> > Sent: Monday, November 4, 2019 9:24 PM
> > To: Creeley, Brett <brett.creeley@intel.com>; intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; Kirsher,
> > Jeffrey T
> > <jeffrey.t.kirsher@intel.com>
> > Cc: Arkady Gilinsky <arcadyg@gmail.com>
> > Subject: Re: [EXTERNAL] RE: [PATCH net] i40e/iavf: Fix msg interface between VF and PF
> > > static bool i40e_vc_verify_vqs_bitmaps(struct virtchnl_queue_select *vqs)
> > > {
> > > 	/* this will catch any changes made to the virtchnl_queue_select bitmap */
> > > 	if (sizeof(vqs->rx_queues) != sizeof(u32) ||
> > > 	?????sizeof(vqs->tx_queues) != sizeof(u32))
> > > 		return false;
> > 
> > If so, then is it better to check the type of the fields in compile-time rather than in runtime ?
> > Something like this:
> > BUILD_BUG_ON(sizeof(vqs->rx_queues) != sizeof(u32));
> > BUILD_BUG_ON(sizeof(vqs->tx_queues) != sizeof(u32));
> > This is not required comparison each time when function is called and made code more optimized.
> 
> I don't think this is required with the change you suggested below.
Agree.
If other code in driver not need to be adjusted/verified, then this check is not needed.
> 
> > > 
> > > 	if ((vqs->rx_queues == 0 && vqs->tx_queues == 0) ||
> > > 	??????hweight32(vqs->rx_queues) > I40E_MAX_VF_QUEUES ||
> > > 	??????hweight32(vqs->tx_queues) > I40E_MAX_VF_QUEUES)
> > > 		return false;
> > 
> > Again, from optimization POV it is better to have constant changed than variable,
> > since it is compile time and not run time action:
> > 	if ((vqs->rx_queues == 0 && vqs->tx_queues == 0) ||
> > 	??????vqs->rx_queues >= (BIT(I40E_MAX_VF_QUEUES)) ||
> > 
> > ??????vqs->tx_queues >= (BIT(I40E_MAX_VF_QUEUES)))
> > 		return false;
> 
> This seems much better than my solution. It fixes the original issue, handles if the
> vqs->[r|t]x_queues variables have changed in size, and the queue bitmap comparison
> uses a constant. Thanks!
Thanks to you for feedback.
I am trying to understand if this patch will enter into official kernel tree
and, not less important from my POV, to official Intel drivers.
Brett/Jeffrey, could you, please, assist to make sure that this fix, or fix suggested by Brett,
will be integrated into Intel i40e/iavf drivers ?
Or may be I should write mail straight to Intel support ?
> 
> > > 	return true;
> > > }
> 
> 
-- 
Best regards,
Arkady Gilinsky

------------------------------------------

