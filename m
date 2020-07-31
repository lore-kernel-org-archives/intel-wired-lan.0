From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 Jul 2020 19:58:01 +0000
Subject: [Intel-wired-lan] [PATCH S51 09/13] ice: Graceful error
 handling in HW table calloc failure
In-Reply-To: <20200730001922.52568-9-anthony.l.nguyen@intel.com>
References: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
 <20200730001922.52568-9-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB2145BA3A9BC357CAA70C85948C4E0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, July 29, 2020 5:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S51 09/13] ice: Graceful error handling in
> HW table calloc failure
> 
> From: Surabhi Boob <surabhi.boob@intel.com>
> 
> In the ice_init_hw_tbls, if the devm_kcalloc for es->written fails, catch that
> error and bail out gracefully, instead of continuing with a NULL pointer.
> 
> Fixes: 32d63fa1e9f3 ("ice: Initialize DDP package structures")
> Signed-off-by: Surabhi Boob <surabhi.boob@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


