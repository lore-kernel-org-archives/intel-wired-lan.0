From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Oct 2017 17:33:22 +0000
Subject: [Intel-wired-lan] [PATCH net-next] i40e: fix u64 division usage
In-Reply-To: <20171009224845.3216-1-alan.brady@intel.com>
References: <20171009224845.3216-1-alan.brady@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAC228@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alan Brady
> Sent: Monday, October 9, 2017 3:49 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next] i40e: fix u64 division usage
> 
> Commit 52eb1ff93e98 ("i40e: Add support setting TC max bandwidth rates")
> and commit 1ea6f21ae530 ("i40e: Refactor VF BW rate limiting") add some
> needed functionality for TC bandwidth rate limiting.  Unfortunately they
> introduce several usages of unsigned 64-bit division which needs to be
> handled special by the kernel to support all architectures.
> 
> Fixes: 52eb1ff93e98 ("i40e: Add support setting TC max bandwidth
> rates")
> Fixes: 1ea6f21ae530 ("i40e: Refactor VF BW rate limiting")
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  3 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 59 +++++++++++++++++++--
> --------
>  2 files changed, 42 insertions(+), 20 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


