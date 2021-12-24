From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 24 Dec 2021 18:35:24 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 07/14] ice: Adjust naming
 for inner VLAN operations
In-Reply-To: <20211202163852.36436-7-anthony.l.nguyen@intel.com>
References: <20211202163852.36436-1-anthony.l.nguyen@intel.com>
 <20211202163852.36436-7-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB3367640562D9C161D75DEAEEFC7F9@BYAPR11MB3367.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v3 07/14] ice: Adjust naming for
> inner VLAN operations
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Current operations act on inner VLAN fields. To support double VLAN, outer
> VLAN operations and functions will be implemented. Add the "inner" naming to
> existing VLAN operations to distinguish them from the upcoming outer values
> and functions. Some spacing adjustments are made to align values.
> 
> Note that the inner is not talking about a tunneled VLAN, but the second VLAN
> in the packet. For SVM the driver uses inner or single VLAN filtering and
> offloads and in Double VLAN Mode the driver uses the inner filtering and
> offloads for SR-IOV VFs in port VLANs in order to support offloading the guest
> VLAN while a port VLAN is configured.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 191 +++++++++---------
>  drivers/net/ethernet/intel/ice/ice_lib.c      |   8 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
>  .../net/ethernet/intel/ice/ice_vsi_vlan_lib.c |  57 +++---
> .../net/ethernet/intel/ice/ice_vsi_vlan_lib.h |  10 +-
> .../net/ethernet/intel/ice/ice_vsi_vlan_ops.c |  10 +-
>  6 files changed, 140 insertions(+), 142 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
