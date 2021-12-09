From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 9 Dec 2021 10:29:54 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 14/14] ice: Add ability
 for PF admin to enable VF VLAN pruning
In-Reply-To: <20211202163852.36436-14-anthony.l.nguyen@intel.com>
References: <20211202163852.36436-1-anthony.l.nguyen@intel.com>
 <20211202163852.36436-14-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB3367C0960EC463E50431F9E7FC709@BYAPR11MB3367.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v3 14/14] ice: Add ability for PF
> admin to enable VF VLAN pruning
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> VFs by default are able to see all tagged traffic regardless of trust and VLAN
> filters. Based on legacy devices (i.e. ixgbe, i40e), customers expect VFs to
> receive all VLAN tagged traffic with a matching destination MAC.
> 
> Add an ethtool private flag 'vf-vlan-pruning' and set the default to off so VFs
> will receive all VLAN traffic directed towards them. When the flag is turned on,
> VF will only be able to receive untagged traffic or traffic with VLAN tags it has
> created interfaces for.
> 
> Also, the flag cannot be changed while any VFs are allocated. This was done to
> simplify the implementation. So, if this flag is needed, then the PF admin must
> enable it. If the user tries to enable the flag while VFs are active, then print an
> unsupported message with the vf-vlan-pruning flag included. In case multiple
> flags were specified, this makes it clear to the user which flag failed.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h           |  1 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c   |  9 +++++++++
>  .../ethernet/intel/ice/ice_vf_vsi_vlan_ops.c   | 18 ++++++++++++++++--
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c   | 14 ++++++++++++++
>  4 files changed, 40 insertions(+), 2 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
