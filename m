From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 10 Oct 2018 12:16:01 -0700
Subject: [Intel-wired-lan] [PATCH v2 00/12] Intel Wired LAN Documentation
 Updates
Message-ID: <20181010191613.2770-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

So I am resurrecting my previous kernel documentation update series of
patches.  I finally grouped all the updates into a single series.

This series updates or adds missing kernel documentation on our Intel
wired LAN drivers.  In addition, I converted the documentation to the
reStructured Text (RST) format which is used in the Linux kernel
documentation builds.


Jeff Kirsher (12):
  Documentation: e100, e1000: Add missing SPDX header
  Documentation: ixgb: Prepare documentation for RST conversion
  Documentation: e1000e: Prepare documentation for RST conversion
  Documentation: igb: Prepare documentation for RST conversion
  Documentation: igbvf: Prepare documentation for RST conversion
  Documentation: ixgbe: Prepare documentation for RST conversion
  Documentation: ixgbevf: Prepare documentation for RST conversion
  Documentation: i40e: Prepare documentation for RST conversion
  Documentation: iavf: Prepare documentation for RST conversion
  Documentation: ice: Prepare documentation for RST conversion
  Documentation: fm10k: Add kernel documentation
  Documentation: intel: Convert to RST format

 Documentation/networking/00-INDEX    |  20 -
 Documentation/networking/e100.rst    |   3 +-
 Documentation/networking/e1000.rst   |   3 +-
 Documentation/networking/e1000e.rst  | 382 +++++++++++++
 Documentation/networking/e1000e.txt  | 312 -----------
 Documentation/networking/fm10k.rst   | 141 +++++
 Documentation/networking/i40e.rst    | 781 +++++++++++++++++++++++++++
 Documentation/networking/i40e.txt    | 190 -------
 Documentation/networking/iavf.rst    | 281 ++++++++++
 Documentation/networking/iavf.txt    |  56 --
 Documentation/networking/ice.rst     |  45 ++
 Documentation/networking/ice.txt     |  39 --
 Documentation/networking/igb.rst     | 193 +++++++
 Documentation/networking/igb.txt     | 129 -----
 Documentation/networking/igbvf.rst   |  64 +++
 Documentation/networking/igbvf.txt   |  80 ---
 Documentation/networking/index.rst   |  10 +
 Documentation/networking/ixgb.rst    | 467 ++++++++++++++++
 Documentation/networking/ixgb.txt    | 432 ---------------
 Documentation/networking/ixgbe.rst   | 527 ++++++++++++++++++
 Documentation/networking/ixgbe.txt   | 349 ------------
 Documentation/networking/ixgbevf.rst |  66 +++
 Documentation/networking/ixgbevf.txt |  52 --
 MAINTAINERS                          |  19 +-
 drivers/net/ethernet/intel/Kconfig   |  26 +-
 25 files changed, 2993 insertions(+), 1674 deletions(-)
 create mode 100644 Documentation/networking/e1000e.rst
 delete mode 100644 Documentation/networking/e1000e.txt
 create mode 100644 Documentation/networking/fm10k.rst
 create mode 100644 Documentation/networking/i40e.rst
 delete mode 100644 Documentation/networking/i40e.txt
 create mode 100644 Documentation/networking/iavf.rst
 delete mode 100644 Documentation/networking/iavf.txt
 create mode 100644 Documentation/networking/ice.rst
 delete mode 100644 Documentation/networking/ice.txt
 create mode 100644 Documentation/networking/igb.rst
 delete mode 100644 Documentation/networking/igb.txt
 create mode 100644 Documentation/networking/igbvf.rst
 delete mode 100644 Documentation/networking/igbvf.txt
 create mode 100644 Documentation/networking/ixgb.rst
 delete mode 100644 Documentation/networking/ixgb.txt
 create mode 100644 Documentation/networking/ixgbe.rst
 delete mode 100644 Documentation/networking/ixgbe.txt
 create mode 100644 Documentation/networking/ixgbevf.rst
 delete mode 100644 Documentation/networking/ixgbevf.txt

-- 
2.17.1

