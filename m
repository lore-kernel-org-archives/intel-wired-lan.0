From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Oct 2016 19:23:29 +0000
Subject: [Intel-wired-lan] [next PATCH S49-V2 02/15] i40e: make use
	of	__dev_uc_sync and __dev_mc_sync
In-Reply-To: <1475685046-16900-3-git-send-email-bimmy.pujari@intel.com>
References: <1475685046-16900-1-git-send-email-bimmy.pujari@intel.com>
 <1475685046-16900-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0FC60@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, October 05, 2016 9:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S49-V2 02/15] i40e: make use of
> __dev_uc_sync and __dev_mc_sync
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The kernel provides __dev_uc_sync and __dev_mc_sync in order for drivers
> which need individual notification of add and delete for each filter.
> These functions allow us to vastly simplify our .set_rx_mode handler. We
> need to implement two functions for sync and unsync which add and remove
> filters respectively.
> 
> This change avoids a very complex and inefficient algorithm which resulted in
> an abnormal latency for the .set_rx_mode ndo operation. The resulting code
> after this change is more readable, more efficient, and less code.
> 
> Due to the callback signature used by these functions we also must update
> several other functions to take a const u8 * pointer.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-Id: I2ca7fd4e10c0c07ed2291db1ea41bf5987fc6474
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  10 +--
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 113 ++++++++++++++++-----
> -------
>  2 files changed, 69 insertions(+), 54 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

