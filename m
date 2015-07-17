From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 17 Jul 2015 15:22:18 -0700
Subject: [Intel-wired-lan] [PATCH 0/3] ixgbe: Add support for X550EM devices
	with SFPs
Message-ID: <20150717222130.123580.2307.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The following patches add remaining bits of support for X550EM
devices with SFPs. The last patch adds the device ID.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>

---

Mark D Rustad (3):
      ixgbe: Accept SFP not present errors on all devices
      ixgbe: Add X550EM support for SFP insertion interrupt
      ixgbe: Add new X550EM SFP+ device ID


 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
Mark Rustad, Network Division, Intel Corporation
