From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Wed, 4 Aug 2021 15:06:44 +0300
Subject: [Intel-wired-lan] [PATCH v2] igc: fix page fault when
 thunderbolt is unplugged
In-Reply-To: <20210713130036.741188-1-aaron.ma@canonical.com>
References: <20210702045120.22855-1-aaron.ma@canonical.com>
 <20210713130036.741188-1-aaron.ma@canonical.com>
Message-ID: <567b12f8-359a-5268-e020-edcf2dd46937@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/13/2021 16:00, Aaron Ma wrote:
> After unplug thunerbolt dock with i225, pciehp interrupt is triggered,
> remove call will read/write mmio address which is already disconnected,
> then cause page fault and make system hang.
> 
> Check PCI state to remove device safely.
> 
> Trace:
> BUG: unable to handle page fault for address: 000000000000b604
> Oops: 0000 [#1] SMP NOPTI
> RIP: 0010:igc_rd32+0x1c/0x90 [igc]
> Call Trace:
> igc_ptp_suspend+0x6c/0xa0 [igc]
> igc_ptp_stop+0x12/0x50 [igc]
> igc_remove+0x7f/0x1c0 [igc]
> pci_device_remove+0x3e/0xb0
> __device_release_driver+0x181/0x240
> 
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 32 ++++++++++++++---------
>   drivers/net/ethernet/intel/igc/igc_ptp.c  |  3 ++-
>   2 files changed, 21 insertions(+), 14 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
