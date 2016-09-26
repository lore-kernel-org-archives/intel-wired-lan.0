From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 26 Sep 2016 16:21:08 +0000
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: fix panic when using
 macvlan with l2-fwd-offload enabled
In-Reply-To: <20160922220652.30798.62070.stgit@localhost6.localdomain6>
References: <20160922220652.30798.62070.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0EAB5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Thursday, September 22, 2016 3:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: fix panic when using
> macvlan with l2-fwd-offload enabled
> 
> Fix NULL pointer dereference in the case where a macvlan interface is
> brought up while the PF is still down:
> 
> #ip link set eth2 down
> #ip link add link eth2 type macvlan
> #ip link set macvlan0 up
> 
> BUG: unable to handle kernel NULL pointer dereference at
> 0000000000000010
> IP: [<ffffffffa0170fb2>] ixgbe_alloc_rx_buffers+0x42/0x1a0 [ixgbe]
> 
> Call Trace:
> [<ffffffffa017336b>] ixgbe_configure_rx_ring+0x2eb/0x3d0 [ixgbe]
> [<ffffffffa0173811>] ixgbe_fwd_ring_up+0xd1/0x380 [ixgbe]
> [<ffffffffa0179709>] ixgbe_fwd_add+0x149/0x230 [ixgbe]
> [<ffffffffa0113480>] macvlan_open+0x260/0x2b0 [macvlan]
> 
> Reported-by: Matthew Garrett <mjg59@coreos.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


