From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 Jul 2020 19:58:19 +0000
Subject: [Intel-wired-lan] [PATCH S51 06/13] ice: Clear and free XLT
 entries on reset
In-Reply-To: <20200730001922.52568-6-anthony.l.nguyen@intel.com>
References: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
 <20200730001922.52568-6-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB2145B913EE49E66C7ACB0EDC8C4E0@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S51 06/13] ice: Clear and free XLT entries
> on reset
> 
> From: Vignesh Sridhar <vignesh.sridhar@intel.com>
> 
> This fix has been added to address memory leak issues resulting from
> triggering a sudden driver reset which does not allow us to follow our normal
> removal flows for SW XLT entries for advanced features.
> 
> - Adding call to destroy flow profile locks when clearing SW XLT tables.
> 
> - Extraction sequence entries were not correctly cleared previously which
> could cause ownership conflicts for repeated reset-replay calls.
> 
> Fixes: 31ad4e4ee1e4 ("ice: Allocate flow profile")
> Signed-off-by: Vignesh Sridhar <vignesh.sridhar@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


