From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Fri, 16 Mar 2018 09:21:23 -0700
Subject: [Intel-wired-lan] [PATCH v2 06/15] ice: Initialize PF and setup
 miscellaneous interrupt
In-Reply-To: <20180315234802.31336-7-anirudh.venkataramanan@intel.com>
References: <20180315234802.31336-1-anirudh.venkataramanan@intel.com>
 <20180315234802.31336-7-anirudh.venkataramanan@intel.com>
Message-ID: <1e5fa2a7-0877-254b-a2d8-e635634bcaf7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/15/2018 4:47 PM, Anirudh Venkataramanan wrote:
> This patch continues the initialization flow as follows:
> 
> 1) Allocate and initialize necessary fields (like vsi, num_alloc_vsi,
>     irq_tracker, etc) in the ice_pf instance.
> 
> 2) Setup the miscellaneous interrupt handler. This also known as the
>     "other interrupt causes" (OIC) handler and is used to handle non
>     hotpath interrupts (like control queue events, link events,
>     exceptions, etc.
> 
> 3) Implement a background task to process admin queue receive (ARQ)
>     events received by the driver.
> 
> CC: Shannon Nelson <shannon.nelson@oracle.com>
> Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> ---
> v2: Removed reference to "lump" as suggested by Shannon Nelson.

Yep,
sln
Acked-by: Shannon Nelson <shannon.nelson@oracle.com>

