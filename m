From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 10 Nov 2017 03:10:00 +0000
Subject: [Intel-wired-lan] [PATCH v2 1/1] e1000e: fix buffer overrun
 while the I219 is processing DMA transactions
In-Reply-To: <20171106063159.32289-1-sasha.neftin@intel.com>
References: <20171106063159.32289-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C6EB135@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Sasha Neftin
> Sent: Sunday, November 5, 2017 10:32 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Neftin, Sasha
> <sasha.neftin@intel.com>; intel-wired-lan at lists.osuosl.org; Avargil, Raanan
> <raanan.avargil@intel.com>; Duyck, Alexander H
> <alexander.h.duyck@intel.com>; Ruinskiy, Dima <dima.ruinskiy@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2 1/1] e1000e: fix buffer overrun while the
> I219 is processing DMA transactions
> 
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
> https://www.intel.com/content/www/us/en/embedded/products/networki
> ng/
> ethernet-connection-i218-family-documentation.html
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> Reviewed-by: Alexander H Duyck <alexander.h.duyck@intel.com>
> Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> Reviewed-by: Raanan Avargil <raanan.avargil@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.h | 3 ++-
>  drivers/net/ethernet/intel/e1000e/netdev.c  | 9 ++++++---
>  2 files changed, 8 insertions(+), 4 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
