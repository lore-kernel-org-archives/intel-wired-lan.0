From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 May 2020 21:41:52 +0000
Subject: [Intel-wired-lan] [PATCH S45 08/15] ice: remove VM/VF disable
 command on CORER/GLOBR reset
In-Reply-To: <20200516005121.4963-8-anthony.l.nguyen@intel.com>
References: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
 <20200516005121.4963-8-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659BD2D73E16656283AE91C8C8E0@DM5PR11MB1659.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S45 08/15] ice: remove VM/VF disable
> command on CORER/GLOBR reset
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Remove VM/VF disable AQC (opcode 0x0C31) when resetting all VFs.
> This is not required for CORER/GLOBR reset.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 11 -----------
>  1 file changed, 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


