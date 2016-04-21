From: Preethi Banala <preethi.banala@intel.com>
Date: Thu, 21 Apr 2016 11:28:41 -0700
Subject: [Intel-wired-lan] [PATCH 0/3] Update ethtool utility
Message-ID: <20160421182545.13330.59497.stgit@ixgbe-dev.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Made changes in ethtool register dump functionaly to support latest
Intel 10G drivers and also addressed few inconsistencies found in the
existing code

Signed-off-by: Preethi Banala <preethi.banala@intel.com>
---

Preethi Banala (3):
      ethtool/ixgbe: Add device ID and mac_type definitions
      ethtool/ixgbe: Correct offsets and support x550, x550em_x, x550em_a
      ethtool/ixgbe: Reduce format string storage


 ixgbe.c |  173 +++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 95 insertions(+), 78 deletions(-)

--
