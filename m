From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  4 Jun 2021 09:53:34 -0700
Subject: [Intel-wired-lan] [PATCH net-next 14/15] iavf: return errno code
 instead of status code
In-Reply-To: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
References: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
Message-ID: <20210604165335.33329-14-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The iavf_parse_cls_flower function returns an integer error code, and
not an iavf_status enumeration.

Fix the function to use the standard errno value EINVAL as its return
instead of using IAVF_ERR_CONFIG.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 892aa22b39da..7730de0ef236 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2845,7 +2845,7 @@ static int iavf_parse_cls_flower(struct iavf_adapter *adapter,
 			} else {
 				dev_err(&adapter->pdev->dev, "Bad ether dest mask %pM\n",
 					match.mask->dst);
-				return IAVF_ERR_CONFIG;
+				return -EINVAL;
 			}
 		}
 
@@ -2855,7 +2855,7 @@ static int iavf_parse_cls_flower(struct iavf_adapter *adapter,
 			} else {
 				dev_err(&adapter->pdev->dev, "Bad ether src mask %pM\n",
 					match.mask->src);
-				return IAVF_ERR_CONFIG;
+				return -EINVAL;
 			}
 		}
 
@@ -2890,7 +2890,7 @@ static int iavf_parse_cls_flower(struct iavf_adapter *adapter,
 			} else {
 				dev_err(&adapter->pdev->dev, "Bad vlan mask %u\n",
 					match.mask->vlan_id);
-				return IAVF_ERR_CONFIG;
+				return -EINVAL;
 			}
 		}
 		vf->mask.tcp_spec.vlan_id |= cpu_to_be16(0xffff);
@@ -2914,7 +2914,7 @@ static int iavf_parse_cls_flower(struct iavf_adapter *adapter,
 			} else {
 				dev_err(&adapter->pdev->dev, "Bad ip dst mask 0x%08x\n",
 					be32_to_cpu(match.mask->dst));
-				return IAVF_ERR_CONFIG;
+				return -EINVAL;
 			}
 		}
 
@@ -2924,13 +2924,13 @@ static int iavf_parse_cls_flower(struct iavf_adapter *adapter,
 			} else {
 				dev_err(&adapter->pdev->dev, "Bad ip src mask 0x%08x\n",
 					be32_to_cpu(match.mask->dst));
-				return IAVF_ERR_CONFIG;
+				return -EINVAL;
 			}
 		}
 
 		if (field_flags & IAVF_CLOUD_FIELD_TEN_ID) {
 			dev_info(&adapter->pdev->dev, "Tenant id not allowed for ip filter\n");
-			return IAVF_ERR_CONFIG;
+			return -EINVAL;
 		}
 		if (match.key->dst) {
 			vf->mask.tcp_spec.dst_ip[0] |= cpu_to_be32(0xffffffff);
@@ -2951,7 +2951,7 @@ static int iavf_parse_cls_flower(struct iavf_adapter *adapter,
 		if (ipv6_addr_any(&match.mask->dst)) {
 			dev_err(&adapter->pdev->dev, "Bad ipv6 dst mask 0x%02x\n",
 				IPV6_ADDR_ANY);
-			return IAVF_ERR_CONFIG;
+			return -EINVAL;
 		}
 
 		/* src and dest IPv6 address should not be LOOPBACK
@@ -2961,7 +2961,7 @@ static int iavf_parse_cls_flower(struct iavf_adapter *adapter,
 		    ipv6_addr_loopback(&match.key->src)) {
 			dev_err(&adapter->pdev->dev,
 				"ipv6 addr should not be loopback\n");
-			return IAVF_ERR_CONFIG;
+			return -EINVAL;
 		}
 		if (!ipv6_addr_any(&match.mask->dst) ||
 		    !ipv6_addr_any(&match.mask->src))
@@ -2986,7 +2986,7 @@ static int iavf_parse_cls_flower(struct iavf_adapter *adapter,
 			} else {
 				dev_err(&adapter->pdev->dev, "Bad src port mask %u\n",
 					be16_to_cpu(match.mask->src));
-				return IAVF_ERR_CONFIG;
+				return -EINVAL;
 			}
 		}
 
@@ -2996,7 +2996,7 @@ static int iavf_parse_cls_flower(struct iavf_adapter *adapter,
 			} else {
 				dev_err(&adapter->pdev->dev, "Bad dst port mask %u\n",
 					be16_to_cpu(match.mask->dst));
-				return IAVF_ERR_CONFIG;
+				return -EINVAL;
 			}
 		}
 		if (match.key->dst) {
-- 
2.20.1

