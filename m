From: Shannon Nelson <snelson@pensando.io>
Date: Wed, 4 Aug 2021 13:53:00 -0700
Subject: [Intel-wired-lan] [PATCH net-next v3] ethernet: fix
 PTP_1588_CLOCK dependencies
In-Reply-To: <20210804121318.337276-1-arnd@kernel.org>
References: <20210804121318.337276-1-arnd@kernel.org>
Message-ID: <61f766be-b384-29a5-3bf1-c8f3ac6c4a94@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/4/21 4:57 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The 'imply' keyword does not do what most people think it does, it only
> politely asks Kconfig to turn on another symbol, but does not prevent
> it from being disabled manually or built as a loadable module when the
> user is built-in. In the ICE driver, the latter now causes a link failure:
>
> aarch64-linux-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_eth_ioctl':
> ice_main.c:(.text+0x13b0): undefined reference to `ice_ptp_get_ts_config'
> ice_main.c:(.text+0x13b0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ice_ptp_get_ts_config'
> aarch64-linux-ld: ice_main.c:(.text+0x13bc): undefined reference to `ice_ptp_set_ts_config'
> ice_main.c:(.text+0x13bc): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ice_ptp_set_ts_config'
> aarch64-linux-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_prepare_for_reset':
> ice_main.c:(.text+0x31fc): undefined reference to `ice_ptp_release'
> ice_main.c:(.text+0x31fc): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ice_ptp_release'
> aarch64-linux-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_rebuild':
>
> This is a recurring problem in many drivers, and we have discussed
> it several times befores, without reaching a consensus. I'm providing
> a link to the previous email thread for reference, which discusses
> some related problems.
>
> To solve the dependency issue better than the 'imply' keyword, introduce a
> separate Kconfig symbol "CONFIG_PTP_1588_CLOCK_OPTIONAL" that any driver
> can depend on if it is able to use PTP support when available, but works
> fine without it. Whenever CONFIG_PTP_1588_CLOCK=m, those drivers are
> then prevented from being built-in, the same way as with a 'depends on
> PTP_1588_CLOCK || !PTP_1588_CLOCK' dependency that does the same trick,
> but that can be rather confusing when you first see it.
>
> Since this should cover the dependencies correctly, the IS_REACHABLE()
> hack in the header is no longer needed now, and can be turned back
> into a normal IS_ENABLED() check. Any driver that gets the dependency
> wrong will now cause a link time failure rather than being unable to use
> PTP support when that is in a loadable module.
>
> However, the two recently added ptp_get_vclocks_index() and
> ptp_convert_timestamp() interfaces are only called from builtin code with
> ethtool and socket timestamps, so keep the current behavior by stubbing
> those out completely when PTP is in a loadable module. This should be
> addressed properly in a follow-up.
>
> As Richard suggested, we may want to actually turn PTP support into a
> 'bool' option later on, preventing it from being a loadable module
> altogether, which would be one way to solve the problem with the ethtool
> interface.
>
> Fixes: 06c16d89d2cb ("ice: register 1588 PTP clock device object for E810 devices")
> Link: https://lore.kernel.org/netdev/CAK8P3a06enZOf=XyZ+zcAwBczv41UuCTz+=0FMf2gBz1_cOnZQ at mail.gmail.com/
> Link: https://lore.kernel.org/netdev/CAK8P3a3=eOxE-K25754+fB_-i_0BZzf9a9RfPTX3ppSwu9WZXw at mail.gmail.com/
> Link: https://lore.kernel.org/netdev/20210726084540.3282344-1-arnd at kernel.org/
> Cc: Richard Cochran <richardcochran@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Changes in v3:
> - rewrite to introduce a new PTP_1588_CLOCK_OPTIONAL symbol
> - use it for all driver, not just Intel's
> - change IS_REACHABLE() to IS_ENABLED() in the header
>
> Changes in v2:
> - include a missing patch hunk
> - link to a previous discussion with Richard Cochran
> ---
>   drivers/net/dsa/mv88e6xxx/Kconfig             |  1 +
>   drivers/net/dsa/ocelot/Kconfig                |  2 +
>   drivers/net/ethernet/amd/Kconfig              |  2 +-
>   drivers/net/ethernet/broadcom/Kconfig         |  6 +--
>   drivers/net/ethernet/cadence/Kconfig          |  1 +
>   drivers/net/ethernet/cavium/Kconfig           |  4 +-
>   drivers/net/ethernet/freescale/Kconfig        |  2 +-
>   drivers/net/ethernet/hisilicon/Kconfig        |  2 +-
>   drivers/net/ethernet/intel/Kconfig            | 14 +++---
>   drivers/net/ethernet/mellanox/mlx4/Kconfig    |  2 +-
>   .../net/ethernet/mellanox/mlx5/core/Kconfig   |  2 +-
>   drivers/net/ethernet/mellanox/mlxsw/Kconfig   |  2 +-
>   drivers/net/ethernet/mscc/Kconfig             |  2 +
>   drivers/net/ethernet/oki-semi/pch_gbe/Kconfig |  1 +
>   drivers/net/ethernet/pensando/Kconfig         |  2 +-

[...]

>   drivers/net/ethernet/qlogic/Kconfig           |  2 +-
> diff --git a/drivers/net/ethernet/pensando/Kconfig b/drivers/net/ethernet/pensando/Kconfig
> index 202973a82712..3f7519e435b8 100644
> --- a/drivers/net/ethernet/pensando/Kconfig
> +++ b/drivers/net/ethernet/pensando/Kconfig
> @@ -20,7 +20,7 @@ if NET_VENDOR_PENSANDO
>   config IONIC
>   	tristate "Pensando Ethernet IONIC Support"
>   	depends on 64BIT && PCI
> -	depends on PTP_1588_CLOCK || !PTP_1588_CLOCK
> +	depends on PTP_1588_CLOCK_OPTIONAL
>   	select NET_DEVLINK
>   	select DIMLIB
>   	help
>

Acked-by: Shannon Nelson <snelson@pensando.io>

