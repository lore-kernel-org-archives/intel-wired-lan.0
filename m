From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 May 2020 19:58:17 +0000
Subject: [Intel-wired-lan] [PATCH S43 07/15] ice: fix usage of incorrect
 variable
In-Reply-To: <20200516003644.4658-7-anthony.l.nguyen@intel.com>
References: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
 <20200516003644.4658-7-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB165944489DEC8280569E2DE78CB40@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:37 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S43 07/15] ice: fix usage of incorrect
> variable
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The driver was using rq_last_status where it should have been using
> sq_last_status. Fix the string to be using the correct error reporting variable.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c    | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


