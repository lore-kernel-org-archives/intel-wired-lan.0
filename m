From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 3 Jan 2019 23:57:37 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix Kconfig when driver is not
 a module
In-Reply-To: <20190103213519.9754-1-jeffrey.t.kirsher@intel.com>
References: <20190103213519.9754-1-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D34E9C7@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Thursday, January 3, 2019 1:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; Florian Fainelli <f.fainelli@gmail.com>; Dave
> Jones <davej@codemonkey.org.uk>
> Subject: [Intel-wired-lan] [PATCH] ixgbe: fix Kconfig when driver is not a
> module
> 
> The new ability added to the driver to use mii_bus to handle MII related
> ioctls is causing compile issues when the driver is compiled into the kernel
> (i.e. not a module).
> 
> The simple solution of requiring the driver to be compiled as a module when
> MDIO_BUS is a module, causes a recursion Kconfig issue due to IPSec
> dependencies.
> 
> So created another Kconfig option for ixgbe, to enable mdio_bus support for
> DSA devices.  This solution solves the problem when the ixgbe driver is
> compiled into the kernel and MDIO_BUS is compiled as a module.  In this
> case, the IXGBE_MDIO option is disabled and the code is not compiled into
> the driver.
> 
> CC: Dave Jones <davej@codemonkey.org.uk>
> CC: Steve Douthit <stephend@silicom-usa.com>
> CC: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  drivers/net/ethernet/intel/Kconfig            | 11 ++++++++++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  4 ++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 12 ++++++++++--
> drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |  4 ++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |  3 ++-
>  5 files changed, 30 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


