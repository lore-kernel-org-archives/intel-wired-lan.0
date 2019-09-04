From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 4 Sep 2019 22:25:45 +0000
Subject: [Intel-wired-lan] [PATCH S28 v2 2/9] ice: report link down for
 VF when PF's queues are not enabled
In-Reply-To: <20190903083108.19593-2-anthony.l.nguyen@intel.com>
References: <20190903083108.19593-1-anthony.l.nguyen@intel.com>
 <20190903083108.19593-2-anthony.l.nguyen@intel.com>
Message-ID: <42ac11ca7574439aac7b1bfa1d814bbf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Tuesday, September 3, 2019 1:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S28 v2 2/9] ice: report link down for VF
> when PF's queues are not enabled
> 
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> 
> This is port of a fix from i40e commit 2ad1274fa35a ("i40e: don't report link up
> for a VF who hasn't enabled queues")
> 
> Older VF drivers do not respond well to receiving a link up notification before
> queues are enabled. This can cause their state machine to think that it is safe
> to send traffic. This results in a Tx hang on the VF.
> 
> Record whether the PF has actually enabled queues for the VF. When
> reporting link status, always report link down if the queues aren't enabled. In
> this way, the VF driver will never receive a link up notification until after its
> queues are enabled.
> 
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


