From: Andre Guedes <andre.guedes@intel.com>
Date: Tue,  7 Jul 2020 16:47:59 -0700
Subject: [Intel-wired-lan] [PATCH ethtool 3/4] igc: Parse VLANPQF register
 fields
In-Reply-To: <20200707234800.39119-1-andre.guedes@intel.com>
References: <20200707234800.39119-1-andre.guedes@intel.com>
Message-ID: <20200707234800.39119-4-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds support for parsing the VLAN Priority Queue Filter
(VLANPQF) register fields.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 igc.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/igc.c b/igc.c
index df3916c..6a2e06d 100644
--- a/igc.c
+++ b/igc.c
@@ -35,8 +35,39 @@
 #define RCTL_DPF				0x00400000
 #define RCTL_PMCF				0x00800000
 #define RCTL_SECRC				0x04000000
+#define VLANPQF_VP0QSEL				0x00000003
+#define VLANPQF_VP0PBSEL			0x00000004
+#define VLANPQF_VLANP0V				0x00000008
+#define VLANPQF_VP1QSEL				0x00000030
+#define VLANPQF_VP1PBSEL			0x00000040
+#define VLANPQF_VLANP1V				0x00000080
+#define VLANPQF_VP2QSEL				0x00000300
+#define VLANPQF_VP2PBSEL			0x00000400
+#define VLANPQF_VLANP2V				0x00000800
+#define VLANPQF_VP3QSEL				0x00003000
+#define VLANPQF_VP3PBSEL			0x00004000
+#define VLANPQF_VLANP3V				0x00008000
+#define VLANPQF_VP4QSEL				0x00030000
+#define VLANPQF_VP4PBSEL			0x00040000
+#define VLANPQF_VLANP4V				0x00080000
+#define VLANPQF_VP5QSEL				0x00300000
+#define VLANPQF_VP5PBSEL			0x00400000
+#define VLANPQF_VLANP5V				0x00800000
+#define VLANPQF_VP6QSEL				0x03000000
+#define VLANPQF_VP6PBSEL			0x04000000
+#define VLANPQF_VLANP6V				0x08000000
+#define VLANPQF_VP7QSEL				0x30000000
+#define VLANPQF_VP7PBSEL			0x40000000
+#define VLANPQF_VLANP7V				0x80000000
 
 #define RAH_QSEL_SHIFT				18
+#define VLANPQF_VP1QSEL_SHIFT			4
+#define VLANPQF_VP2QSEL_SHIFT			8
+#define VLANPQF_VP3QSEL_SHIFT			12
+#define VLANPQF_VP4QSEL_SHIFT			16
+#define VLANPQF_VP5QSEL_SHIFT			20
+#define VLANPQF_VP6QSEL_SHIFT			24
+#define VLANPQF_VP7QSEL_SHIFT			28
 
 static const char *bit_to_boolean(u32 val)
 {
@@ -48,6 +79,11 @@ static const char *bit_to_enable(u32 val)
 	return val ? "Enabled" : "Disabled";
 }
 
+static const char *bit_to_prio(u32 val)
+{
+	return val ? "Low" : "High";
+}
+
 int igc_dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs)
 {
 	u32 reg;
@@ -147,5 +183,67 @@ int igc_dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs)
 		       bit_to_boolean(reg & RAH_AV));
 	}
 
+	offset = 204;
+
+	reg = regs_buff[offset];
+	printf("%04d: VLANPQF (VLAN Priority Queue Filter)       \n"
+	       "    Priority 0                                   \n"
+	       "        Queue:                                 %d\n"
+	       "        Packet Buffer:                         %s\n"
+	       "        Valid:                                 %s\n"
+	       "    Priority 1                                   \n"
+	       "        Queue:                                 %d\n"
+	       "        Packet Buffer:                         %s\n"
+	       "        Valid:                                 %s\n"
+	       "    Priority 2                                   \n"
+	       "        Queue:                                 %d\n"
+	       "        Packet Buffer:                         %s\n"
+	       "        Valid:                                 %s\n"
+	       "    Priority 3                                   \n"
+	       "        Queue:                                 %d\n"
+	       "        Packet Buffer:                         %s\n"
+	       "        Valid:                                 %s\n"
+	       "    Priority 4                                   \n"
+	       "        Queue:                                 %d\n"
+	       "        Packet Buffer:                         %s\n"
+	       "        Valid:                                 %s\n"
+	       "    Priority 5                                   \n"
+	       "        Queue:                                 %d\n"
+	       "        Packet Buffer:                         %s\n"
+	       "        Valid:                                 %s\n"
+	       "    Priority 6                                   \n"
+	       "        Queue:                                 %d\n"
+	       "        Packet Buffer:                         %s\n"
+	       "        Valid:                                 %s\n"
+	       "    Priority 7                                   \n"
+	       "        Queue:                                 %d\n"
+	       "        Packet Buffer:                         %s\n"
+	       "        Valid:                                 %s\n",
+	       offset,
+	       reg & VLANPQF_VP0QSEL,
+	       bit_to_prio(reg & VLANPQF_VP0PBSEL),
+	       bit_to_boolean(reg & VLANPQF_VLANP0V),
+	       (reg & VLANPQF_VP1QSEL) >> VLANPQF_VP1QSEL_SHIFT,
+	       bit_to_prio(reg & VLANPQF_VP1PBSEL),
+	       bit_to_boolean(reg & VLANPQF_VLANP1V),
+	       (reg & VLANPQF_VP2QSEL) >> VLANPQF_VP2QSEL_SHIFT,
+	       bit_to_prio(reg & VLANPQF_VP2PBSEL),
+	       bit_to_boolean(reg & VLANPQF_VLANP2V),
+	       (reg & VLANPQF_VP3QSEL) >> VLANPQF_VP3QSEL_SHIFT,
+	       bit_to_prio(reg & VLANPQF_VP3PBSEL),
+	       bit_to_boolean(reg & VLANPQF_VLANP3V),
+	       (reg & VLANPQF_VP4QSEL) >> VLANPQF_VP4QSEL_SHIFT,
+	       bit_to_prio(reg & VLANPQF_VP4PBSEL),
+	       bit_to_boolean(reg & VLANPQF_VLANP4V),
+	       (reg & VLANPQF_VP5QSEL) >> VLANPQF_VP5QSEL_SHIFT,
+	       bit_to_prio(reg & VLANPQF_VP5PBSEL),
+	       bit_to_boolean(reg & VLANPQF_VLANP5V),
+	       (reg & VLANPQF_VP6QSEL) >> VLANPQF_VP6QSEL_SHIFT,
+	       bit_to_prio(reg & VLANPQF_VP6PBSEL),
+	       bit_to_boolean(reg & VLANPQF_VLANP6V),
+	       (reg & VLANPQF_VP7QSEL) >> VLANPQF_VP7QSEL_SHIFT,
+	       bit_to_prio(reg & VLANPQF_VP7PBSEL),
+	       bit_to_boolean(reg & VLANPQF_VLANP7V));
+
 	return 0;
 }
-- 
2.26.2

