From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 May 2020 19:30:33 +0000
Subject: [Intel-wired-lan] [PATCH S43 04/15] ice: Check if unicast MAC
 exists before setting VF MAC
In-Reply-To: <20200516003644.4658-4-anthony.l.nguyen@intel.com>
References: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
 <20200516003644.4658-4-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB16596410BC27D504D79E8DF08CB40@DM5PR11MB1659.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S43 04/15] ice: Check if unicast MAC exists
> before setting VF MAC
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently if a unicast MAC is set via ndo_set_vf_mac, the PF driver will set
> the VF's dflt_lan_addr.addr once some basic checks have passed. The VF is
> then reset. During reset the PF driver will attempt to program the VF's MAC
> from the dflt_lan_addr.addr field. This fails when the MAC already exists on
> the PF's switch.
> 
> This is causing the VF to be completely disabled until removing/enabling any
> VFs via sysfs.
> 
> Fix this by checking if the unicast MAC exists before triggering a VF reset
> directly in ndo_set_vf_mac. Also, add a check if the unicast MAC is set to the
> same value as before and return 0 if that is the case.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


