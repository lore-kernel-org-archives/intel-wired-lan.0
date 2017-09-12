From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Sep 2017 21:52:51 +0000
Subject: [Intel-wired-lan] [next PATCH S80-V3 11/11] i40e: use a
	local	variable instead of calculating multiple times
In-Reply-To: <20170907120556.45699-11-alice.michael@intel.com>
References: <20170907120556.45699-1-alice.michael@intel.com>
 <20170907120556.45699-11-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA12E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, September 7, 2017 5:06 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S80-V3 11/11] i40e: use a local variable
> instead of calculating multiple times
> 
> From: Lihong Yang <lihong.yang@intel.com>
> 
> The computed result of I40E_MAX_VSI_QP *
> I40E_VIRTCHNL_SUPPORTED_QTYPES is used more than three times in
> function i40e_config_irq_link_list.
> Simply declare a local variable to store it to improve readability.
> 
> Signed-off-by: Lihong Yang <lihong.yang@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


