From: Bhandare, KiranX <kiranx.bhandare@intel.com>
Date: Fri, 17 Dec 2021 15:23:52 +0000
Subject: [Intel-wired-lan] [PATCH v2 intel-net 5/6] ice: xsk: allow
 empty Rx descriptors on XSK ZC data path
In-Reply-To: <20211213153111.110877-6-maciej.fijalkowski@intel.com>
References: <20211213153111.110877-1-maciej.fijalkowski@intel.com>
 <20211213153111.110877-6-maciej.fijalkowski@intel.com>
Message-ID: <DM6PR11MB32928282AF0C5E3C90621516F1789@DM6PR11MB3292.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH v2 intel-net 5/6] ice: xsk: allow empty Rx
> descriptors on XSK ZC data path
> 
> Commit ac6f733a7bd5 ("ice: allow empty Rx descriptors") stated that ice HW
> can produce empty descriptors that are valid and they should be processed.
> 
> Add this support to xsk ZC path to avoid potential processing problems.
> 
> Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_xsk.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 

Tested-by: Kiran Bhandare <kiranx.bhandare@intel.com>  A Contingent Worker at Intel
