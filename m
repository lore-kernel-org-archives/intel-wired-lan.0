From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 Jul 2020 19:59:58 +0000
Subject: [Intel-wired-lan] [PATCH S51 05/13] ice: add useful statistics
In-Reply-To: <20200730001922.52568-5-anthony.l.nguyen@intel.com>
References: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
 <20200730001922.52568-5-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB21450A76B5015A018A5A148A8C4E0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, July 29, 2020 5:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S51 05/13] ice: add useful statistics
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Display and count some useful hot-path statistics. The usefulness is as
> follows:
> 
> - tx_restart: use to determine if the transmit ring size is too small or
>   if the transmit interrupt rate is too low.
> - rx_gro_dropped: use to count drops from GRO layer, which previously
> were
>   completely uncounted when occurring.
> - tx_busy: use to determine when the driver is miscounting number of
>   descriptors needed for an skb.
> - tx_timeout: as our other drivers, count the number of times we've reset
>   due to timeout because the kernel only prints a warning once per netdev.
> 
> Several of these were already counted but not displayed.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          | 1 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 4 ++++
>  drivers/net/ethernet/intel/ice/ice_main.c     | 4 +++-
>  drivers/net/ethernet/intel/ice/ice_txrx.h     | 1 +
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 7 ++++++-
>  5 files changed, 15 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


