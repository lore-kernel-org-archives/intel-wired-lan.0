From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Mon, 14 May 2018 11:16:06 -0700
Subject: [Intel-wired-lan] [PATCH 0/2] do not reuse old MACs on VF reload
Message-ID: <20180514181449.26797.30080.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The following series changes the logic associated with MAC address handling.
In particular it aims to avoid re-using MAC addresses from older VFs.

On the PF side we NACK the validation of the MAC on VF reset unless the
MAC was set by the PF and remove the warning so it does not get spammed.

On the VF we need to set hw->mac.perm_addr in ixgbevf_set_mac() in order
to avoid the driver keeping 2 MACs and lose the manually set MAC in case
of a reset which will then lead to spoofed packets.

---

Emil Tantilov (2):
      ixgbe: force VF to grab new MAC on driver reload
      ixgbevf: fix MAC address changes through ixgbevf_set_mac()


 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c    |    5 +----
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    1 +
 2 files changed, 2 insertions(+), 4 deletions(-)

--

