From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Mon, 25 Apr 2022 09:14:04 +0000
Subject: [Intel-wired-lan] [PATCH net v2] ice: Protect vf_state check by
 cfg_lock in ice_vc_process_vf_msg()
In-Reply-To: <CO1PR11MB5089EDB8FE93BA8B8905E889D6F49@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20220419142221.2349382-1-ivecera@redhat.com>
 <CO1PR11MB5089EDB8FE93BA8B8905E889D6F49@CO1PR11MB5089.namprd11.prod.outlook.com>
Message-ID: <DM8PR11MB5621D15FE88382CAA06B4C2DABF89@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Keller, Jacob E
> Sent: Thursday, April 21, 2022 6:41 PM
> To: ivecera <ivecera@redhat.com>; netdev at vger.kernel.org
> Cc: Fei Liu <feliu@redhat.com>; mschmidt <mschmidt@redhat.com>; Brett
> Creeley <brett.creeley@intel.com>; open list <linux-
> kernel at vger.kernel.org>; moderated list:INTEL ETHERNET DRIVERS <intel-
> wired-lan at lists.osuosl.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>
> Subject: Re: [Intel-wired-lan] [PATCH net v2] ice: Protect vf_state check by
> cfg_lock in ice_vc_process_vf_msg()
> 
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Ivan Vecera
> > Sent: Tuesday, April 19, 2022 7:22 AM
> > To: netdev at vger.kernel.org
> > Cc: Fei Liu <feliu@redhat.com>; moderated list:INTEL ETHERNET DRIVERS
> > <intel- wired-lan@lists.osuosl.org>; mschmidt <mschmidt@redhat.com>;
> > Brett Creeley <brett.creeley@intel.com>; open list
> > <linux-kernel@vger.kernel.org>; Jakub Kicinski <kuba@kernel.org>;
> > Paolo Abeni <pabeni@redhat.com>; David S. Miller
> <davem@davemloft.net>
> > Subject: [Intel-wired-lan] [PATCH net v2] ice: Protect vf_state check
> > by cfg_lock in
> > ice_vc_process_vf_msg()
> >
> > Previous patch labelled "ice: Fix incorrect locking in
> > ice_vc_process_vf_msg()"  fixed an issue with ignored messages sent by
> > VF driver but a small race window still left.
> >
> > Recently caught trace during 'ip link set ... vf 0 vlan ...' operation:
> >
> > [ 7332.995625] ice 0000:3b:00.0: Clearing port VLAN on VF 0 [
> > 7333.001023] iavf 0000:3b:01.0: Reset indication received from the PF
> > [ 7333.007391] iavf 0000:3b:01.0: Scheduling reset task [ 7333.059575]
> > iavf 0000:3b:01.0: PF returned error -5 (IAVF_ERR_PARAM) to our
> > request 3 [ 7333.059626] ice 0000:3b:00.0: Invalid message from VF 0,
> > opcode 3, len 4, error -1
> >
> > Setting of VLAN for VF causes a reset of the affected VF using
> > ice_reset_vf() function that runs with cfg_lock taken:
> >
> > 1. ice_notify_vf_reset() informs IAVF driver that reset is needed and
> >    IAVF schedules its own reset procedure 2. Bit ICE_VF_STATE_DIS is
> > set in vf->vf_state 3. Misc initialization steps 4.
> > ice_sriov_post_vsi_rebuild() -> ice_vf_set_initialized() and that
> >    clears ICE_VF_STATE_DIS in vf->vf_state
> >
> > Step 3 is mentioned race window because IAVF reset procedure runs in
> > parallel and one of its step is sending of
> > VIRTCHNL_OP_GET_VF_RESOURCES message (opcode==3). This message
> is
> > handled in ice_vc_process_vf_msg() and if it is received during the
> > mentioned race window then it's marked as invalid and error is returned to
> VF driver.
> >
> > Protect vf_state check in ice_vc_process_vf_msg() by cfg_lock to avoid
> > this race condition.
> >
> > Fixes: e6ba5273d4ed ("ice: Fix race conditions between virtchnl
> > handling and VF ndo ops")
> > Tested-by: Fei Liu <feliu@redhat.com>
> > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> 
> Thanks, this looks good to me.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> > ---
> >  drivers/net/ethernet/intel/ice/ice_virtchnl.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> > b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> > index 5612c032f15a..b72606c9e6d0 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> > @@ -3625,6 +3625,8 @@ void ice_vc_process_vf_msg(struct ice_pf *pf,
> > struct ice_rq_event_info *event)

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>

