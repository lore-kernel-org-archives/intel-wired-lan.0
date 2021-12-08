From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 8 Dec 2021 08:03:36 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 6/6] iavf: Restrict
 maximum VLAN filters for VIRTCHNL_VF_OFFLOAD_VLAN_V2
In-Reply-To: <20211130001604.22112-7-anthony.l.nguyen@intel.com>
References: <20211130001604.22112-1-anthony.l.nguyen@intel.com>
 <20211130001604.22112-7-anthony.l.nguyen@intel.com>
Message-ID: <DM8PR11MB56217286F2406A51C5F5784FAB6F9@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: wtorek, 30 listopada 2021 01:16
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v2 6/6] iavf: Restrict maximum
> VLAN filters for VIRTCHNL_VF_OFFLOAD_VLAN_V2
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> For VIRTCHNL_VF_OFFLOAD_VLAN, PF's would limit the number of VLAN
> filters a VF was allowed to add. However, by the time the opcode failed, the
> VLAN netdev had already been added. VIRTCHNL_VF_OFFLOAD_VLAN_V2
> added the ability for a PF to tell the VF how many VLAN filters it's allowed to
> add. Make changes to support that functionality.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 50 +++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 8bdadf6a3c0c..cb48a4ecd221 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
