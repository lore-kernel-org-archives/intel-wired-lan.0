From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 31 Mar 2022 15:17:24 +0200
Subject: [Intel-wired-lan] [PATCH net] ice: Fix incorrect locking in
 ice_vc_process_vf_msg()
In-Reply-To: <YkWpNVXYEBo/u3dm@boxer>
References: <20220331105005.2580771-1-ivecera@redhat.com>
 <YkWpNVXYEBo/u3dm@boxer>
Message-ID: <YkWp5JJ9Sp6UCTw7@boxer>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Mar 31, 2022 at 03:14:32PM +0200, Maciej Fijalkowski wrote:
> On Thu, Mar 31, 2022 at 12:50:04PM +0200, Ivan Vecera wrote:
> > Usage of mutex_trylock() in ice_vc_process_vf_msg() is incorrect
> > because message sent from VF is ignored and never processed.
> > 
> > Use mutex_lock() instead to fix the issue. It is safe because this
> 
> We need to know what is *the* issue in the first place.
> Could you please provide more context what is being fixed to the readers
> that don't have an access to bugzilla?
> 
> Specifically, what is the case that ignoring a particular message when
> mutex is already held is a broken behavior?

Uh oh, let's
CC: Brett Creeley <brett@pensando.io>

> 
> > mutex is used to prevent races between VF related NDOs and
> > handlers processing request messages from VF and these handlers
> > are running in ice_service_task() context.
> > 
> > Fixes: e6ba5273d4ed ("ice: Fix race conditions between virtchnl handling and VF ndo ops")
> > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_virtchnl.c | 10 +---------
> >  1 file changed, 1 insertion(+), 9 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> > index 3f1a63815bac..9bf5bb008128 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> > @@ -3660,15 +3660,7 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event)
> >  		return;
> >  	}
> >  
> > -	/* VF is being configured in another context that triggers a VFR, so no
> > -	 * need to process this message
> > -	 */
> > -	if (!mutex_trylock(&vf->cfg_lock)) {
> > -		dev_info(dev, "VF %u is being configured in another context that will trigger a VFR, so there is no need to handle this message\n",
> > -			 vf->vf_id);
> > -		ice_put_vf(vf);
> > -		return;
> > -	}
> > +	mutex_lock(&vf->cfg_lock);
> >  
> >  	switch (v_opcode) {
> >  	case VIRTCHNL_OP_VERSION:
> > -- 
> > 2.34.1
> > 
> > _______________________________________________
> > Intel-wired-lan mailing list
> > Intel-wired-lan at osuosl.org
> > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
