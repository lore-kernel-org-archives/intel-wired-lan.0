From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 3 May 2017 16:43:20 +0000
Subject: [Intel-wired-lan] [PATCH v3 0/5] ptp cornercase cleanups
In-Reply-To: <20170428184421.20216-1-jacob.e.keller@intel.com>
References: <20170428184421.20216-1-jacob.e.keller@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857E1D0D9@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Keller, Jacob E
> Sent: Friday, April 28, 2017 11:44 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: Richard Cochran <richardcochran@gmail.com>; David Mirabito
> <davidm@metamako.com>; Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [PATCH v3 0/5] ptp cornercase cleanups
> 
> This version fixes two minor issues I realized after I was porting them
> back to out-of-tree drivers. Sorry for the thrash.
> 
> Jacob Keller (5):
>   net-intel: fix race condition with PTP_TX_IN_PROGRESS bits
>   net-intel: avoid permanent lock of *_PTP_TX_IN_PROGRESS
>   net-intel: add statistic indicating number of skipped Tx timestamps
>   i40e: use pf data structure directly in i40e_ptp_rx_hang
>   net-intel: check for Tx timestamp timeouts during watchdog
> 
>  drivers/net/ethernet/intel/e1000e/e1000.h        |  1 +
>  drivers/net/ethernet/intel/e1000e/ethtool.c      |  1 +
>  drivers/net/ethernet/intel/e1000e/netdev.c       | 27 ++++++++-----
>  drivers/net/ethernet/intel/i40e/i40e.h           |  5 ++-
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c   |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c      |  3 +-
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c       | 48 +++++++++++++++++++++--
> -
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c      | 28 +++++++++++---
>  drivers/net/ethernet/intel/igb/igb.h             |  2 +
>  drivers/net/ethernet/intel/igb/igb_ethtool.c     |  1 +
>  drivers/net/ethernet/intel/igb/igb_main.c        | 26 ++++++++++---
>  drivers/net/ethernet/intel/igb/igb_ptp.c         | 41 +++++++++++++++++++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  2 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  3 ++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 42 ++++++++++++++-------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c     | 42 +++++++++++++++++++--
>  16 files changed, 227 insertions(+), 46 deletions(-)
> 
> --
> 2.13.0.rc0.317.gcc792a6cad5a

Jeff, can you please drop this series? I'm about to send out an (identical content) v2 which splits the patches apart to each driver, and necessarily requires new subject names.

Thanks,
Jake
