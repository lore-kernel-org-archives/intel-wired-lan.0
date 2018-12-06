From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 6 Dec 2018 22:47:17 +0000
Subject: [Intel-wired-lan] [PATCH v3 1/2] i40e: fix VLAN.TCI == 0 RX HW
 offload
In-Reply-To: <6a993b48a235e7a65d522642a74a28a7391ad964.1543944510.git.mirq-linux@rere.qmqm.pl>
References: <6a993b48a235e7a65d522642a74a28a7391ad964.1543944510.git.mirq-linux@rere.qmqm.pl>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D32C9EE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Michal Miroslaw
> Sent: Tuesday, December 4, 2018 9:31 AM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 1/2] i40e: fix VLAN.TCI == 0 RX HW
> offload
> 
> This fixes two bugs in hardware VLAN offload:
>  1. VLAN.TCI == 0 was being dropped
>  2. there was a race between disabling of VLAN RX feature in hardware
>     and processing RX queue, where packets processed in this window
>     could have their VLAN information dropped
> 
> Fix moves the VLAN handling into i40e_process_skb_fields() to save on
> duplicated code. i40e_receive_skb() becomes trivial and so is removed.
> 
> Signed-off-by: Micha? Miros?aw <michal.miroslaw@atendesoftware.pl>
> Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
> ---
> v3:
>  * fix whitespace for checkpatch
> v2:
>  * no changes
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 31 +++++--------------
>  .../ethernet/intel/i40e/i40e_txrx_common.h    |  2 --
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  6 +---
>  3 files changed, 9 insertions(+), 30 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


