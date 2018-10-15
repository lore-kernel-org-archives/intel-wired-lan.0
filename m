From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 15 Oct 2018 12:18:26 -0700
Subject: [Intel-wired-lan] [net-next 0/3] fm10k: driver updates
Message-ID: <20181015191829.17115-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series includes a few driver updates for the fm10k host interface
driver. In addition to a fix related to strict platforms which can trigger
machine check exceptions during VF resets, we also add the device IDs for
the SDI adapters which were never upstreamed previously, even though the
support exists in the out-of-tree driver and the IDs are already in the
pci.ids database.

Jacob Keller (2):
  fm10k: ensure completer aborts are marked as non-fatal after a resume
  fm10k: add missing device IDs to the upstream driver

Ngai-Mint Kwan (1):
  fm10k: fix SM mailbox full condition

 drivers/net/ethernet/intel/fm10k/fm10k_iov.c  | 51 +++++++++++--------
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c  |  2 +
 drivers/net/ethernet/intel/fm10k/fm10k_type.h |  2 +
 3 files changed, 34 insertions(+), 21 deletions(-)

-- 
2.18.0.219.gaf81d287a9da

