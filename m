From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Jul 2020 17:47:06 +0000
Subject: [Intel-wired-lan] [PATCH S50 07/15] ice: Add RL profile bit
 mask check
In-Reply-To: <20200713205318.32425-7-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
 <20200713205318.32425-7-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB214524D2A62EA1E718DDB2A68C7F0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Monday, July 13, 2020 1:53 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S50 07/15] ice: Add RL profile bit mask
> check
> 
> From: Tarun Singh <tarun.k.singh@intel.com>
> 
> Mask bits before accessing the profile type field.
> 
> Signed-off-by: Tarun Singh <tarun.k.singh@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sched.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


