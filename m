From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 18 Aug 2015 02:54:01 +0000
Subject: [Intel-wired-lan] [PATCH] e100: Release skb when DMA mapping
	is	failed in e100_xmit_prepare
In-Reply-To: <1438569648-20469-1-git-send-email-baijiaju1990@163.com>
References: <1438569648-20469-1-git-send-email-baijiaju1990@163.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81AE8727@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jia-Ju Bai
> Sent: Sunday, August 02, 2015 7:41 PM
> To: Kirsher, Jeffrey T; Brandeburg, Jesse
> Cc: netdev at vger.kernel.org; Jia-Ju Bai; intel-wired-lan at lists.osuosl.org;
> linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] e100: Release skb when DMA mapping is
> failed in e100_xmit_prepare
> 
> When pci_dma_mapping_error in e100_xmit_prepare is failed, the skb buffer
> allocated by netdev_alloc_skb_ip_align in e100_rx_alloc_skb is not
> released, which causes a possible resource leak.
> This patch adds error handling code to fix it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
> ---
>  drivers/net/ethernet/intel/e100.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
