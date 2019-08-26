From: Alice Michael <alice.michael@intel.com>
Date: Mon, 26 Aug 2019 11:16:54 -0700
Subject: [Intel-wired-lan] [next PATCH S9 6/7] i40e: Fix message for other
 card without FEC.
In-Reply-To: <20190826181655.15106-1-alice.michael@intel.com>
References: <20190826181655.15106-1-alice.michael@intel.com>
Message-ID: <20190826181655.15106-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Czeslaw Zagorski <czeslawx.zagorski@intel.com>

When variable "req_fec, fec, an" are empty,
dmesg shows log with "Requested FEC: , Negotiated FEC: , Autoneg:".
Add link dmesg log for cards without FEC.

Signed-off-by: Czeslaw Zagorski <czeslawx.zagorski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 161663de09ef..5fed47cc8da3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6589,11 +6589,15 @@ void i40e_print_link_message(struct i40e_vsi *vsi, bool isup)
 			else
 				req_fec = "CL74 FC-FEC/BASE-R";
 		}
+		netdev_info(vsi->netdev,
+			    "NIC Link is Up, %sbps Full Duplex, Requested FEC: %s, Negotiated FEC: %s, Autoneg: %s, Flow Control: %s\n",
+			    speed, req_fec, fec, an, fc);
+	} else {
+		netdev_info(vsi->netdev,
+			    "NIC Link is Up, %sbps Full Duplex, Flow Control: %s\n",
+			    speed, fc);
 	}
 
-	netdev_info(vsi->netdev,
-		    "NIC Link is Up, %sbps Full Duplex, Requested FEC: %s, Negotiated FEC: %s, Autoneg: %s, Flow Control: %s\n",
-		    speed, req_fec, fec, an, fc);
 }
 
 /**
-- 
2.21.0

