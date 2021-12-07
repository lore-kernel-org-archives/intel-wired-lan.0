From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Tue, 7 Dec 2021 11:19:16 +0000
Subject: [Intel-wired-lan] [PATCH net v3] ice: safer stats processing
In-Reply-To: <20211113010602.795866-1-jesse.brandeburg@intel.com>
References: <20211113010602.795866-1-jesse.brandeburg@intel.com>
Message-ID: <SN6PR11MB33743254E447455AA2E9331FFC6E9@SN6PR11MB3374.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jesse
> Brandeburg
> Sent: Saturday, November 13, 2021 6:36 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net v3] ice: safer stats processing
> 
> The driver was zeroing live stats that could be fetched by
> ndo_get_stats64 at any time. This could result in inconsistent statistics, and the
> telltale sign was when reading stats frequently from /proc/net/dev, the stats
> would go backwards.
> 
> Fix by collecting stats into a local, and delaying when we write to the structure
> so it's not incremental.
> 
> Fixes: fcea6f3da546 ("ice: Add stats and ethtool support")
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> v3: change to use GFP_ATOMIC to prevent BUG due to sleeping alloc
> v2: changed to use kzalloc instead of stack variable
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 31 +++++++++++++++--------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
