From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Apr 2016 20:01:00 +0000
Subject: [Intel-wired-lan] [v3 next PATCH S32 06/13] i40e/i40evf: Faster
 RX	via avoiding fcoe
In-Reply-To: <1459508173-22777-7-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459508173-22777-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1459508173-22777-7-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9ACBEC@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Friday, April 01, 2016 3:56 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v3 next PATCH S32 06/13] i40e/i40evf: Faster RX
> via avoiding fcoe
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> As it turns out, calling into other files from hot path hurts performance a lot.
> In this case the majority of the time we call "check fcoe" and the packet is
> *not* fcoe, but this call was taking 5% of our total cycles spent on receive.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I080552c26e7060bc7b78504dc2763f6f0b3d8c76
> ---
> Testing Hints: Make sure RX still works, and that perf top doesn't show
> i40e_handle_fcoe_status.
> 
>  drivers/net/ethernet/intel/i40e/i40e_fcoe.c   | 12 +-----------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  8 ++++++--
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   | 10 ++++++++++
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |  4 +++-
> drivers/net/ethernet/intel/i40evf/i40e_txrx.h | 10 ++++++++++
>  5 files changed, 30 insertions(+), 14 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
RX works properly, perf top doesn't show i40e_handle_fcoe_status
