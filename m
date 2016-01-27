From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 27 Jan 2016 20:29:46 +0000
Subject: [Intel-wired-lan] [next PATCH S28 09/15] i40e: Do not
	disable	queues in the Legacy/MSI Interrupt handler
In-Reply-To: <1452897202-15204-10-git-send-email-joshua.a.hay@intel.com>
References: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
 <1452897202-15204-10-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98C903@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Friday, January 15, 2016 2:33 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S28 09/15] i40e: Do not disable
> queues in the Legacy/MSI Interrupt handler
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> The queues should never be enabled/disabled in the interrupt handler,
> ICR0 interrupt enable should be the only thing that needs to be dynamically
> changed in the handler.
> 
> This patch fixes that. Without this patch X722 platforms were seeing weird
> ping timings when in Legacy mode since it takes a whole lot of time for the
> HW/FW to re-enable queues.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: If065afc45d81c5a19d4a94a00cd5b8f61cefc40c
> ---
> Testing Hints (Required if no HSD): Test with legacy mode enabled.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 16 ++++++----------
> drivers/net/ethernet/intel/i40e/i40e_txrx.c | 13 -------------
>  2 files changed, 6 insertions(+), 23 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, ping times normal/consistent on X722 in Legacy mode
