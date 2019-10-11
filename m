From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 11 Oct 2019 01:05:36 +0000
Subject: [Intel-wired-lan] [net-next v3 2/7] net: reject PTP periodic
 output requests with unsupported flags
In-Reply-To: <20190926181109.4871-3-jacob.e.keller@intel.com>
References: <20190926181109.4871-1-jacob.e.keller@intel.com>
 <20190926181109.4871-3-jacob.e.keller@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9714C866@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org]
> On Behalf Of Jacob Keller
> Sent: Thursday, September 26, 2019 11:11 AM
> To: netdev at vger.kernel.org
> Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> Richard Cochran <richardcochran@gmail.com>; Felipe Balbi
> <felipe.balbi@linux.intel.com>; David S . Miller <davem@davemloft.net>; Hall,
> Christopher S <christopher.s.hall@intel.com>
> Subject: [net-next v3 2/7] net: reject PTP periodic output requests with
> unsupported flags
> 
> Commit 823eb2a3c4c7 ("PTP: add support for one-shot output") introduced
> a new flag for the PTP periodic output request ioctl. This flag is not
> currently supported by any driver.
> 
> Fix all drivers which implement the periodic output request ioctl to
> explicitly reject any request with flags they do not understand. This
> ensures that the driver does not accidentally misinterpret the
> PTP_PEROUT_ONE_SHOT flag, or any new flag introduced in the future.
> 
> This is important for forward compatibility: if a new flag is
> introduced, the driver should reject requests to enable the flag until
> the driver has actually been modified to support the flag in question.
> 
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Christopher Hall <christopher.s.hall@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/broadcom/tg3.c                 | 4 ++++
>  drivers/net/ethernet/intel/igb/igb_ptp.c            | 4 ++++
>  drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 4 ++++
>  drivers/net/ethernet/microchip/lan743x_ptp.c        | 4 ++++
>  drivers/net/ethernet/renesas/ravb_ptp.c             | 4 ++++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c    | 4 ++++
>  drivers/net/phy/dp83640.c                           | 3 +++
>  7 files changed, 27 insertions(+)
> 

For the igb sections...
Tested-by: Aaron Brown <aaron.f.brown@intel.com>

