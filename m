From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 31 Oct 2017 19:07:06 +0000
Subject: [Intel-wired-lan] [next PATCH S81-V3 8/9] i40e: Fix for NUP
	NVM	image downgrade failure
In-Reply-To: <20171027150656.68250-8-alice.michael@intel.com>
References: <20171027150656.68250-1-alice.michael@intel.com>
 <20171027150656.68250-8-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EADD85@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, October 27, 2017 8:07 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S81-V3 8/9] i40e: Fix for NUP NVM
> image downgrade failure
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Since commit 96a39aed25e6 ("i40e: Acquire NVM lock before reads on all
> devices") we've used the NVM lock to synchronize NVM reads even on
> devices which don't strictly need the lock.
> 
> Doing so can cause a regression on older firmware prior to 1.5, especially
> when downgrading the firmware.
> 
> Fix this by only grabbing the lock if we're running on an X722 device (which
> requires the lock as it uses the AdminQ to read the NVM), or if we're
> currently running 1.5 or newer firmware.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c | 6 ++++++
> drivers/net/ethernet/intel/i40e/i40e_common.c | 3 ++-
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c    | 8 +++++---
>  drivers/net/ethernet/intel/i40e/i40e_type.h   | 1 +
>  4 files changed, 14 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


