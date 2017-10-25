From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 25 Oct 2017 08:20:19 -0700
Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: fix buffer overrun
 while the I219 is processing DMA transactions
In-Reply-To: <20171025122318.5692-1-sasha.neftin@intel.com>
References: <20171025122318.5692-1-sasha.neftin@intel.com>
Message-ID: <1508944819.12406.2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2017-10-25 at 15:23 +0300, Sasha Neftin wrote:
> Description: Intel? 100/200 Series Chipset platforms
> reduced the round-trip latency for the LAN Controller
> DMA accesses, causing in some high performance cases a buffer
> overrun while the I219 LAN Connected Device is processing
> the DMA transactions. I219LM and I219V devices can fall into
> unrecovered Tx hang under very stressfully UDP traffic and multiple
> reconnection of Ethernet cable. This Tx hang of the LAN Controller
> is only recovered if the system is rebooted. Slightly slow down
> DMA access by reducing the number of outstanding requests.
> This workaround could have an impact on TCP traffic performance
> on the platform. Disabling TSO eliminates performance loss for TCP
> traffic without a noticeable impact on CPU performance.
> 
> Please, refer to I218/I219 specification update:
> https://www.intel.com/content/www/us/en/embedded/products/networking/
> ethernet-connection-i218-family-documentation.html
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> Reviewed-by: Alexander H Duyck <alexander.h.duyck@intel.com>
> Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> Reviewed-by: Raanan Avargil <raanan.avargil@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.h |  3 ++-
>  drivers/net/ethernet/intel/e1000e/netdev.c  | 11 ++++++++---
>  2 files changed, 10 insertions(+), 4 deletions(-)

Sasha, you generated this patch against an old tree and many of these
changes are already upstream in Dave's net-next tree, so this patch
does not apply cleanly.

Please rebase your patch against my latest next-queue tree, dev-queue
branch and submit a v2 please.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20171025/2b3cdd73/attachment.asc>
