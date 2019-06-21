From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 21 Jun 2019 01:47:50 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] net: intel: igb: add RR2DCDELAY
 to ethtool registers dump
In-Reply-To: <20190618115513.99661-2-dedekind1@gmail.com>
References: <20190618115513.99661-1-dedekind1@gmail.com>
 <20190618115513.99661-2-dedekind1@gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B970B1271@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2019-06-18 at 14:55 +0300, Artem Bityutskiy wrote:
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> This patch adds the RR2DCDELAY register to the ethtool registers dump.
> RR2DCDELAY exists on I210 and I211 Intel Gigabit Ethernet chips and it stands
> for "Read Request To Data Completion Delay". Here is how this register is
> described in the I210 datasheet:
> 
> "This field captures the maximum PCIe split time in 16 ns units, which is the
> maximum delay between the read request to the first data completion. This is
> giving an estimation of the PCIe round trip time."
> 
> In other words, whenever I210 reads from the host memory (e.g., fetches a
> descriptor from the ring), the chip measures every PCI DMA read transaction and
> captures the maximum value. So it ends up containing the longest DMA
> transaction time.
> 
> This register is very useful for troubleshooting and research purposes. If you
> are dealing with time-sensitive networks, this register can help you get
> an idea of your "I210-to-ring" latency. This helps answering questions like
> "should I have PCIe ASPM enabled?" or "should I enable deep C-states?" on
> my system.
> 
> It is safe to read this register at any point, reading it has no effect on
> the I210 chip functionality.
> 
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_regs.h  | 2 ++
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 5 ++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
