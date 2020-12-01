From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Tue, 1 Dec 2020 08:23:23 +0000
Subject: [Intel-wired-lan] [PATCH v4 2/6] igb: take vlan double header
 into account
In-Reply-To: <20201111170453.32693-3-sven.auhagen@voleatech.de>
References: <20201111170453.32693-1-sven.auhagen@voleatech.de>
 <20201111170453.32693-3-sven.auhagen@voleatech.de>
Message-ID: <DM6PR11MB454615FDFC4E7B71D9B82FA29CF40@DM6PR11MB4546.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: sven.auhagen at voleatech.de <sven.auhagen@voleatech.de>
> Sent: Wednesday, November 11, 2020 10:35 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; kuba at kernel.org
> Cc: davem at davemloft.net; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; nhorman at redhat.com; sassmann at redhat.com;
> Penigalapati, Sandeep <sandeep.penigalapati@intel.com>;
> brouer at redhat.com; pmenzel at molgen.mpg.de
> Subject: [PATCH v4 2/6] igb: take vlan double header into account
> 
> From: Sven Auhagen <sven.auhagen@voleatech.de>
> 
> Increase the packet header padding to include double VLAN tagging.
> This patch uses a macro for this.
> 
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
> ---
>  drivers/net/ethernet/intel/igb/igb.h      | 5 +++++
>  drivers/net/ethernet/intel/igb/igb_main.c | 7 +++----
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
