From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 21 Mar 2019 22:32:47 +0000
Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix mdio bus registration
In-Reply-To: <20190315084515.22983-1-ivecera@redhat.com>
References: <20190315084515.22983-1-ivecera@redhat.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D376AA9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Ivan Vecera
> Sent: Friday, March 15, 2019 1:45 AM
> To: netdev at vger.kernel.org
> Cc: open list <linux-kernel@vger.kernel.org>; moderated list:INTEL
> ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>; David S. Miller
> <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix mdio bus registration
> 
> The ixgbe ignores errors returned from mdiobus_register() and leaves
> adapter->mii_bus non-NULL and MDIO bus state as MDIOBUS_ALLOCATED.
> This triggers a BUG from mdiobus_unregister() during ixgbe_remove() call.
> 
> Fixes: 8fa10ef01260 ("ixgbe: register a mdiobus")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


