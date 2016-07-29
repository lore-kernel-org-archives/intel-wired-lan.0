From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 29 Jul 2016 16:10:44 +0000
Subject: [Intel-wired-lan] [next PATCH S40-V2 04/12] i40evf: add
	missing	rtnl_lock() around i40evf_set_interrupt_capability
In-Reply-To: <1469646161-30024-5-git-send-email-bimmy.pujari@intel.com>
References: <1469646161-30024-1-git-send-email-bimmy.pujari@intel.com>
 <1469646161-30024-5-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EB8DE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, July 27, 2016 12:03 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S40-V2 04/12] i40evf: add missing
> rtnl_lock() around i40evf_set_interrupt_capability
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The function calls netif_set_real_num_(tx|rx)_queues, both of which should
> be done only under rntl lock. Unfortunately the i40evf_init_task did not hold
> the rtnl_lock as necessary. This patch adds the locking needed.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Ib72a21c3ce22b71a226b16f9bbe0f5f8cc3e849b
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
