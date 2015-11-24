From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 24 Nov 2015 13:03:55 -0800
Subject: [Intel-wired-lan] [PATCH v6 1/6] net: Generalize udp based
 tunnel offload
In-Reply-To: <1448262224-71480-2-git-send-email-anjali.singhai@intel.com>
References: <anjali.singhai@intel.com>
 <1448262224-71480-1-git-send-email-anjali.singhai@intel.com>
 <1448262224-71480-2-git-send-email-anjali.singhai@intel.com>
Message-ID: <1448399035.3154.7.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, 2015-11-22 at 23:03 -0800, Anjali Singhai Jain wrote:
> Replace add/del ndo ops for vxlan_port with tunnel_port so that all
> UDP
> based tunnels can use the same ndo op. Add a parameter to pass tunnel
> type to the ndo_op.
> 
> Change all drivers to use the generalized udp tunnel offload
> 
> Patch was compile tested with x86_64_defconfig.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> ---
> ?drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 15 ++++++---
> ?drivers/net/ethernet/broadcom/bnxt/bnxt.c??????? | 13 +++++---
> ?drivers/net/ethernet/emulex/benet/be_main.c????? | 14 +++++---
> ?drivers/net/ethernet/intel/fm10k/fm10k_netdev.c? | 27 ++++++++++++
> ----
> ?drivers/net/ethernet/intel/i40e/i40e_main.c????? | 41
> +++++++++++++++++-------
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_main.c??? | 17 +++++++---
> ?drivers/net/ethernet/mellanox/mlx4/en_netdev.c?? | 21 ++++++++----
> ?drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c | 17 +++++++---
> ?drivers/net/vxlan.c????????????????????????????? | 23 +++++++------
> ?include/linux/netdevice.h??????????????????????? | 34 ++++++++++--
> --------
> ?include/net/udp_tunnel.h???????????????????????? |? 6 ++++
> ?11 files changed, 157 insertions(+), 71 deletions(-)

This patch breaks the Broadcom drivers, they don't even compile after
this patch.

Dropping this series until the compile issues are resolved.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151124/ec8c99ad/attachment.asc>
