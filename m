From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jul 2019 21:42:45 +0000
Subject: [Intel-wired-lan] [next PATCH S7 8/9] i40e: verify string count
 matches even on early return
In-Reply-To: <20190702122259.79070-8-alice.michael@intel.com>
References: <20190702122259.79070-1-alice.michael@intel.com>
 <20190702122259.79070-8-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FD290@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, July 2, 2019 5:23 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S7 8/9] i40e: verify string count
> matches even on early return
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Similar to i40e_get_ethtool_stats, add a goto to verify that the data pointer
> for the strings lines up with the expected stats count. This helps ensure that
> bugs are not introduced when adding stats.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


