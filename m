From: Andrew Melnychenko <andrew@daynix.com>
Date: Thu,  3 Dec 2020 15:25:15 +0200
Subject: [Intel-wired-lan] [PATCH v4 0/2] hw/virtio-pci: AER capability
Message-ID: <20201203132517.220811-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Main motivation:
According to Microsoft driver\device certification requirements
for next version of Window Server, PCIe device must support AER.
"Windows Server PCI Express devices are required to support
Advanced Error Reporting [AER] as defined in
PCI Express Base Specification version 2.1."

AER capability for virtio-pci is disabled by default.
AER capability is only for PCI with PCIe interface on PCIe bus.
During migration - device "realize" should initialize AER
if requested by device properties.
Fixed commit message.

Andrew (2):
  hw/virtio-pci Added counter for pcie capabilities offsets.
  hw/virtio-pci Added AER capability.

 hw/virtio/virtio-pci.c | 20 +++++++++++++++++++-
 hw/virtio/virtio-pci.h |  4 ++++
 2 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.29.2

