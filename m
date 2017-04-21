From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 21 Apr 2017 18:09:00 +0000
Subject: [Intel-wired-lan] [next PATCH S71 06/10] i40e: use
 DECLARE_BITMAP	for state fields
In-Reply-To: <20170419132559.20459-6-alice.michael@intel.com>
References: <20170419132559.20459-1-alice.michael@intel.com>
 <20170419132559.20459-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA1288@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 19, 2017 6:26 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S71 06/10] i40e: use
> DECLARE_BITMAP for state fields
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Instead of assuming our flags fit within an unsigned long, use
> DECLARE_BITMAP which will ensure that we always allocate enough space.
> Additionally, use __I40E_STATE_SIZE__ markers as the last element of the
> enumeration so that the size of the BITMAP is compile-time assigned
> rather than programmer-time assigned. This ensures that potential future
> flag additions do not actually overrun the array. This is especially
> important as 32bit systems would only have 32bit longs instead of 64bit
> longs as we generally have assumed in the prior code.
> 
> This change also removes a dereference of the state fields throughout
> the code, so it does have a bit of code churn. The conversions were
> automated using sed replacements with an alternation
> 
>   s/&(vsi->back|vsi|pf)->state/\1->state/
>   s/&adapter->vsi.state/adapter->vsi.state/
> 
> For debugfs, we modify the printing so that we can display chunks of the
> state value on new lines. This ensures that we can print the entire set
> of state values. Additionally, we now print them as 08lx to ensure that
> they display nicely.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             |   8 +-
>  drivers/net/ethernet/intel/i40e/i40e_client.c      |  16 +-
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |  13 +-
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  42 ++--
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 231 ++++++++++-----------
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c         |   4 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  14 +-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  18 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |   8 +-
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |   4 +-
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  10 +-
>  11 files changed, 188 insertions(+), 180 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


