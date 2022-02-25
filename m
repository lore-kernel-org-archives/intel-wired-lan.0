From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 25 Feb 2022 16:22:03 +0000
Subject: [Intel-wired-lan] [net-next PATCH v2 05/11] ice: move VFLR
 acknowledge during ice_free_vfs
In-Reply-To: <20220216213738.3826664-6-jacob.e.keller@intel.com>
References: <20220216213738.3826664-1-jacob.e.keller@intel.com>
 <20220216213738.3826664-6-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB56296CA36A8971CDA8CA4A09AB3E9@SJ0PR11MB5629.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Wednesday, February 16, 2022 10:38 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [net-next PATCH v2 05/11] ice: move VFLR
> acknowledge during ice_free_vfs
> 
> After removing all VFs, the driver clears the VFLR indication for VFs.
> This has been in ice since the beginning of SR-IOV support in the ice driver.
> 
> The implementation was copied from i40e, and the motivation for the VFLR
> indication clearing is described in the commit f7414531a0cf ("i40e:
> acknowledge VFLR when disabling SR-IOV")
> 
> The commit explains that we need to clear the VFLR indication because the
> virtual function undergoes a VFLR event. If we don't indicate that it is
> complete it can cause an issue when VFs are re-enabled due to a "phantom"
> VFLR.
> 
> The register block read was added under a pci_vfs_assigned check originally.
> This was done because we added the check after calling pci_disable_sriov.
> This was later moved to disable SRIOV earlier in the flow so that the VF
> drivers could be torn down before we removed functionality.
> 
> Move the VFLR acknowledge into the main loop that tears down VF
> resources. This avoids using the tmp value for iterating over VFs multiple
> times. The result will make it easier to refactor the VF array in a future
> change.
> 
> It's possible we might want to modify this flow to also stop checking
> pci_vfs_assigned. However, it seems reasonable to keep this change: we
> should only clear the VFLR if we actually disabled SR-IOV.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 27 ++++++-------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> index c469b32f665b..7ab4e7d4cfb7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> @@ -536,6 +536,14 @@ void ice_free_vfs(struct ice_pf *pf)

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
