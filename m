From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 29 Jun 2017 22:33:10 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add DMA Coalescing support
In-Reply-To: <1498145734-7358-1-git-send-email-paul.greenwalt@intel.com>
References: <1498145734-7358-1-git-send-email-paul.greenwalt@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAC2C0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Paul Greenwalt
> Sent: Thursday, June 22, 2017 8:36 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Add DMA Coalescing support
> 
> Add DMA Coalescing (DMAC) support for X550, X550em_a, and X550em_x
> devices.
> DMAC can reduce total power consumption by allowing the chipset and/or
> CPU to spend more time in low-power states. DMAC is disabled by default,
> and can be enabled/disabled by the ethtool coalesce dmac parameter. The
> dmac parameter configures the watchdog timer interval in usecs. Setting
> dmac to 0 disables DMAC, and support values range is 41 - 100000 usecs.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  10 +++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  24 +++++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  23 +++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h    |  37 +++++++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c    | 102
> +++++++++++++++++++++++
>  include/uapi/linux/ethtool.h                     |   2 +
>  6 files changed, 196 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


