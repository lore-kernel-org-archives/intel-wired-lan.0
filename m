From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 Jan 2018 19:30:51 +0000
Subject: [Intel-wired-lan] [next PATCH S85-V1 11/14] i40e/i40evf: Use
 usec value instead of reg value for ITR defines
In-Reply-To: <20171229135108.14645-1-alice.michael@intel.com>
References: <20171229135108.14645-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D7267@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, December 29, 2017 5:51 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S85-V1 11/14] i40e/i40evf: Use usec
> value instead of reg value for ITR defines
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> Instead of using the register value for the defines when setting up the ring
> ITR we can just use the actual values and avoid the use of shifts and macros
> to translate between the values we have and the values we want.
> 
> This helps to make the code more readable as we can quickly translate from
> one value to the other.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 12 +++---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 11 +++++-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h        | 45 ++++++++++++----------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 11 +++++-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h      | 44 +++++++++++----------
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 12 +++---
>  6 files changed, 79 insertions(+), 56 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


