From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 20 Nov 2015 04:09:16 +0000
Subject: [Intel-wired-lan] [Next PATCH] e1000: fix data race between
 tx_ring->next_to_clean
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81D3D9ED@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> e1000_clean_tx_irq cleans buffers and sets tx_ring->next_to_clean,
> then e1000_xmit_frame reuses the cleaned buffers. But there are no
> memory barriers when buffers gets recycled, so the recycled buffers
> can be corrupted.
>
> Use smp_store_release to update tx_ring->next_to_clean and
> smp_load_acquire to read tx_ring->next_to_clean to properly
> hand off buffers from e1000_clean_tx_irq to e1000_xmit_frame. 
>
> The data race was found with KernelThreadSanitizer (KTSAN).
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> ---
>  drivers/net/ethernet/intel/e1000/e1000.h      | 7 +++++--
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 5 ++++-
>  2 files changed, 9 insertions(+), 3 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
