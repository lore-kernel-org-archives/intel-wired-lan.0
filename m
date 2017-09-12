From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Sep 2017 16:53:18 +0000
Subject: [Intel-wired-lan] [next PATCH S80-V3 01/11] i40e: use the safe
 hash	table iterator when deleting mac filters
In-Reply-To: <20170907120556.45699-1-alice.michael@intel.com>
References: <20170907120556.45699-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA039@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S80-V3 01/11] i40e: use the safe hash
> table iterator when deleting mac filters
> 
> From: Lihong Yang <lihong.yang@intel.com>
> 
> This patch replaces hash_for_each function with hash_for_each_safe when
> calling  __i40e_del_filter. The hash_for_each_safe function is the right one
> to use when iterating over a hash table to safely remove a hash entry.
> Otherwise, incorrect values may be read from freed memory.
> 
> Detected by CoverityScan, CID 1402048 Read from pointer after free
> 
> Signed-off-by: Lihong Yang <lihong.yang@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


