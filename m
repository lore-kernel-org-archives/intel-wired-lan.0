From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Sep 2017 21:48:26 +0000
Subject: [Intel-wired-lan] [next PATCH S80-V3 09/11] i40e: add check
	for	return from find_first_bit call
In-Reply-To: <20170907120556.45699-9-alice.michael@intel.com>
References: <20170907120556.45699-1-alice.michael@intel.com>
 <20170907120556.45699-9-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA11D@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S80-V3 09/11] i40e: add check for
> return from find_first_bit call
> 
> From: Lihong Yang <lihong.yang@intel.com>
> 
> The find_first_bit function will return the size passed to search if the first set
> bit is not found. This patch adds the check in case that happens as the return
> value would be used as the index in an array and that would have caused the
> out-of-bounds access.
> 
> Detected by CoverityScan, CID 1295969 Out-of-bounds access
> 
> Signed-off-by: Lihong Yang <lihong.yang@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++++
>  1 file changed, 4 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


