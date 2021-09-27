From: Randy Dunlap <rdunlap@infradead.org>
Date: Mon, 27 Sep 2021 10:25:36 -0700
Subject: [Intel-wired-lan] [PATCH] igc: fix PTP dependency
In-Reply-To: <20210927131730.1587671-1-arnd@kernel.org>
References: <20210927131730.1587671-1-arnd@kernel.org>
Message-ID: <97f24334-839f-ba32-c343-73f7aba5b912@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/27/21 6:17 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The igc driver was accidentally left out of the Kconfig rework for PTP,
> it needs the same dependency as the others:
> 
> arm-linux-gnueabi-ld: drivers/net/ethernet/intel/igc/igc_main.o: in function `igc_tsync_interrupt':
> igc_main.c:(.text+0x1b288): undefined reference to `ptp_clock_event'
> arm-linux-gnueabi-ld: igc_main.c:(.text+0x1b308): undefined reference to `ptp_clock_event'
> arm-linux-gnueabi-ld: igc_main.c:(.text+0x1b8cc): undefined reference to `ptp_clock_event'
> arm-linux-gnueabi-ld: drivers/net/ethernet/intel/igc/igc_ethtool.o: in function `igc_ethtool_get_ts_info':
> 
> Fixes: e5f31552674e ("ethernet: fix PTP_1588_CLOCK dependencies")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Same patch is already merged in linux-next (via net tree).
Thanks.

> ---
>   drivers/net/ethernet/intel/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
> index b0b6f90deb7d..ed8ea63bb172 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -335,6 +335,7 @@ config IGC
>   	tristate "Intel(R) Ethernet Controller I225-LM/I225-V support"
>   	default n
>   	depends on PCI
> +	depends on PTP_1588_CLOCK_OPTIONAL
>   	help
>   	  This driver supports Intel(R) Ethernet Controller I225-LM/I225-V
>   	  family of adapters.
> 


-- 
~Randy
