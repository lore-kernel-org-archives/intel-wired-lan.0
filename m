From: David Miller <davem@davemloft.net>
Date: Fri, 04 Jan 2019 13:39:43 -0800 (PST)
Subject: [Intel-wired-lan] [net v3] ixgbe: fix Kconfig when driver is
 not a module
In-Reply-To: <20190104184802.4730-1-jeffrey.t.kirsher@intel.com>
References: <20190104184802.4730-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20190104.133943.1670966834258094158.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri,  4 Jan 2019 10:48:02 -0800

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
> ---
> v2: fixed up the Kconfig help section to include the clause 22/45
>   address information and also changed the IXGBE_MDIO config option to be
>   dependent upon PHYLIB versus MDIO_BUS since that appears to be the
>   common usage
> 
> v3: Steve Douthit found a much simpler solution of changing the
>   dependency from MDIO_DEVICE to PHYLIB, which is consistent with other
>   Ethernet drivers

Jeff, would you like me to apply this directly?

Thanks.
