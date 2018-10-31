From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Oct 2018 16:27:18 +0000
Subject: [Intel-wired-lan] [next PATCH S98 4/6] virtchnl: Fix off by one
 error
In-Reply-To: <20181026213333.51495-4-alice.michael@intel.com>
References: <20181026213333.51495-1-alice.michael@intel.com>
 <20181026213333.51495-4-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328FA7@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, October 26, 2018 2:34 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S98 4/6] virtchnl: Fix off by one error
> 
> When calculating the valid length for a VIRTCHNL_OP_ENABLE_CHANNELS
> message, we accidentally allowed messages with one extra
> virtchnl_channel_info structure on the end. This happened due to an off by
> one error, because we forgot that valid_len already accounted for one
> virtchnl_channel_info structure, so we need to subtract one from the
> num_tc value.
> 
> Signed-off-by: Alice Michael <alice.michael@intel.com>
> ---
>  include/linux/avf/virtchnl.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


