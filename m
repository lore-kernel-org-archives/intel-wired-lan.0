From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 6 Dec 2018 22:47:41 +0000
Subject: [Intel-wired-lan] [PATCH v3 2/2] i40e: DRY rx_ptype handling
 code
In-Reply-To: <d1719aa5baadcab54eaf822ed519934ab34ea5a5.1543944510.git.mirq-linux@rere.qmqm.pl>
References: <6a993b48a235e7a65d522642a74a28a7391ad964.1543944510.git.mirq-linux@rere.qmqm.pl>
 <d1719aa5baadcab54eaf822ed519934ab34ea5a5.1543944510.git.mirq-linux@rere.qmqm.pl>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D32C9FA@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 2/2] i40e: DRY rx_ptype handling code
> 
> Move rx_ptype extracting to i40e_process_skb_fields() to avoid duplicating
> the code.
> 
> Signed-off-by: Micha? Miros?aw <michal.miroslaw@atendesoftware.pl>
> Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
> ---
> v3:
>  * no changes
> v2:
>  * fix prototype in i40e_txrx_common.h
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 12 ++++--------
>  drivers/net/ethernet/intel/i40e/i40e_txrx_common.h |  3 +--
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c         |  6 +-----
>  3 files changed, 6 insertions(+), 15 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


