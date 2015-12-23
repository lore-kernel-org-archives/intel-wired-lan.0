From: Daniel J Blueman <daniel@numascale.com>
Date: Wed, 23 Dec 2015 18:01:40 +0800
Subject: [Intel-wired-lan] [PATCH 1/2] PCI: Add mechanism to find
	topologically near cores
Message-ID: <1450864901-16712-1-git-send-email-daniel@numascale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Some devices (eg ixgbe) make assumptions about device to core locality when
specifying interrupts locality hints and allocate starting from core 0.
Moreover, interrupts may not be routable to distant NUMA nodes due to the
8-bit APIC ID space limitations.

Provide a mechanism drivers can use to find cores with reasonable locality
to a device; use the existing precendent of RECLAIM_DISTANCE (30), wrapping
the offset.

Signed-off-by: Daniel J Blueman <daniel@numascale.com>
---
 drivers/pci/pci.c   | 15 +++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 314db8c..d5535d1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4833,6 +4833,22 @@ void __weak pci_fixup_cardbus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_fixup_cardbus);

+int cpu_near_dev(const struct pci_dev *pdev, unsigned offset)
+{
+	/* Start search from node device is on for optimal locality */
+	int localnode = pcibus_to_node(pdev->bus);
+	int cpu = cpumask_first(cpumask_of_node(localnode));
+
+	while (offset--) {
+		do {
+			cpu = (cpu + 1) % nr_cpu_ids;
+		} while (!cpu_online(cpu) || node_distance(cpu_to_node(cpu),
+			localnode) > RECLAIM_DISTANCE);
+	}
+
+	return cpu;
+}
+
 static int __init pci_setup(char *str)
 {
 	while (str) {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6ae25aa..f7491bd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -842,6 +842,7 @@ void pci_stop_root_bus(struct pci_bus *bus);
 void pci_remove_root_bus(struct pci_bus *bus);
 void pci_setup_cardbus(struct pci_bus *bus);
 void pci_sort_breadthfirst(void);
+int cpu_near_dev(const struct pci_dev *pdev, unsigned offset);
 #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
 #define dev_is_pf(d) ((dev_is_pci(d) ? to_pci_dev(d)->is_physfn : false))
 #define dev_num_vf(d) ((dev_is_pci(d) ? pci_num_vf(to_pci_dev(d)) : 0))
--
2.5.0

