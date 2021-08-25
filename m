From: Barry Song <21cnbao@gmail.com>
Date: Wed, 25 Aug 2021 18:26:34 +0800
Subject: [Intel-wired-lan] [PATCH v3 1/3] Documentation: ABI: sysfs-bus-pci:
 Add description for IRQ entry
In-Reply-To: <20210825102636.52757-1-21cnbao@gmail.com>
References: <20210825102636.52757-1-21cnbao@gmail.com>
Message-ID: <20210825102636.52757-2-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Barry Song <song.bao.hua@hisilicon.com>

/sys/bus/pci/devices/.../irq has been there for many years but it
has never been documented. This patch is trying to document it as
what it is really implemented in the kernel code.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 793cbb7..eeacdce 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -96,6 +96,16 @@ Description:
 		This attribute indicates the mode that the irq vector named by
 		the file is in (msi vs. msix)
 
+What:		/sys/bus/pci/devices/.../irq
+Date:		August 2021
+Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
+Description:
+		If a driver has enabled MSI (not MSI-X), "irq" contains the IRQ
+		of the first MSI vector. Otherwise "irq" contains the IRQ of
+		the legacy INTx interrupt.
+		"irq" being set to 0 indicates that the device isn't capable of
+		generating legacy INTx interrupts.
+
 What:		/sys/bus/pci/devices/.../remove
 Date:		January 2009
 Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
-- 
1.8.3.1

