From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 27 May 2022 09:26:42 -0700
Subject: [Intel-wired-lan] [PATCH v2 2/2] igb: Make DMA faster when CPU
 is active on the PCIe link
In-Reply-To: <20220525113113.171746-2-kai.heng.feng@canonical.com>
References: <20220525113113.171746-1-kai.heng.feng@canonical.com>
 <20220525113113.171746-2-kai.heng.feng@canonical.com>
Message-ID: <4344ab36-e925-b68f-b54e-4cbb55e48836@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 5/25/2022 4:31 AM, Kai-Heng Feng wrote:
> Intel I210 on some Intel Alder Lake platforms can only achieve ~750Mbps
> Tx speed via iperf. The RR2DCDELAY shows around 0x2xxx DMA delay, which
> will be significantly lower when 1) ASPM is disabled or 2) SoC package
> c-state stays above PC3. When the RR2DCDELAY is around 0x1xxx the Tx
> speed can reach to ~950Mbps.
> 
> According to the I210 datasheet "8.26.1 PCIe Misc. Register - PCIEMISC",
> "DMA Idle Indication" doesn't seem to tie to DMA coalesce anymore, so
> set it to 1b for "DMA is considered idle when there is no Rx or Tx AND
> when there are no TLPs indicating that CPU is active detected on the
> PCIe link (such as the host executes CSR or Configuration register read
> or write operation)" and performing Tx should also fall under "active
> CPU on PCIe link" case.
> 
> In addition to that, commit b6e0c419f040 ("igb: Move DMA Coalescing init
> code to separate function.") seems to wrongly changed from enabling
> E1000_PCIEMISC_LX_DECISION to disabling it, also fix that.
Patches applied. However, this patch seems like net material where patch 
1[1] seems more suited for net-next so I plan to split to those 
respective trees.

Thanks,
Tony

> Fixes: b6e0c419f040 ("igb: Move DMA Coalescing init code to separate function.")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

[1] 
https://lore.kernel.org/netdev/20220525113113.171746-1-kai.heng.feng at canonical.com/
