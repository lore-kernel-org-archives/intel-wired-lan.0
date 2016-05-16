From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 16 May 2016 10:26:36 -0700
Subject: [Intel-wired-lan] [next PATCH S37 06/15] i40evf: don't overflow
	buffer
In-Reply-To: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1463419605-30746-7-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

If the user adds an obscene amount of MAC addresses, the driver will run
into the situation where it has too many address requests to fit into a
single PF message. The driver checks for this case, and calculates the
maximum number of messages that it can send. Then it completely ignores
this count and overflows the buffer.

Fix this by checking the address count and bailing out of the loop at
the appropriate time.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: If8dcbb04602c75941dc0cd8309065e1de9ca791c
---
Testing Hints : Add a thousand filters as quickly as possible.

 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index f134456..d76c221 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -434,6 +434,8 @@ void i40evf_add_ether_addrs(struct i40evf_adapter *adapter)
 			ether_addr_copy(veal->list[i].addr, f->macaddr);
 			i++;
 			f->add = false;
+			if (i == count)
+				break;
 		}
 	}
 	if (!more)
@@ -497,6 +499,8 @@ void i40evf_del_ether_addrs(struct i40evf_adapter *adapter)
 			i++;
 			list_del(&f->list);
 			kfree(f);
+			if (i == count)
+				break;
 		}
 	}
 	if (!more)
@@ -560,6 +564,8 @@ void i40evf_add_vlans(struct i40evf_adapter *adapter)
 			vvfl->vlan_id[i] = f->vlan;
 			i++;
 			f->add = false;
+			if (i == count)
+				break;
 		}
 	}
 	if (!more)
@@ -623,6 +629,8 @@ void i40evf_del_vlans(struct i40evf_adapter *adapter)
 			i++;
 			list_del(&f->list);
 			kfree(f);
+			if (i == count)
+				break;
 		}
 	}
 	if (!more)
-- 
2.4.11

