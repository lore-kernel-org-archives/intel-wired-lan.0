From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 21 Aug 2018 19:41:47 +0000
Subject: [Intel-wired-lan] [next PATCH S95 11/12] virtchnl: use u8 type
 for a field in the virtchnl_filter struct
In-Reply-To: <20180820151233.14629-11-alice.michael@intel.com>
References: <20180820151233.14629-1-alice.michael@intel.com>
 <20180820151233.14629-11-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2E96C9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, August 20, 2018 8:13 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S95 11/12] virtchnl: use u8 type for a
> field in the virtchnl_filter struct
> 
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> The virtchnl_filter struct has a field called field_flags. A previous commit
> mistakenly had the type to be a __u8. What we want is for the field to be an
> unsigned 8 bit value, so let's just use the existing kernel type u8 for that.
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> ---
>  include/linux/avf/virtchnl.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


