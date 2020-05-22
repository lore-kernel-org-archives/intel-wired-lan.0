From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 May 2020 19:58:37 +0000
Subject: [Intel-wired-lan] [PATCH S43 08/15] ice: cleanup unsigned loops
In-Reply-To: <20200516003644.4658-8-anthony.l.nguyen@intel.com>
References: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
 <20200516003644.4658-8-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB165948D9C8CD9AE5EEAF897F8CB40@DM5PR11MB1659.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S43 08/15] ice: cleanup unsigned loops
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Fix loop variables that are comparing or assigning signed against unsigned
> values, mostly by declaring loop counters as unsigned.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_nl.c      |  9 +++++----
>  drivers/net/ethernet/intel/ice/ice_ethtool.c     | 10 +++++-----
>  drivers/net/ethernet/intel/ice/ice_main.c        |  4 ++--
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  4 ++--
>  4 files changed, 14 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


