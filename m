From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 May 2017 16:44:33 +0000
Subject: [Intel-wired-lan] [PATCH v3 3/5] net-intel: add
	statistic	indicating number of skipped Tx timestamps
In-Reply-To: <20170428184421.20216-4-jacob.e.keller@intel.com>
References: <20170428184421.20216-1-jacob.e.keller@intel.com>
 <20170428184421.20216-4-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA1ED3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Friday, April 28, 2017 11:44 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Subject: [Intel-wired-lan] [PATCH v3 3/5] net-intel: add statistic indicating
> number of skipped Tx timestamps
> 
> The e1000e, igb, i40e, and ixgbe drivers share similar code for handling Tx
> timestamps, with a similar limitation of only one Tx timestamp register set.
> Because the hardware only supports one Tx timestamp at a time, the drivers
> may silently ignore timestamp requests for packets while waiting for a
> previous packet timestamp to complete. Add a new statistic,
> tx_hwtstamp_skipped, which indicates how many times this has happened.
> This is useful when trying to determine why a specific application is not
> receiving timestamps. Without this statistic, the developer may not have any
> indication that the timestamp was intentionally skipped.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/e1000.h        |  1 +
>  drivers/net/ethernet/intel/e1000e/ethtool.c      |  1 +
>  drivers/net/ethernet/intel/e1000e/netdev.c       | 17 ++++++++++-------
>  drivers/net/ethernet/intel/i40e/i40e.h           |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c   |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c      |  1 +
>  drivers/net/ethernet/intel/igb/igb.h             |  1 +
>  drivers/net/ethernet/intel/igb/igb_ethtool.c     |  1 +
>  drivers/net/ethernet/intel/igb/igb_main.c        |  2 ++
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  3 +++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 21 ++++++++++++--------
> -
>  12 files changed, 35 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


