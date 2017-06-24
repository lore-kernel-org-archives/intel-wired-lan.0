From: Daniel Borkmann <daniel@iogearbox.net>
Date: Sat, 24 Jun 2017 21:13:52 +0200
Subject: [Intel-wired-lan] [PATCH net-next] bpf,
	i40e: report bpf prog id during XDP_QUERY_PROG
Message-ID: <bc0cefa09874e2d55d045303c2948e586b58fb5d.1498331301.git.daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fill the XDP prog_id with the id just like we do in other XDP enabled
drivers such as ixgbe. This is needed so that on dump we can retrieve
the attached program based on the id, and dump BPF insns, opcodes, etc
back to user space. Only XDP driver missing this is currently i40e.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 [ Jeff, this should still go into this net-next window, so that
   XDP_QUERY_PROG is covered for all XDP drivers wrt id. Thanks. ]

 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 2db93d3..a76ca6c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9589,6 +9589,7 @@ static int i40e_xdp(struct net_device *dev,
 		return i40e_xdp_setup(vsi, xdp->prog);
 	case XDP_QUERY_PROG:
 		xdp->prog_attached = i40e_enabled_xdp_vsi(vsi);
+		xdp->prog_id = vsi->xdp_prog ? vsi->xdp_prog->aux->id : 0;
 		return 0;
 	default:
 		return -EINVAL;
-- 
1.9.3

