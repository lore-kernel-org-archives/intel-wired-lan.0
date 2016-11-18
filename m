From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 18 Nov 2016 17:48:30 +0000
Subject: [Intel-wired-lan] [next PATCH S54 12/15] i40e: avoid O(n^2)
 loop	when deleting all filters
In-Reply-To: <1478896779-13697-13-git-send-email-bimmy.pujari@intel.com>
References: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
 <1478896779-13697-13-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA38174@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, November 11, 2016 12:40 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S54 12/15] i40e: avoid O(n^2) loop
> when deleting all filters
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Use __i40e_del_filter instead of using i40e_del_filter() which will avoid doing
> an additional search to delete a filter we already have the pointer for.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Iea5a7e3cafbf8c682ed9d3b6c69cf5ff53f44daf
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
>  3 files changed, 3 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

