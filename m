From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 4 Dec 2018 16:58:46 +0000
Subject: [Intel-wired-lan] [PATCH net-next v4 1/2] ixgbe: register a
 mdiobus
In-Reply-To: <20181203201432.18252-2-stephend@silicom-usa.com>
References: <20181203163227.5107-1-stephend@silicom-usa.com>
 <20181203201432.18252-1-stephend@silicom-usa.com>
 <20181203201432.18252-2-stephend@silicom-usa.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D32C606@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Steve Douthit
> Sent: Monday, December 3, 2018 12:15 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: Andrew Lunn <andrew@lunn.ch>; Florian Fainelli <f.fainelli@gmail.com>;
> netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; David S. Miller
> <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH net-next v4 1/2] ixgbe: register a mdiobus
> 
> Most dsa devices expect a 'struct mii_bus' pointer to talk to switches via the
> MII interface.
> 
> While this works for dsa devices, it will not work safely with Linux PHYs in all
> configurations since the firmware of the ixgbe device may be polling some
> PHY addresses in the background.
> 
> Signed-off-by: Stephen Douthit <stephend@silicom-usa.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/net/ethernet/intel/Kconfig            |   1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   2 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   5 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 299 ++++++++++++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |   2 +
>  5 files changed, 309 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


