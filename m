From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 8 Oct 2018 18:34:27 +0000
Subject: [Intel-wired-lan] [net-next 1/2] ixgbevf: add support for
 software timestamps
In-Reply-To: <20181005163356.23996-1-jacob.e.keller@intel.com>
References: <20181005163356.23996-1-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FD5C6@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [net-next 1/2] ixgbevf: add support for software
> timestamps
> 
> Add a call to skb_tx_timestamp in the ixgbevf_tx_map function. This enables
> software timestamping for packets sent over this device driver.
> The call is placed just prior to when we notify hardware of the new packet, in
> order to software timestamp as close as possible to when the hardware will
> transmit.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


