From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 15 May 2020 19:40:39 +0000
Subject: [Intel-wired-lan] [PATCH S41 03/15] ice: Fix check for
 contiguous TCs
In-Reply-To: <20200508004113.39725-3-anthony.l.nguyen@intel.com>
References: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
 <20200508004113.39725-3-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB16593D432CC3CBC0EA7E07988CBD0@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, May 7, 2020 5:41 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S41 03/15] ice: Fix check for contiguous TCs
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> The current implementation for contiguous TC check is assuming that the UPs
> will be mapped to TCs in a linear progressing fashion.  This is obviously not
> always true.
> 
> Change the check to allow for various UP2TC mapping configurations.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


