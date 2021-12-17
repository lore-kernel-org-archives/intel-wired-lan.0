From: Bhandare, KiranX <kiranx.bhandare@intel.com>
Date: Fri, 17 Dec 2021 15:24:07 +0000
Subject: [Intel-wired-lan] [PATCH v2 intel-net 1/6] ice: xsk: return xsk
 buffers back to pool when cleaning the ring
In-Reply-To: <20211213153111.110877-2-maciej.fijalkowski@intel.com>
References: <20211213153111.110877-1-maciej.fijalkowski@intel.com>
 <20211213153111.110877-2-maciej.fijalkowski@intel.com>
Message-ID: <DM6PR11MB32922CEAA0F5B5C7476D3FA9F1789@DM6PR11MB3292.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH v2 intel-net 1/6] ice: xsk: return xsk buffers
> back to pool when cleaning the ring
> 
> Currently we only NULL the xdp_buff pointer in the internal SW ring but we
> never give it back to the xsk buffer pool. This means that buffers can be
> leaked out of the buff pool and never be used again.
> 
> Add missing xsk_buff_free() call to the routine that is supposed to clean the
> entries that are left in the ring so that these buffers in the umem can be used
> by other sockets.
> 
> Also, only go through the space that is actually left to be cleaned instead of a
> whole ring.
> 
> Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_xsk.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Tested-by: Kiran Bhandare <kiranx.bhandare@intel.com>  A Contingent Worker at Intel
