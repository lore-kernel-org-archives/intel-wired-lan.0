From: Bhandare, KiranX <kiranx.bhandare@intel.com>
Date: Fri, 17 Dec 2021 15:24:00 +0000
Subject: [Intel-wired-lan] [PATCH v2 intel-net 3/6] ice: remove dead
 store on XSK hotpath
In-Reply-To: <20211213153111.110877-4-maciej.fijalkowski@intel.com>
References: <20211213153111.110877-1-maciej.fijalkowski@intel.com>
 <20211213153111.110877-4-maciej.fijalkowski@intel.com>
Message-ID: <DM6PR11MB329225DA5F67CEDB3B587AC4F1789@DM6PR11MB3292.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Maciej Fijalkowski
> Sent: Monday, December 13, 2021 9:01 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Mathew, Elza <elza.mathew@intel.com>; netdev at vger.kernel.org;
> kuba at kernel.org; bpf at vger.kernel.org; davem at davemloft.net; Karlsson,
> Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2 intel-net 3/6] ice: remove dead store on
> XSK hotpath
> 
> From: Alexander Lobakin <alexandr.lobakin@intel.com>
> 
> The 'if (ntu == rx_ring->count)' block in ice_alloc_rx_buffers_zc() was
> previously residing in the loop, but after introducing the batched interface it
> is used only to wrap-around the NTU descriptor, thus no more need to assign
> 'xdp'.
> 
> Fixes: db804cfc21e9 ("ice: Use the xsk batched rx allocation interface")
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_xsk.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Tested-by: Kiran Bhandare <kiranx.bhandare@intel.com>  A Contingent Worker at Intel
