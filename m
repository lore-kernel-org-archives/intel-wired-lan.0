From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 29 Jun 2017 22:33:47 +0000
Subject: [Intel-wired-lan] [PATCH] ethtool: Add DMA Coalescing support
In-Reply-To: <1498145811-7465-1-git-send-email-paul.greenwalt@intel.com>
References: <1498145811-7465-1-git-send-email-paul.greenwalt@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAC2D0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Paul Greenwalt
> Sent: Thursday, June 22, 2017 8:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ethtool: Add DMA Coalescing support
> 
> Add support for DMA Coalescing (DMAC) hardware feature. The feature
> allows synchronization of port DMA activity across ports in order to optimize
> power consumption. DMAC is supported on igb and ixgbe devices.
> 
> Support for enabling and configuring the DMAC watchdog timer is via the
> ethtool coalesce [-c|-C] dmac option added with this patch.
> Since DMAC is disabled when interrupt moderation is disabled, placing the
> dmac option in the coalesce command provides related -c 'show'
> information with a single command. The dmac option allows the users to
> disable DMAC, or enable and set the DMAC watchdog timer. When in
> coalescing mode, this timer starts counting down when the first transaction is
> batched. The controller moves to the not coalescing state when the
> watchdog timer reaches zero.
> 
> Set usage: ethtool -C DEVNAME dmac [0 | N]
> 
> Where 0 disables DMAC, and N is watchdog timer interval in usecs.
> The device driver will check that N is within a valid range.
> 
> Example:
> Enable and configure DMAC watchdog timer to 1000 usecs:
>  # ethtool -C dmac 1000
> 
> Disable DMAC:
>  # ethtool -C dmac 0
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  ethtool-copy.h | 2 ++
>  ethtool.8.in   | 1 +
>  ethtool.c      | 8 +++++++-
>  3 files changed, 10 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



