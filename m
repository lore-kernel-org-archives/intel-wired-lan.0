From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 18 Aug 2017 02:56:34 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: fix buffer overrun
 while	the I219 is processing DMA transactions
In-Reply-To: <20170806134918.9222-1-sasha.neftin@intel.com>
References: <20170806134918.9222-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C682080@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Sasha Neftin
> Sent: Sunday, August 6, 2017 6:49 AM
> To: Neftin, Sasha <sasha.neftin@intel.com>; Ruinskiy, Dima
> <dima.ruinskiy@intel.com>; Avargil, Raanan <raanan.avargil@intel.com>;
> intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: fix buffer overrun while the
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
> Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> Reviewed-by: Raanan Avargil <raanan.avargil@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
