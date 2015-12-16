From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Dec 2015 18:31:26 +0000
Subject: [Intel-wired-lan] [next PATCH S23 01/13] i40e: Fix Rx hash
 reported	to the stack by our driver
In-Reply-To: <1449705033-4968-2-git-send-email-joshua.a.hay@intel.com>
References: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
 <1449705033-4968-2-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F96EF4A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Wednesday, December 09, 2015 3:50 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S23 01/13] i40e: Fix Rx hash reported
> to the stack by our driver
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> If the driver calls skb_set_hash even with a zero hash, that indicates to the
> stack that the hash calculation is offloaded in hardware. So the Stack doesn't
> do a SW hash which is required for load balancing if the user decides to turn
> of rx-hashing on our device.
> 
> This patch fixes the path so that we do not call skb_set_hash if the feature is
> disabled.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: Ic4debfa4ff91b5a72e447348a75768ed7a2d3e1b
> ---
> Testing Hints:Test interrupt overload x710 Apart from the interrupt overload,
> the user sees a problem where the stack is not calculating the hash when rx-
> hasing is turned off which is resulting in tpacket_v3 not balancing the load
> across multiple threads.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 54 ++++++++++++++----------
> ---
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 54 ++++++++++++++---------
> ----
>  2 files changed, 58 insertions(+), 50 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, load properly balances across queues with hashing enabled and disabled
