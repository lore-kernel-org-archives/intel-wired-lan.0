From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Sun, 16 May 2021 12:18:17 +0200
Subject: [Intel-wired-lan] [PATCH v3 00/16] Replace some bad characters on
 documents
Message-ID: <cover.1621159997.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The conversion tools used during DocBook/LaTeX/html/Markdown->ReST 
conversion and some cut-and-pasted text contain some characters that
aren't easily reachable on standard keyboards and/or could cause 
troubles when parsed by the documentation build system.

Replace the occurences of the following characters:

            - U+00a0 ('?'): NO-BREAK SPACE
            - U+00ad ('?'): SOFT HYPHEN
            - U+2010 ('?'): HYPHEN
            - U+2217 ('?'): ASTERISK OPERATOR
            - U+feff ('?'): BOM

I'll submit in separate another series to address other character occurrences.

v3:
  - removed curly commas and changed the patch descriptions.
v2:
  - removed EM/EN dashes and changed the patch descriptions.


Mauro Carvalho Chehab (16):
  docs: hwmon: ir36021.rst: replace some characters
  docs: admin-guide: reporting-issues.rst: replace some characters
  docs: trace: coresight: coresight-etm4x-reference.rst: replace some
    characters
  docs: driver-api: ioctl.rst: replace some characters
  docs: driver-api: media: drivers: zoran.rst: replace some characters
  docs: usb: replace some characters
  docs: userspace-api: media: v4l: dev-decoder.rst: replace some
    characters
  docs: userspace-api: media: dvb: intro.rst: replace some characters
  docs: vm: zswap.rst: replace some characters
  docs: filesystems: ext4: blockgroup.rst: replace some characters
  docs: networking: device_drivers: replace some characters
  docs: PCI: acpi-info.rst: replace some characters
  docs: sound: kernel-api: writing-an-alsa-driver.rst: replace some
    characters
  docs: firmware-guide: acpi: dsd: graph.rst: replace some characters
  docs: virt: kvm: api.rst: replace some characters
  docs: RCU: replace some characters

 Documentation/PCI/acpi-info.rst               | 18 ++---
 .../Data-Structures/Data-Structures.rst       | 46 ++++++------
 .../Expedited-Grace-Periods.rst               | 36 +++++-----
 .../Tree-RCU-Memory-Ordering.rst              |  2 +-
 .../RCU/Design/Requirements/Requirements.rst  | 70 +++++++++----------
 .../admin-guide/reporting-issues.rst          |  2 +-
 Documentation/driver-api/ioctl.rst            |  8 +--
 .../driver-api/media/drivers/zoran.rst        |  2 +-
 Documentation/filesystems/ext4/blockgroup.rst |  2 +-
 .../firmware-guide/acpi/dsd/graph.rst         |  2 +-
 Documentation/hwmon/ir36021.rst               |  2 +-
 .../device_drivers/ethernet/intel/i40e.rst    |  6 +-
 .../device_drivers/ethernet/intel/iavf.rst    |  2 +-
 .../kernel-api/writing-an-alsa-driver.rst     |  2 +-
 .../coresight/coresight-etm4x-reference.rst   |  2 +-
 Documentation/usb/ehci.rst                    |  2 +-
 Documentation/usb/gadget_printer.rst          |  2 +-
 .../userspace-api/media/dvb/intro.rst         |  4 +-
 .../userspace-api/media/v4l/dev-decoder.rst   |  2 +-
 Documentation/virt/kvm/api.rst                | 28 ++++----
 Documentation/vm/zswap.rst                    |  4 +-
 21 files changed, 122 insertions(+), 122 deletions(-)

-- 
2.31.1


