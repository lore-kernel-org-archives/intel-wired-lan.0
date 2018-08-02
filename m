From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 2 Aug 2018 18:32:21 +0000
Subject: [Intel-wired-lan] [next PATCH S93 07/11] i40e: remove
 unnecessary i variable causing -Wshadow warning
In-Reply-To: <20180731104148.11896-7-alice.michael@intel.com>
References: <20180731104148.11896-1-alice.michael@intel.com>
 <20180731104148.11896-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2DB372@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, July 31, 2018 3:42 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S93 07/11] i40e: remove unnecessary i
> variable causing -Wshadow warning
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Commit c61c8fe1d592 ("i40e: Implement an ethtool private flag to stop LLDP
> in FW") added an extra for-loop which added a shadowing 'i'
> variable as the index.
> 
> However, the local variable i already exists, and we already use it as a loop
> index. Additionally, at this point, there is no further use of the variable, so it's
> safe to simply overwrite the variable contents.
> 
> This fixes a -Wshadow warning which has started being enabled on some
> distributions
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Malek, Patryk <patryk.malek@intel.com>
> Change-ID: I1d2259d27ccab6927efd40fb1853af74678680b8
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 -
>  1 file changed, 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
