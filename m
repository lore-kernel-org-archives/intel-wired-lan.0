From: Bhandare, KiranX <kiranx.bhandare@intel.com>
Date: Fri, 17 Dec 2021 15:24:03 +0000
Subject: [Intel-wired-lan] [PATCH v2 intel-net 2/6] ice: xsk: allocate
 separate memory for XDP SW ring
In-Reply-To: <20211213153111.110877-3-maciej.fijalkowski@intel.com>
References: <20211213153111.110877-1-maciej.fijalkowski@intel.com>
 <20211213153111.110877-3-maciej.fijalkowski@intel.com>
Message-ID: <DM6PR11MB3292041274105D441B44A7F8F1789@DM6PR11MB3292.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH v2 intel-net 2/6] ice: xsk: allocate separate
> memory for XDP SW ring
> 
> Currently, the zero-copy data path is reusing the memory region that was
> initially allocated for an array of struct ice_rx_buf for its own purposes. This
> is error prone as it is based on the ice_rx_buf struct always being the same
> size or bigger than what the zero-copy path needs.
> There can also be old values present in that array giving rise to errors when
> the zero-copy path uses it.
> 
> Fix this by freeing the ice_rx_buf region and allocating a new array for the
> zero-copy path that has the right length and is initialized to zero.
> 
> Fixes: 57f7f8b6bc0b ("ice: Use xdp_buf instead of rx_buf for xsk zero-copy")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 17 ++++++++++++
> drivers/net/ethernet/intel/ice/ice_txrx.c | 19 ++++++++-----
> drivers/net/ethernet/intel/ice/ice_xsk.c  | 33 ++++++++++++-----------
>  3 files changed, 47 insertions(+), 22 deletions(-)
> 

Tested-by: Kiran Bhandare <kiranx.bhandare@intel.com>  A Contingent Worker at Intel
