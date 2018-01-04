From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 4 Jan 2018 22:42:12 +0000
Subject: [Intel-wired-lan] [next PATCH S84-V2 09/13] i40e: Fix
 compilation issue with DPDK
In-Reply-To: <20171227132103.23973-1-alice.michael@intel.com>
References: <20171227132103.23973-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D70B0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, December 27, 2017 5:21 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S84-V2 09/13] i40e: Fix compilation
> issue with DPDK
> 
> From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> 
> When using GCC 6.3.0 and EXTRA_CFLAGS=-Og, the compiler is not smart
> enough to see that when you have an integrated VF that just one of the if
> statemets has to be true so that ntu is always set.  Fix the way that the code
> is for integrated VFs so that the compiler won't complain.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c   | 2 +-
>  drivers/net/ethernet/intel/i40evf/i40e_adminq.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


