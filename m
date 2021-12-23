From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 23 Dec 2021 08:24:24 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 12/14] ice: Advertise
 802.1ad VLAN filtering and offloads for PF netdev
In-Reply-To: <20211202163852.36436-12-anthony.l.nguyen@intel.com>
References: <20211202163852.36436-1-anthony.l.nguyen@intel.com>
 <20211202163852.36436-12-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB33672F580EDD0A8475623E7EFC7E9@BYAPR11MB3367.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v3 12/14] ice: Advertise 802.1ad
> VLAN filtering and offloads for PF netdev
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> In order for the driver to support 802.1ad VLAN filtering and offloads, it needs
> to advertise those VLAN features and also support modifying those VLAN
> features, so make the necessary changes to ice_set_netdev_features(). By
> default, enable CTAG insertion/stripping and CTAG filtering for both Single and
> Double VLAN Modes (SVM/DVM).
> Also, in DVM, enable STAG filtering by default. This is done by setting the
> feature bits in netdev->features. Also, in DVM, support toggling of STAG
> insertion/stripping, but don't enable them by default. This is done by setting the
> feature bits in
> netdev->hw_features.
> 
> Since 802.1ad VLAN filtering and offloads are only supported in DVM, make
> sure they are not enabled by default and that they cannot be enabled during
> runtime, when the device is in SVM.
> 
> Add an implementation for the ndo_fix_features() callback. This is needed since
> the hardware cannot support multiple VLAN ethertypes for VLAN
> insertion/stripping simultaneously and all supported VLAN filtering must either
> be enabled or disabled together.
> 
> Disable inner VLAN stripping by default when DVM is enabled. If a VSI supports
> stripping the inner VLAN in DVM, then it will have to configure that during
> runtime. For example if a VF is configured in a port VLAN while DVM is enabled
> it will be allowed to offload inner VLANs.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  |  27 ++-
> drivers/net/ethernet/intel/ice/ice_main.c | 260 ++++++++++++++++++----
>  2 files changed, 238 insertions(+), 49 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
