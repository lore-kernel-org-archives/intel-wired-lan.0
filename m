From: Zhu Yanjun <yanjun.zhu@oracle.com>
Date: Wed,  8 Feb 2017 22:03:28 -0500
Subject: [Intel-wired-lan] [PATCH 1/1] ethtool: add the external transceiver
	status of the ixgbe fiber
In-Reply-To: <1486609408-6770-1-git-send-email-yanjun.zhu@oracle.com>
References: <1486609408-6770-1-git-send-email-yanjun.zhu@oracle.com>
Message-ID: <1486609408-6770-2-git-send-email-yanjun.zhu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When the the fiber transceiver of the ixgbe NIC is external, sometimes
it is necessary to get the present/absent status of the fiber transceiver
of the ixgbe NIC.

The steps to get the present/absent status:
The NIC enp1s0f0 is an external ixgbe fiber NIC.

ethtool enp1s0f0

...
        Port: FIBRE
        PHYAD: 0
        Transceiver: external(present) <---The transceiver is present.
        Auto-negotiation: on
        Supports Wake-on: d
...

Or
...
        Port: FIBRE
        PHYAD: 0
        Transceiver: external(absent) <---The transceiver is absent
        Auto-negotiation: on
        Supports Wake-on: d
...
Signed-off-by: Zhu Yanjun <yanjun.zhu@oracle.com>
---
 ethtool-copy.h | 2 ++
 ethtool.c      | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/ethtool-copy.h b/ethtool-copy.h
index 3d299e3..1c6db9a 100644
--- a/ethtool-copy.h
+++ b/ethtool-copy.h
@@ -1536,6 +1536,8 @@ static __inline__ int ethtool_validate_duplex(__u8 duplex)
 #define XCVR_DUMMY1		0x02
 #define XCVR_DUMMY2		0x03
 #define XCVR_DUMMY3		0x04
+#define XCVR_EXTERNAL_ABSENT	0x05
+#define XCVR_EXTERNAL_PRESENT	0x06
 
 /* Enable or disable autonegotiation. */
 #define AUTONEG_DISABLE		0x00
diff --git a/ethtool.c b/ethtool.c
index 7af039e..85cf5a2 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -811,6 +811,12 @@ dump_link_usettings(const struct ethtool_link_usettings *link_usettings)
 	case XCVR_EXTERNAL:
 		fprintf(stdout, "external\n");
 		break;
+	case XCVR_EXTERNAL_PRESENT:
+		fprintf(stdout, "external(present)\n");
+		break;
+	case XCVR_EXTERNAL_ABSENT:
+		fprintf(stdout, "external(absent)\n");
+		break;
 	default:
 		fprintf(stdout, "Unknown!\n");
 		break;
-- 
2.7.4

