From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 11 Feb 2022 11:01:13 +0000
Subject: [Intel-wired-lan] [PATCH net v5] iavf: Fix handling of vlan
 strip virtual channel messages
In-Reply-To: <20220124133543.274845-1-michal.maloszewski@intel.com>
References: <20220124133543.274845-1-michal.maloszewski@intel.com>
Message-ID: <DM8PR11MB5621049D39301AEE22F0B52CAB309@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Michal Maloszewski
> Sent: Monday, January 24, 2022 2:36 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Maloszewski, Michal <michal.maloszewski@intel.com>; Ciosek, NorbertX
> <norbertx.ciosek@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v5] iavf: Fix handling of vlan strip virtual
> channel messages
> 
> Modify netdev->features for vlan stripping based on virtual channel
> messages received from the PF. Change is needed to synchronize vlan strip
> status between PF sysfs and iavf ethtool.
> 
> Fixes: 5951a2b9812d ("iavf: Fix VLAN feature flags after VFR")
> Signed-off-by: Norbert Ciosek <norbertx.ciosek@intel.com>
> Signed-off-by: Michal Maloszewski <michal.maloszewski@intel.com>
> ---
> v5: Changed fixes tag into the proper one due to missclick in pervious one
> v4: Changed the same flags which occured in statement and did not have any
> sense.
>     Changed fixes tag into the proper one
> v3: NETIF_F_HW_VLAN_RX changed into NETIF_F_HW_VLAN_CTAG_RX
> because there's
>     no such definition since Linux 3.10. The code is the same as the one from
> OOT.
>     Code successfully passed inner review. netdev_update_features()
> function is not added
>     because it causes infinite loop.
> v2: Changed fixes tag into the more probable and accurate
> ---
> ---
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index e508122eddb7..6378d3c216f9 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
