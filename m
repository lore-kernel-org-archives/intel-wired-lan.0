From: Jithu Joseph <jithu.joseph@intel.com>
Date: Thu, 22 Apr 2021 23:25:46 -0700
Subject: [Intel-wired-lan] [PATCH v6 0/9] igc: Add support for AF_XDP
 zero-copy
Message-ID: <20210423062555.14972-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi all,

This is the sixth version of this series which adds AF_XDP zero-copy support
to igc driver.

This revision addresses review comments from Jakub Kicinski.

changes in v6:
    Patch 8/9 - "igc: Enable RX via AF_XDP zero-copy"
      * In XDP_PASS flow, copy metadata too into the skb.
      * When h/w timestamp is added by the NIC, after copying it into
        a local variable, update xdp_buff->data_meta so that
        metadata length when XDP program is called 0.
      * In igc_xdp_enable_pool(), call xsk_pool_dma_unmap() on
        failure.


Known issues (carried from v3):
    When an XDP application is running in Tx-Only mode with Zero-Copy
    enabled, it is not expected to add the frames to the fill-queue. I have
    noticed the following two issues in this scenario:
    - If XDP_USE_NEED_WAKEUP flag is not set by application, igc_poll()
      will go into infinite loop because the buffer allocation resulting
      in igc_clean_rx_irq_zc() indicating that all work is not done and NAPI
      should keep polling. This does not occur if XDP_USE_NEED_WAKEUP
      flag is set.
    - Since there are no buffers allocated by userspace for the fill
      queue, there is no memory allocated for the NIC to copy the data
      to. If the packet received is destined to the hardware queue where
      XDP application is running, no packets are received even on other
      queues.
    Both these issues can be mitigated by adding a few frames to the
    fill queue. The second issue can also be mitigated by making sure no
    packets are being received on the hardware queue where Rx is running.

v5 is here:

    https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20210226002308.2348-1-jithu.joseph at intel.com/

v4 is here:

    https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20210222090936.6768-1-jithu.joseph at intel.com/

v3 is here:

    https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20210209024243.23406-1-vedang.patel at intel.com/

v2 is here:

    https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20201223203705.78705-1-andre.guedes at intel.com/

v1 is here:

    https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20201217202415.77891-1-andre.guedes at intel.com/

Andre Guedes (9):
  igc: Move igc_xdp_is_enabled()
  igc: Refactor __igc_xdp_run_prog()
  igc: Refactor igc_clean_rx_ring()
  igc: Refactor XDP rxq info registration
  igc: Introduce TX/RX stats helpers
  igc: Introduce igc_unmap_tx_buffer() helper
  igc: Replace IGC_TX_FLAGS_XDP flag by an enum
  igc: Enable RX via AF_XDP zero-copy
  igc: Enable TX via AF_XDP zero-copy

 drivers/net/ethernet/intel/igc/igc.h      |  33 +-
 drivers/net/ethernet/intel/igc/igc_base.h |   2 +
 drivers/net/ethernet/intel/igc/igc_main.c | 658 ++++++++++++++++++----
 drivers/net/ethernet/intel/igc/igc_xdp.c  | 109 +++-
 drivers/net/ethernet/intel/igc/igc_xdp.h  |   8 +-
 5 files changed, 683 insertions(+), 127 deletions(-)

-- 
2.17.1

