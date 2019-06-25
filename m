From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 25 Jun 2019 23:54:30 +0000
Subject: [Intel-wired-lan] [PATCH] e1000: Use dma_wmb() instead of wmb()
 before doorbell writes
In-Reply-To: <20190610212750.173711-1-venkateshs@google.com>
References: <20190610212750.173711-1-venkateshs@google.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B970B387B@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Venkatesh Srinivas
> Sent: Monday, June 10, 2019 2:28 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: intel-wired-lan at osuosl.org; vsrinivas at ops101.org
> Subject: [Intel-wired-lan] [PATCH] e1000: Use dma_wmb() instead of wmb()
> before doorbell writes
> 
> e1000 writes to doorbells to post transmit descriptors and fill the
> receive ring. After writing descriptors to memory but before
> writing to doorbells, use dma_wmb() rather than wmb(). wmb() is more
> heavyweight than necessary for a device to see descriptor writes.
> 
> On x86, this avoids SFENCEs before doorbell writes in both the
> tx and rx paths. On ARM, this converts DSB ST -> DMB OSHST.
> 
> Tested: 82576EB / x86; QEMU (qemu emulates an 8257x)
> 
> Signed-off-by: Venkatesh Srinivas <venkateshs@google.com>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Tested with a handful of physical parts that I still have laying around just for this purpose, 82540EM, multiple 82541PI, 82541GI, 82543GC, multiple 82544GC, ...
