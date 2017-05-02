From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 May 2017 18:34:15 +0000
Subject: [Intel-wired-lan] [PATCH v3 5/5] net-intel: check for Tx
 timestamp	timeouts during watchdog
In-Reply-To: <20170428184421.20216-6-jacob.e.keller@intel.com>
References: <20170428184421.20216-1-jacob.e.keller@intel.com>
 <20170428184421.20216-6-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA1F21@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 5/5] net-intel: check for Tx timestamp
> timeouts during watchdog
> 
> Several drivers share similar logic for handling the Tx timestamps.
> These drivers have some parts which rely on the interrupt instead of only a
> polling work task. Although unlikely it may be possible in some circumstances
> for the PTP tx timestamp to never occur. If this happens, the result is that all
> future Tx timestamp requests will be ignored permanently.
> 
> Fix this by adding a *ptp_tx_hang() function similar to the already existing
> *ptp_rx_hang() routine which checks to make sure that the timestamp
> hasn't taken too long. This ensures that we will eventually recover from this
> case.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |  2 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c    | 30
> +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  1 +
>  drivers/net/ethernet/intel/igb/igb.h          |  1 +
>  drivers/net/ethernet/intel/igb/igb_main.c     |  1 +
>  drivers/net/ethernet/intel/igb/igb_ptp.c      | 29
> ++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  1 +
> drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c  | 27
> ++++++++++++++++++++++++
>  10 files changed, 94 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


