From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 27 Sep 2021 22:35:34 +0000
Subject: [Intel-wired-lan] [PATCH] igc: fix PTP dependency
In-Reply-To: <20210927131730.1587671-1-arnd@kernel.org>
References: <20210927131730.1587671-1-arnd@kernel.org>
Message-ID: <CO1PR11MB5089ACD68BA016202174D9A2D6A79@CO1PR11MB5089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Monday, September 27, 2021 6:17 AM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>; Jakub
> Kicinski <kuba@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Saleem, Shiraz <shiraz.saleem@intel.com>; Kurt
> Kanzenbach <kurt@linutronix.de>; Ertman, David M
> <david.m.ertman@intel.com>; Shannon Nelson <snelson@pensando.io>;
> Richard Cochran <richardcochran@gmail.com>; Vladimir Oltean
> <vladimir.oltean@nxp.com>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [PATCH] igc: fix PTP dependency
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The igc driver was accidentally left out of the Kconfig rework for PTP,
> it needs the same dependency as the others:
> 
> arm-linux-gnueabi-ld: drivers/net/ethernet/intel/igc/igc_main.o: in function
> `igc_tsync_interrupt':
> igc_main.c:(.text+0x1b288): undefined reference to `ptp_clock_event'
> arm-linux-gnueabi-ld: igc_main.c:(.text+0x1b308): undefined reference to
> `ptp_clock_event'
> arm-linux-gnueabi-ld: igc_main.c:(.text+0x1b8cc): undefined reference to
> `ptp_clock_event'
> arm-linux-gnueabi-ld: drivers/net/ethernet/intel/igc/igc_ethtool.o: in function
> `igc_ethtool_get_ts_info':
> 
> Fixes: e5f31552674e ("ethernet: fix PTP_1588_CLOCK dependencies")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

-Jake

> ---
>  drivers/net/ethernet/intel/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/Kconfig
> b/drivers/net/ethernet/intel/Kconfig
> index b0b6f90deb7d..ed8ea63bb172 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -335,6 +335,7 @@ config IGC
>  	tristate "Intel(R) Ethernet Controller I225-LM/I225-V support"
>  	default n
>  	depends on PCI
> +	depends on PTP_1588_CLOCK_OPTIONAL
>  	help
>  	  This driver supports Intel(R) Ethernet Controller I225-LM/I225-V
>  	  family of adapters.
> --
> 2.29.2

