From: Richard Cochran <richardcochran@gmail.com>
Date: Wed, 4 Aug 2021 07:28:14 -0700
Subject: [Intel-wired-lan] [PATCH net-next v3] ethernet: fix
 PTP_1588_CLOCK dependencies
In-Reply-To: <20210804121318.337276-1-arnd@kernel.org>
References: <20210804121318.337276-1-arnd@kernel.org>
Message-ID: <20210804142814.GB1645@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Aug 04, 2021 at 01:57:04PM +0200, Arnd Bergmann wrote:

> Since this should cover the dependencies correctly, the IS_REACHABLE()
> hack in the header is no longer needed now, and can be turned back
> into a normal IS_ENABLED() check. Any driver that gets the dependency
> wrong will now cause a link time failure rather than being unable to use
> PTP support when that is in a loadable module.

yes!

> Changes in v3:
> - rewrite to introduce a new PTP_1588_CLOCK_OPTIONAL symbol
> - use it for all driver, not just Intel's

Thanks for following up.

> diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
> index 82744a7501c7..9c1d0b715748 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -58,8 +58,8 @@ config E1000
>  config E1000E
>  	tristate "Intel(R) PRO/1000 PCI-Express Gigabit Ethernet support"
>  	depends on PCI && (!SPARC32 || BROKEN)
> +	depends on PTP_1588_CLOCK_OPTIONAL
>  	select CRC32
> -	imply PTP_1588_CLOCK
>  	help
>  	  This driver supports the PCI-Express Intel(R) PRO/1000 gigabit
>  	  ethernet family of adapters. For PCI or PCI-X e1000 adapters,
> @@ -87,8 +87,8 @@ config E1000E_HWTS
>  config IGB
>  	tristate "Intel(R) 82575/82576 PCI-Express Gigabit Ethernet support"
>  	depends on PCI
> -	imply PTP_1588_CLOCK
> -	select I2C
> +	depends on PTP_1588_CLOCK_OPTIONAL
> +	depends on I2C

This little i2c bit sneaks in, but I guess you considered any possible
trouble with it?

Acked-by: Richard Cochran <richardcochran@gmail.com>
