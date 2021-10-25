From: Mekala, SunithaX D <sunithax.d.mekala@intel.com>
Date: Mon, 25 Oct 2021 05:27:29 +0000
Subject: [Intel-wired-lan] [PATCH v2] ice: Add support to print error on
 PHY FW load failure
In-Reply-To: <20211013160219.322051-1-brett.creeley@intel.com>
References: <20211013160219.322051-1-brett.creeley@intel.com>
Message-ID: <CO1PR11MB5028D0BCD1AFBD9732ED3C34A0839@CO1PR11MB5028.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Brett Creeley
> Sent: Wednesday, October 13, 2021 9:02 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2] ice: Add support to print error on PHY FW load failure
>
> Some devices have support for loading the PHY FW and in some cases this can fail. When this fails, the FW will set the corresponding bit in the link info structure. Also, the FW will send a link event if the correct link event mask bit is set. Add support > for printing an error message when the PHY FW load fails during any link configuration flow and the link event flow.
>
> Since ice_check_module_power() is already doing something very similar add a new function ice_check_link_cfg_err() so any failures reported in the link info's link_cfg_err member can be printed in this one function.
>
> Also, add the new ICE_FLAG_PHY_FW_LOAD_FAILED bit to the PF's flags so we don't constantly print this error message during link polling if the value never changed.
>
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
> v2: Use correct bit for checking link_cfg_err
>
> drivers/net/ethernet/intel/ice/ice.h          |  1 +
> .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  2 +
>  drivers/net/ethernet/intel/ice/ice_main.c     | 49 +++++++++++++++++--
>  3 files changed, 47 insertions(+), 5 deletions(-)
>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
