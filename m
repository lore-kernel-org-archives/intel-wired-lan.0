From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 4 Jan 2019 12:43:50 -0800
Subject: [Intel-wired-lan] [net v3] ixgbe: fix Kconfig when driver is
 not a module
In-Reply-To: <20190104184802.4730-1-jeffrey.t.kirsher@intel.com>
References: <20190104184802.4730-1-jeffrey.t.kirsher@intel.com>
Message-ID: <2bff487e-2dd8-c2a4-ba2a-8e8759980a24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/4/19 10:48 AM, Jeff Kirsher wrote:
> The new ability added to the driver to use mii_bus to handle MII related
> ioctls is causing compile issues when the driver is compiled into the
> kernel (i.e. not a module).
> 
> The problem was in selecting MDIO_DEVICE instead of the preferred PHYLIB
> Kconfig option.  The reason being that MDIO_DEVICE had a dependency on
> PHYLIB and would be compiled as a module when PHYLIB was a module, no
> matter whether ixgbe was compiled into the kernel.
> 
> CC: Dave Jones <davej@codemonkey.org.uk>
> CC: Steve Douthit <stephend@silicom-usa.com>
> CC: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Other drivers do make use of PHYLIB entirely, and are both a mii_bus
provider and using PHYLIB this driver is just a mii_bus provider,
anyway, probably the best fix for the buck :)

> ---
> v2: fixed up the Kconfig help section to include the clause 22/45
>   address information and also changed the IXGBE_MDIO config option to be
>   dependent upon PHYLIB versus MDIO_BUS since that appears to be the
>   common usage
> 
> v3: Steve Douthit found a much simpler solution of changing the
>   dependency from MDIO_DEVICE to PHYLIB, which is consistent with other
>   Ethernet drivers
> 
>  drivers/net/ethernet/intel/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
> index 31fb76ee9d82..a1246e89aad4 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -159,7 +159,7 @@ config IXGBE
>  	tristate "Intel(R) 10GbE PCI Express adapters support"
>  	depends on PCI
>  	select MDIO
> -	select MDIO_DEVICE
> +	select PHYLIB
>  	imply PTP_1588_CLOCK
>  	---help---
>  	  This driver supports Intel(R) 10GbE PCI Express family of
> 


-- 
Florian
