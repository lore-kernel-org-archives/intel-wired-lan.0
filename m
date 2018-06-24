From: Jiri Pirko <jiri@resnulli.us>
Date: Sun, 24 Jun 2018 10:38:39 +0200
Subject: [Intel-wired-lan] [patch net-next 3/3] cls_flower: fix error values
 for commands not supported by drivers
In-Reply-To: <20180624083839.1692-1-jiri@resnulli.us>
References: <20180624083839.1692-1-jiri@resnulli.us>
Message-ID: <20180624083839.1692-4-jiri@resnulli.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jiri Pirko <jiri@mellanox.com>

-EOPNOTSUPP is the error value that should be reported if a flower
command is not supported by a driver. Fix it in couple of Intel drivers.

Signed-off-by: Jiri Pirko <jiri@mellanox.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 2 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
 drivers/net/ethernet/intel/igb/igb_main.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 95e9dfbe9839..7ad2b1b0b125 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7522,7 +7522,7 @@ static int i40e_setup_tc_cls_flower(struct i40e_netdev_priv *np,
 	case TC_CLSFLOWER_STATS:
 		return -EOPNOTSUPP;
 	default:
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index a7b87f935411..dc56a8667495 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2884,7 +2884,7 @@ static int i40evf_setup_tc_cls_flower(struct i40evf_adapter *adapter,
 	case TC_CLSFLOWER_STATS:
 		return -EOPNOTSUPP;
 	default:
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index f707709969ac..6a78d8272eb2 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2698,7 +2698,7 @@ static int igb_setup_tc_cls_flower(struct igb_adapter *adapter,
 	case TC_CLSFLOWER_STATS:
 		return -EOPNOTSUPP;
 	default:
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 }
 
-- 
2.14.4

