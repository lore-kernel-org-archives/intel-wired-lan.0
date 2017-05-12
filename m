From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 May 2017 17:57:58 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 05/14] virtchnl: move
	some	code to core driver
In-Reply-To: <20170511182321.147850-6-jesse.brandeburg@intel.com>
References: <20170511182321.147850-1-jesse.brandeburg@intel.com>
 <20170511182321.147850-6-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA310A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Thursday, May 11, 2017 11:23 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v3 05/14] virtchnl: move some
> code to core driver
> 
> Before moving this function over to virtchnl.h, move some driver specific
> checks that had snuck into a fairly generic function, back into the caller of the
> function.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 30 +++++++++++++----
> -----
>  1 file changed, 18 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


