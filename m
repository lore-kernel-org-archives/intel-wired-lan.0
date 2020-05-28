From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 May 2020 21:43:55 +0000
Subject: [Intel-wired-lan] [PATCH S45 12/15] ice: support adding 16
 unicast/multicast filter on untrusted VF
In-Reply-To: <20200516005121.4963-12-anthony.l.nguyen@intel.com>
References: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
 <20200516005121.4963-12-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB16596D7F3DEECCE5B3C919008C8E0@DM5PR11MB1659.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S45 12/15] ice: support adding 16
> unicast/multicast filter on untrusted VF
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Allow untrusted VF to add 16 unicast/multicast filters. VF uses 1 filter for the
> default/perm_addr/LAA MAC, 1 for broadcast, and 16 additional
> unicast/multicast filters.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


