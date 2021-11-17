From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 17 Nov 2021 11:30:22 +0000
Subject: [Intel-wired-lan] [PATCH net] iavf: Fix VLAN feature flags
 after VFR
In-Reply-To: <20211105162025.23912-1-brett.creeley@intel.com>
References: <20211105162025.23912-1-brett.creeley@intel.com>
Message-ID: <DM8PR11MB56210E8944350C64FB991A9BAB9A9@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Brett Creeley
> Sent: pi?tek, 5 listopada 2021 17:20
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net] iavf: Fix VLAN feature flags after VFR
> 
> When a VF goes through a reset, it's possible for the VF's feature set to
> change. For example it may lose the VIRTCHNL_VF_OFFLOAD_VLAN
> capability after VF reset. Unfortunately, the driver doesn't correctly deal with
> this situation and errors are seen from downing/upping the interface and/or
> moving the interface in/out of a network namespace.
> 
> When setting the interface down/up we see the following errors after the
> VIRTCHNL_VF_OFFLOAD_VLAN capability was taken away from the VF:
> 
> ice 0000:51:00.1: VF 1 failed opcode 12, retval: -64 iavf 0000:51:09.1:
> Failed to add VLAN filter, error IAVF_NOT_SUPPORTED ice 0000:51:00.1: VF
> 1 failed opcode 13, retval: -64 iavf 0000:51:09.1: Failed to delete VLAN filter,
> error IAVF_NOT_SUPPORTED
> 
> These add/delete errors are happening because the VLAN filters are tracked
> internally to the driver and regardless of the VLAN_ALLOWED() setting the
> driver tries to delete/re-add them over virtchnl.
> 
> Fix the delete failure by making sure to delete any VLAN filter tracking in the
> driver when a removal request is made, while preventing the virtchnl
> request.  This makes it so the driver's VLAN list is up to date and the errors
> are
> 
> Fix the add failure by making sure the check for VLAN_ALLOWED() during
> reset is done after the VF receives its capability list from the PF via
> VIRTCHNL_OP_GET_VF_RESOURCES. If VLAN functionality is not allowed,
> then prevent requesting re-adding the filters over virtchnl.
> 
> When moving the interface into a network namespace we see the following
> errors after the VIRTCHNL_VF_OFFLOAD_VLAN capability was taken away
> from the VF:
> 
> iavf 0000:51:09.1 enp81s0f1v1: NIC Link is Up Speed is 25 Gbps Full Duplex iavf
> 0000:51:09.1 temp_27: renamed from enp81s0f1v1 iavf 0000:51:09.1 mgmt:
> renamed from temp_27 iavf 0000:51:09.1 dev27: set_features() failed (-22);
> wanted 0x020190001fd54833, left 0x020190001fd54bb3
> 
> These errors are happening because we aren't correctly updating the netdev
> capabilities and dealing with ndo_fix_features() and
> ndo_set_features() correctly.
> 
> Fix this by only reporting errors in the driver's ndo_set_features() callback
> when VIRTCHNL_VF_OFFLOAD_VLAN is not allowed and any attempt to
> enable the VLAN features is made. Also, make sure to disable VLAN
> insertion, filtering, and stripping since the VIRTCHNL_VF_OFFLOAD_VLAN
> flag applies to all of them and not just VLAN stripping.
> 
> Also, after we process the capabilities in the VF reset path, make sure to call
> netdev_update_features() in case the capabilities have changed in order to
> update the netdev's feature set to match the VF's actual capabilities.
> 
> Lastly, make sure to always report success on VLAN filter delete when
> VIRTCHNL_VF_OFFLOAD_VLAN is not supported. The changed flow in
> iavf_del_vlans() allows the stack to delete previosly existing VLAN filters
> even if VLAN filtering is not allowed. This makes it so the VLAN filter list is up
> to date.
> 
> Fixes: 8774370d268f ("i40e/i40evf: support for VF VLAN tag stripping control")
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        |  1 +
>  drivers/net/ethernet/intel/iavf/iavf_main.c   | 33 ++++++--------
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 45 +++++++++++++++++--
>  3 files changed, 56 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index e66a7e455ce1..4d62231ec6b5 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -505,4 +505,5 @@ void iavf_add_adv_rss_cfg(struct iavf_adapter
> *adapter);  void iavf_del_adv_rss_cfg(struct iavf_adapter *adapter);  struct
> iavf_mac_filter *iavf_add_filter(struct iavf_adapter *adapter,
>  					const u8 *macaddr);
> +int iavf_lock_timeout(struct mutex *lock, unsigned int msecs);
>  #endif /* _IAVF_H_ */
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 814c87715f68..a655073af6c7 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
