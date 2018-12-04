From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 4 Dec 2018 16:59:21 +0000
Subject: [Intel-wired-lan] [PATCH net-next v4 2/2] ixgbe: use mii_bus to
 handle MII related ioctls
In-Reply-To: <20181203201432.18252-3-stephend@silicom-usa.com>
References: <20181203163227.5107-1-stephend@silicom-usa.com>
 <20181203201432.18252-1-stephend@silicom-usa.com>
 <20181203201432.18252-3-stephend@silicom-usa.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D32C616@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v4 2/2] ixgbe: use mii_bus to
> handle MII related ioctls
> 
> Use the mii_bus callbacks to address the entire clause 22/45 address space.
> Enables userspace to poke switch registers instead of a single PHY address.
> 
> The ixgbe firmware may be polling PHYs in a way that is not protected by the
> mii_bus lock.  This isn't new behavior, but as Andrew Lunn pointed out there
> are more addresses available for conflicts.
> 
> Signed-off-by: Stephen Douthit <stephend@silicom-usa.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


