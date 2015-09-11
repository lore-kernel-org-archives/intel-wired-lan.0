From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 11 Sep 2015 21:15:20 +0000
Subject: [Intel-wired-lan] [next PATCH S14 08/15] i40e: don't panic on
 VSI	allocation failure
In-Reply-To: <1441065295-234333-9-git-send-email-catherine.sullivan@intel.com>
References: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
 <1441065295-234333-9-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A64C8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, August 31, 2015 4:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S14 08/15] i40e: don't panic on VSI
> allocation failure
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> In some circumstances, the firmware may fail to allocate a VSI for a VF.
> When this happens, the driver does not react well to the bad news and has a
> panic attack.
> 
> To fix this problem, check the return value from i40e_alloc_vf_res and don't
> try to configure the device further if it failed. Additionally, explicitly clear the
> INIT bit when we free VF resources, so that this bit will be in the proper state
> in the failure case, and won't blow up elsewhere.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I6a20ce2b59c3458fd832032e88fa28cd42500189
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, builds, compiles, passes traffic.
