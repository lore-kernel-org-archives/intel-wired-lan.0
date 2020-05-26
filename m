From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 26 May 2020 20:22:15 +0000
Subject: [Intel-wired-lan] [PATCH S44 01/14] ice: Don't allow VLAN
 stripping change when pvid set
In-Reply-To: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
References: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB16596D2504DCC206CA641E318CB00@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:42 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S44 01/14] ice: Don't allow VLAN stripping
> change when pvid set
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently, if the PVID is set in the VLAN handling section of the VSI context
> the driver still allows VLAN stripping to be enabled/disabled.
> VLAN stripping should only be modifiable when the PVID is not set. Fix this by
> preventing VLAN stripping modification when PVID is set.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


