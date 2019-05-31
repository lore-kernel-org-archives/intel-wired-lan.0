From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 May 2019 17:58:44 +0000
Subject: [Intel-wired-lan] [next PATCH S6 2/7] i40e: Fix for missing
 "link modes" info in ethtool
In-Reply-To: <20190528175921.30534-2-alice.michael@intel.com>
References: <20190528175921.30534-1-alice.michael@intel.com>
 <20190528175921.30534-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3DD59F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, May 28, 2019 10:59 AM
> To: alice.micheal at intel.com; intel-wired-lan at lists.osuosl.org
> Cc: Szapar, Martyna <martyna.szapar@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S6 2/7] i40e: Fix for missing "link
> modes" info in ethtool
> 
> From: Martyna Szapar <martyna.szapar@intel.com>
> 
> Fix for missing "Supported link modes" and "Advertised link modes"
> info in ethtool after changed speed on X722 devices with BASE-T PHY with
> FW API version >= 1.7.
> The same FW API version on X710 and X722 does not mean the same feature
> set so the change was needed as mac type of the device should also be
> checked instead of FW API version only.
> 
> Signed-off-by: Martyna Szapar <martyna.szapar@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


