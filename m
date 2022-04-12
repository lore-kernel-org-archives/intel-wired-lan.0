From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Tue, 12 Apr 2022 10:39:01 +0000
Subject: [Intel-wired-lan] [PATCH net v2] ice: Fix incorrect locking in
 ice_vc_process_vf_msg()
In-Reply-To: <97c58b06-11b5-182b-eed2-e5a74824241c@intel.com>
References: <20220401104052.1711721-1-ivecera@redhat.com>
 <20220408134714.1834349-1-alexandr.lobakin@intel.com>
 <97c58b06-11b5-182b-eed2-e5a74824241c@intel.com>
Message-ID: <SJ0PR11MB5629903816D77836D62E8EAEABED9@SJ0PR11MB5629.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, April 8, 2022 6:01 PM
> To: Lobakin, Alexandr <alexandr.lobakin@intel.com>
> Cc: ivecera <ivecera@redhat.com>; netdev at vger.kernel.org; mschmidt
> <mschmidt@redhat.com>; Brett Creeley <brett@pensando.io>; open list
> <linux-kernel@vger.kernel.org>; poros <poros@redhat.com>; moderated
> list:INTEL ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S.
> Miller <davem@davemloft.net>
> Subject: Re: [Intel-wired-lan] [PATCH net v2] ice: Fix incorrect locking in
> ice_vc_process_vf_msg()
> 
> 
> On 4/8/2022 6:47 AM, Alexander Lobakin wrote:
> > From: Ivan Vecera <ivecera@redhat.com>
> > Date: Fri,  1 Apr 2022 12:40:52 +0200
> >
> >> Usage of mutex_trylock() in ice_vc_process_vf_msg() is incorrect
> >> because message sent from VF is ignored and never processed.
> >>
> >> Use mutex_lock() instead to fix the issue. It is safe because this
> >> mutex is used to prevent races between VF related NDOs and handlers
> >> processing request messages from VF and these handlers are running in
> >> ice_service_task() context. Additionally move this mutex lock prior
> >> ice_vc_is_opcode_allowed() call to avoid potential races during
> >> allowlist acccess.
> >>
> >> Fixes: e6ba5273d4ed ("ice: Fix race conditions between virtchnl
> >> handling and VF ndo ops")
> >> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> > Hey Tony,
> >
> > I guess you missed this one due to being on a vacation previously.
> > It's been previously reviewed IIRC, could you take it into net-queue?
> 
> I remember applying this but I don't see it on the tree so I must be mistaken.
> :( I'll get it applied, thanks for catching.
> 
> -Tony
> 
> >> ---
> >>   drivers/net/ethernet/intel/ice/ice_virtchnl.c | 21 +++++++------------
> >>   1 file changed, 7 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> >> b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> >> index 3f1a63815bac..a465f3743ffc 100644
> >> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> >> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> >> @@ -3642,14 +3642,6 @@ void ice_vc_process_vf_msg(struct ice_pf *pf,

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
