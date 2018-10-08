From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 8 Oct 2018 18:35:23 +0000
Subject: [Intel-wired-lan] [net-next 2/2] intel-ethernet: software
 timestamp skbs as late as possible
In-Reply-To: <20181005163356.23996-2-jacob.e.keller@intel.com>
References: <20181005163356.23996-1-jacob.e.keller@intel.com>
 <20181005163356.23996-2-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FD5D6@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Friday, October 5, 2018 9:34 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [net-next 2/2] intel-ethernet: software timestamp
> skbs as late as possible
> 
> Many of the Intel Ethernet drivers call skb_tx_timestamp() earlier than
> necessary. Move the calls to this function to the latest point possible, just
> prior to notifying hardware of the new Tx packet when we bump the tail
> register.
> 
> This affects i40e, iavf, igb, igc, and ixgbe.
> 
> The e100, e1000, e1000e, fm10k, and ice drivers already call the
> skb_tx_timestamp() function just prior to indicating the Tx packet to
> hardware, so they do not need to be changed.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 4 ++--
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 4 ++--
>  drivers/net/ethernet/intel/igb/igb_main.c     | 4 ++--
>  drivers/net/ethernet/intel/igc/igc_main.c     | 4 ++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


