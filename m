From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Sat, 29 May 2021 00:19:48 +0000
Subject: [Intel-wired-lan] [PATCH][next] virtchnl: Replace one-element
 array in struct virtchnl_vsi_queue_config_info
In-Reply-To: <85e62583-5db9-ac5c-fdf9-8e3f6a50f3fa@embeddedor.com>
References: <20210525231658.GA176466@embeddedor>
 <f3674339c0390ced22b365101f2d3e3a2bf26845.camel@intel.com>
 <85e62583-5db9-ac5c-fdf9-8e3f6a50f3fa@embeddedor.com>
Message-ID: <7273a541a4864fcfb1a7ba2e105885d3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Gustavo A. R. Silva
> Sent: Friday, May 28, 2021 4:05 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; gustavoars at kernel.org
> Cc: intel-wired-lan at lists.osuosl.org; linux-kernel at vger.kernel.org; linux-
> hardening at vger.kernel.org
> Subject: Re: [Intel-wired-lan] [PATCH][next] virtchnl: Replace one-element array
> in struct virtchnl_vsi_queue_config_info
> 
> 
> 
> On 5/28/21 16:56, Nguyen, Anthony L wrote:
> > On Tue, 2021-05-25 at 18:16 -0500, Gustavo A. R. Silva wrote:
> >> There is a regular need in the kernel to provide a way to declare
> >> having a
> >> dynamically sized set of trailing elements in a structure. Kernel
> >> code
> >> should always use ?flexible array members?[1] for these cases. The
> >> older
> >> style of one-element or zero-length arrays should no longer be
> >> used[2].
> >>
> >> Refactor the code according to the use of a flexible-array member in
> >> struct
> >> virtchnl_vsi_queue_config_info instead of one-element array, and use
> >> the
> >> flex_array_size() helper.
> >>
> >> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> >> [2]
> >> https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-
> length-and-one-element-arrays
> >>
> >> Link: https://github.com/KSPP/linux/issues/79
> >> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> >> ---
> >>  include/linux/avf/virtchnl.h | 9 ++++-----
> >>  1 file changed, 4 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/include/linux/avf/virtchnl.h
> >> b/include/linux/avf/virtchnl.h
> >> index b554913804bd..ed9c4998f8ac 100644
> >> --- a/include/linux/avf/virtchnl.h
> >> +++ b/include/linux/avf/virtchnl.h
> >> @@ -338,10 +338,10 @@ struct virtchnl_vsi_queue_config_info {
> >>  	u16 vsi_id;
> >>  	u16 num_queue_pairs;
> >>  	u32 pad;
> >> -	struct virtchnl_queue_pair_info qpair[1];
> >> +	struct virtchnl_queue_pair_info qpair[];
> >>  };
> >>
> >> -VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_vsi_queue_config_info);
> >> +VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_vsi_queue_config_info);
> >>
> >>  /* VIRTCHNL_OP_REQUEST_QUEUES
> >>   * VF sends this message to request the PF to allocate additional
> >> queues to
> >> @@ -997,9 +997,8 @@ virtchnl_vc_validate_vf_msg(struct
> >> virtchnl_version_info *ver, u32 v_opcode,
> >>  		if (msglen >= valid_len) {
> >>  			struct virtchnl_vsi_queue_config_info *vqc =
> >>  			    (struct virtchnl_vsi_queue_config_info
> >> *)msg;
> >> -			valid_len += (vqc->num_queue_pairs *
> >> -				      sizeof(struct
> >> -					     virtchnl_queue_pair_info))
> >> ;
> >> +			valid_len += flex_array_size(vqc, qpair,
> >> +						     vqc-
> >>> num_queue_pairs);
> >
> > The virtchnl file acts as a binary interface between physical and
> > virtual functions. There's no guaruntee that the PF and VF will both
> > have the newest version. Thus changing this will break compatibility.
> > Specifically, the way the size was validated for this op code
> > incorrectly expects an extra queue pair structure. Some other
> > structures have similar length calculation flaws. We agree that fixing
> > this is important, but the fix needs to account that old drivers will
> > send an off by 1 size.
> >
> > To properly handle compatibility we need to introduce a feature flag to
> > indicate the new behavior. If the feature flag is not set, we acccept
> > messages with the old format (with the extra size). If both the PF and
> > VF support the feature flag, we'll use the correct size calculations.
> > We're looking to add this and would like to do all the virtchnl
> > structure fixes in one series.
> >
> 
> Oh OK, I see. In this case, I think something like this might work just
> fine:
> 
> https://git.kernel.org/linus/c0a744dcaa29e9537e8607ae9c965ad936124a4d
> 
> What do you think?
> 

About half our virtchnl structures correctly validate the length (i.e. enforcing that the number of members including the implicit one are correct). There are maybe 3-4 which don't do that and accidentally allow sizes that are off by 1 member.

We believe the correct fix is to fix the structure definitions to use [] and then introduce a VALIDATE_MSG_V2 feature flag which is negotiated by the VF indicating whether it supports this behavior, and the PF replying to VF if it supports.

In the case where the VF doesn't support this, the PF will notice this and modify its length calculations for the handful of currently broken checks to include one extra member. In the case where the VF supports this but the PF does not, the VF must allocate extra memory and ensure it passes the larger message length. In the case where both PF and VF support the new "feature" we'll correctly switch to using 0 length flexible arrays.

It's actually even slightly more convoluted because another 3-4 ops only mis-validate the size when the length of the flexible array is 0. In that case, they require the full size of the structure, but in the case where it's 1 or more, they require the size to match as you would expect with a 0-sized array.

I'm not sure the union approach is suitable for that? We believe the use of a new capability bit is the best mechanism: we can fix the code to use flexible array definitions everywhere and simply ensure that when communicating with old PF or VF, we add additional padding as necessary to the message.

Thanks,
Jake
 
