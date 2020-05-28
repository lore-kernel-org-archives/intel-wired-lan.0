From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 May 2020 21:39:53 +0000
Subject: [Intel-wired-lan] [PATCH S45 03/15] ice: Add helper function
 for clearing VPGEN_VFRTRIG
In-Reply-To: <20200516005121.4963-3-anthony.l.nguyen@intel.com>
References: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
 <20200516005121.4963-3-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB165916FEA23A67C54FBD481E8C8E0@DM5PR11MB1659.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S45 03/15] ice: Add helper function for
> clearing VPGEN_VFRTRIG
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Create a helper function for clearing VPGEN_VFRTRIG as this needs to be
> done on reset to notify the VF that we are done resetting it. Also, it needs to
> be done on SR-IOV initialization/creation in case it was left in a bad state after
> SR-IOV teardown.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 31 ++++++++++++-------
>  1 file changed, 20 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


