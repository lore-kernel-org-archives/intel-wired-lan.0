From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 03 Jan 2019 13:42:20 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix Kconfig when driver is not
 a module
In-Reply-To: <20190103213519.9754-1-jeffrey.t.kirsher@intel.com>
References: <20190103213519.9754-1-jeffrey.t.kirsher@intel.com>
Message-ID: <b3f82b0bfb338ab011049795d6c704a29e97bcf5.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2019-01-03 at 13:35 -0800, Jeff Kirsher wrote:
> The new ability added to the driver to use mii_bus to handle MII
> related
> ioctls is causing compile issues when the driver is compiled into the
> kernel (i.e. not a module).
> 
> The simple solution of requiring the driver to be compiled as a
> module when
> MDIO_BUS is a module, causes a recursion Kconfig issue due to IPSec
> dependencies.
> 
> So created another Kconfig option for ixgbe, to enable mdio_bus
> support for
> DSA devices.  This solution solves the problem when the ixgbe driver
> is
> compiled into the kernel and MDIO_BUS is compiled as a module.  In
> this
> case, the IXGBE_MDIO option is disabled and the code is not compiled
> into the driver.
> 
> CC: Dave Jones <davej@codemonkey.org.uk>
> CC: Steve Douthit <stephend@silicom-usa.com>
> CC: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  drivers/net/ethernet/intel/Kconfig            | 11 ++++++++++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  4 ++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 12 ++++++++++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |  4 ++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |  3 ++-
>  5 files changed, 30 insertions(+), 4 deletions(-)

I have done the following compile tests to comfirm this resolves the
issue:

Kconfig:     1   2   3   4
--------    --- --- --- ---
ixgbe        m   m   y   y
 ixgbe_mdio  y   n   y   y
mdio_bus     m   m   m   y
phylib       m   m   m   y

Test #3 resulted in ixgbe_mdio being disabled and code not compiled
into the driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190103/0bb52144/attachment.asc>
