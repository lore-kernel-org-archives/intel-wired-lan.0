From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Tue, 02 Jun 2015 10:04:08 -0700
Subject: [Intel-wired-lan] [PATCH 0/2] pci: Provide a flag to access VPD
	through function 0
Message-ID: <20150602165706.6252.76253.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Many multi-function devices provide shared registers in extended
config space for accessing VPD. The behavior of these registers
means that the state must be tracked and access locked correctly
for accesses not to hang or worse. One way to meet these needs is
to always perform the accesses through function 0, thereby using
the state tracking and mutex that already exists.

To provide this behavior, add a dev_flags bit to indicate that this
should be done. This bit can then be set for any non-zero function
that needs to redirect such VPD access to function 0. Do not set
this bit on the zero function or there will be an infinite recursion.

The second patch uses this new flag to invoke this behavior on all
multi-function Intel Ethernet devices.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>

---

Mark D Rustad (2):
      pci: Add dev_flags bit to access VPD through function 0
      pci: Add VPD quirk for Intel Ethernet devices


 drivers/pci/access.c |   39 ++++++++++++++++++++++++++++++++++++++-
 drivers/pci/quirks.c |    9 +++++++++
 include/linux/pci.h  |    2 ++
 3 files changed, 49 insertions(+), 1 deletion(-)

-- 
Mark Rustad, Network Division, Intel Corporation
