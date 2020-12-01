From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Tue, 1 Dec 2020 07:30:33 +0000
Subject: [Intel-wired-lan] [PATCH v4 5/6] igb: use xdp_do_flush
In-Reply-To: <20201111170453.32693-6-sven.auhagen@voleatech.de>
References: <20201111170453.32693-1-sven.auhagen@voleatech.de>
 <20201111170453.32693-6-sven.auhagen@voleatech.de>
Message-ID: <MW3PR11MB45544D6F549DAD89700D1CFA9CF40@MW3PR11MB4554.namprd11.prod.outlook.com>
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
> Subject: [PATCH v4 5/6] igb: use xdp_do_flush
> 
> From: Sven Auhagen <sven.auhagen@voleatech.de>
> 
> Since it is a new XDP implementation change xdp_do_flush_map to
> xdp_do_flush.
> 
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
