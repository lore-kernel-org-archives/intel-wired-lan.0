From: Radoslaw Tyl <radoslawx.tyl@intel.com>
Date: Tue, 29 Jun 2021 12:49:36 +0200
Subject: [Intel-wired-lan] [PATCH 0/5] Introducing 1.5 API for mailbox
 communication
Message-ID: <20210629104941.2460721-1-radoslawx.tyl@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The change is a consequence of errors reported by the ixgbevf driver
while starting several virtual guests at the same time on ESX host.
During this, VF was not able to communicate correctly with the PF,
as a result reported "PF still in reset state. Is the PF interface up?"
and then goes to locked state. The only thing left was to reload
the VF driver on the guest OS.

The background of the problem is that the current PFU and VFU
semaphore locking mechanism between sender and receiver may cause
overriding Mailbox memory (VFMBMEM), in such scenario receiver of
the original message will read the invalid, corrupted or one (or more)
message may be lost.

This change is actually as a support for communication with PF ESX
driver and does not contains changes and support for ixgbe driver.
For maintain backward compatibility, previous communication method
has been preserved in the form of LEGACY functions.

In the future there is a plan to add a support for a 1.5 mailbox API
communication also to ixgbe driver.

Radoslaw Tyl (5):
  ixgbevf: Rename MSGTYPE to SUCCESS and FAILURE
  ixgbevf: Improve error handling in mailbox
  ixgbevf: Add legacy suffix to old API mailbox functions
  ixgbevf: Mailbox improvements
  ixgbevf: Add support for new mailbox communication between PF and VF

 drivers/net/ethernet/intel/ixgbevf/defines.h  |   4 +
 drivers/net/ethernet/intel/ixgbevf/ipsec.c    |  11 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h  |   5 +
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  11 +-
 drivers/net/ethernet/intel/ixgbevf/mbx.c      | 325 ++++++++++++++----
 drivers/net/ethernet/intel/ixgbevf/mbx.h      |  19 +-
 drivers/net/ethernet/intel/ixgbevf/vf.c       |  62 ++--
 drivers/net/ethernet/intel/ixgbevf/vf.h       |   5 +-
 8 files changed, 329 insertions(+), 113 deletions(-)

-- 
2.27.0

