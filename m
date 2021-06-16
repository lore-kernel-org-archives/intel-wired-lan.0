From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Wed, 16 Jun 2021 08:55:06 +0200
Subject: [Intel-wired-lan] [PATCH 0/8] Replace some bad characters on
 documents
Message-ID: <cover.1623826294.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jon,

This series contain the remaining 8 patches I submitted at v3 that
weren't merged yet at -next.

This series is rebased on the top of your docs-next branch.

No changes here, except by some Reviewed/ack lines, and at the
name of the final patch (per PCI maintainer's request).

Mauro Carvalho Chehab (8):
  docs: admin-guide: reporting-issues.rst: replace some characters
  docs: trace: coresight: coresight-etm4x-reference.rst: replace some
    characters
  docs: driver-api: ioctl.rst: replace some characters
  docs: usb: replace some characters
  docs: vm: zswap.rst: replace some characters
  docs: filesystems: ext4: blockgroup.rst: replace some characters
  docs: networking: device_drivers: replace some characters
  docs: PCI: Replace non-breaking spaces to avoid PDF issues

 Documentation/PCI/acpi-info.rst                | 18 +++++++++---------
 Documentation/admin-guide/reporting-issues.rst |  2 +-
 Documentation/driver-api/ioctl.rst             |  8 ++++----
 Documentation/filesystems/ext4/blockgroup.rst  |  2 +-
 .../device_drivers/ethernet/intel/i40e.rst     |  6 +++---
 .../device_drivers/ethernet/intel/iavf.rst     |  2 +-
 .../coresight/coresight-etm4x-reference.rst    |  2 +-
 Documentation/usb/ehci.rst                     |  2 +-
 Documentation/usb/gadget_printer.rst           |  2 +-
 Documentation/vm/zswap.rst                     |  4 ++--
 10 files changed, 24 insertions(+), 24 deletions(-)

-- 
2.31.1


