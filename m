From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 May 2020 23:17:51 +0000
Subject: [Intel-wired-lan] [PATCH S46 1/9] ice: Reset VF for all port
 VLAN changes from host
In-Reply-To: <20200516005506.5113-1-anthony.l.nguyen@intel.com>
References: <20200516005506.5113-1-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659F36083364FC8EF2964DE8C8E0@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S46 1/9] ice: Reset VF for all port VLAN
> changes from host
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently the PF is modifying the VF's port VLAN on the fly when configured
> via iproute. This is okay for most cases, but if the VF already has guest VLANs
> configured the PF has to remove all of those filters so only VLAN tagged
> traffic that matches the port VLAN will pass. Instead of adding functionality to
> track which guest VLANs have been added, just reset the VF each time port
> VLAN parameters are modified.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 42 +++----------------
>  1 file changed, 5 insertions(+), 37 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


