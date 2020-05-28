From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 May 2020 21:40:39 +0000
Subject: [Intel-wired-lan] [PATCH S45 05/15] ice: Renaming and
 simplification in VF init path
In-Reply-To: <20200516005121.4963-5-anthony.l.nguyen@intel.com>
References: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
 <20200516005121.4963-5-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659A27DD412C42C49B8E5BA8C8E0@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S45 05/15] ice: Renaming and simplification
> in VF init path
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Some function names weren't very clear and some portions of VF creation
> could be moved into functions for clarity. Fix this by renaming some functions
> and move pieces of code into clearly name functions.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 83 ++++++++++++-------
>  1 file changed, 54 insertions(+), 29 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


