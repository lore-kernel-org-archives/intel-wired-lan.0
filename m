From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 24 Dec 2021 18:37:14 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 11/14] ice: Support
 configuring the device to Double VLAN Mode
In-Reply-To: <20211202163852.36436-11-anthony.l.nguyen@intel.com>
References: <20211202163852.36436-1-anthony.l.nguyen@intel.com>
 <20211202163852.36436-11-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB336753274C578EA058F85F87FC7F9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Tony
> Nguyen
> Sent: Thursday, December 2, 2021 10:09 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v3 11/14] ice: Support configuring
> the device to Double VLAN Mode
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> In order to support configuring the device in Double VLAN Mode (DVM),
> the DDP and FW have to support DVM. If both support DVM, the PF that
> downloads the package needs to update the default recipes, set the
> VLAN mode, and update boost TCAM entries.
> 
> To support updating the default recipes in DVM, add support for
> updating an existing switch recipe's lkup_idx and mask. This is done
> by first calling the get recipe AQ (0x0292) with the desired recipe
> ID. Then, if that is successful update one of the lookup indices
> (lkup_idx) and its associated mask if the mask is valid otherwise
> the already existing mask will be used.
> 
> The VLAN mode of the device has to be configured while the global
> configuration lock is held while downloading the DDP, specifically after
> the DDP has been downloaded. If supported, the device will default to
> DVM.
> 
> Co-developed-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v3: Add ICE_DBQ_AQ define
> 
>  drivers/net/ethernet/intel/ice/Makefile       |   1 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  64 ++-
>  drivers/net/ethernet/intel/ice/ice_common.c   |  49 +-
>  drivers/net/ethernet/intel/ice/ice_common.h   |   3 +
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    | 290 ++++++++++--
>  .../net/ethernet/intel/ice/ice_flex_pipe.h    |  13 +
>  .../net/ethernet/intel/ice/ice_flex_type.h    |  40 ++
>  drivers/net/ethernet/intel/ice/ice_main.c     |  12 +
>  .../ethernet/intel/ice/ice_pf_vsi_vlan_ops.c  |   1 +
>  drivers/net/ethernet/intel/ice/ice_switch.c   |  75 +++
>  drivers/net/ethernet/intel/ice/ice_switch.h   |  13 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |  10 +
>  .../ethernet/intel/ice/ice_vf_vsi_vlan_ops.c  |   1 +
>  .../net/ethernet/intel/ice/ice_vlan_mode.c    | 439 ++++++++++++++++++
>  .../net/ethernet/intel/ice/ice_vlan_mode.h    |  13 +
>  .../net/ethernet/intel/ice/ice_vsi_vlan_lib.c |  25 +-
>  .../net/ethernet/intel/ice/ice_vsi_vlan_ops.h |   5 -
>  17 files changed, 995 insertions(+), 59 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_vlan_mode.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_vlan_mode.h
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
