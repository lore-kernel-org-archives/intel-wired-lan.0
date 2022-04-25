From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Mon, 25 Apr 2022 11:34:42 +0000
Subject: [Intel-wired-lan] [PATCH net v1] ixgbe: ensure IPsec VF<->PF
 compatibility
In-Reply-To: <737616899df2a482e4ec35aa4056c9ac608d2f50.1648714609.git.leonro@nvidia.com>
References: <737616899df2a482e4ec35aa4056c9ac608d2f50.1648714609.git.leonro@nvidia.com>
Message-ID: <DM8PR11MB56217CED4DFFAB90FA256C0CABF89@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Leon Romanovsky
> Sent: Thursday, March 31, 2022 10:20 AM
> To: David S . Miller <davem@davemloft.net>; Jakub Kicinski
> <kuba@kernel.org>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>; Shannon Nelson
> <snelson@pensando.io>; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; intel-wired-lan at lists.osuosl.org; Jeff Kirsher
> <jeffrey.t.kirsher@intel.com>; Raed Salem <raeds@nvidia.com>; Shannon
> Nelson <shannon.nelson@oracle.com>; Paolo Abeni <pabeni@redhat.com>;
> Leon Romanovsky <leonro@nvidia.com>
> Subject: [Intel-wired-lan] [PATCH net v1] ixgbe: ensure IPsec VF<->PF
> compatibility
> 
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The VF driver can forward any IPsec flags and such makes the function is not
> extendable and prone to backward/forward incompatibility.
> 
> If new software runs on VF, it won't know that PF configured something
> completely different as it "knows" only XFRM_OFFLOAD_INBOUND flag.
> 
> Fixes: eda0333ac293 ("ixgbe: add VF IPsec management")
> Reviewed-by: Raed Salem <raeds@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>a
> ---
> Chaagelog:
> v1:
>  * Replaced bits arithmetic with more simple expression
> v0:
> https://lore.kernel.org/all/3702fad8a016170947da5f3c521a9251cf0f4a22.16
> 48637865.git.leonro at nvidia.com
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> index e596e1a9fc75..69d11ff7677d 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> @@ -903,7 +903,8 @@ int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter
> *adapter, u32 *msgbuf, u32 vf)

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
