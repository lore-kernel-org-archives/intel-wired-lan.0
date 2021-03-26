From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 25 Mar 2021 17:38:25 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 02/11] intel: remove checker
 warning
In-Reply-To: <20210326003834.3886241-1-jesse.brandeburg@intel.com>
References: <20210326003834.3886241-1-jesse.brandeburg@intel.com>
Message-ID: <20210326003834.3886241-3-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The sparse checker (C=2) found an assignment where we were mixing
types when trying to convert from data read directly from the
device NVM, to an array in CPU order in-memory, which
unfortunately the driver tries to do in-place.

This is easily solved by using the swap operation instead of an
assignment, and is already proven in other Intel drivers to be
functionally correct and the same code, just without a sparse
warning.

The change is the same in all three drivers.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
Warning Detail:
  CHECK   .../e1000/e1000_ethtool.c
.../e1000/e1000_ethtool.c:516:32: warning: incorrect type in assignment (different base types)
.../e1000/e1000_ethtool.c:516:32:    expected unsigned short [usertype]
.../e1000/e1000_ethtool.c:516:32:    got restricted __le16 [usertype]
  CHECK   .../igb/igb_ethtool.c
.../igb/igb_ethtool.c:834:32: warning: incorrect type in assignment (different base types)
.../igb/igb_ethtool.c:834:32:    expected unsigned short [usertype]
.../igb/igb_ethtool.c:834:32:    got restricted __le16 [usertype]
  CHECK   .../igc/igc_ethtool.c
.../igc/igc_ethtool.c:555:32: warning: incorrect type in assignment (different base types)
.../igc/igc_ethtool.c:555:32:    expected unsigned short [usertype]
.../igc/igc_ethtool.c:555:32:    got restricted __le16 [usertype]
---
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c     | 2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index f976e9daa3d8..3c51ee94fa00 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -513,7 +513,7 @@ static int e1000_set_eeprom(struct net_device *netdev,
 	memcpy(ptr, bytes, eeprom->len);
 
 	for (i = 0; i < last_word - first_word + 1; i++)
-		eeprom_buff[i] = cpu_to_le16(eeprom_buff[i]);
+		cpu_to_le16s(&eeprom_buff[i]);
 
 	ret_val = e1000_write_eeprom(hw, first_word,
 				     last_word - first_word + 1, eeprom_buff);
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 7545da216d8b..636a1b1fb7e1 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -831,7 +831,7 @@ static int igb_set_eeprom(struct net_device *netdev,
 	memcpy(ptr, bytes, eeprom->len);
 
 	for (i = 0; i < last_word - first_word + 1; i++)
-		eeprom_buff[i] = cpu_to_le16(eeprom_buff[i]);
+		cpu_to_le16s(&eeprom_buff[i]);
 
 	ret_val = hw->nvm.ops.write(hw, first_word,
 				    last_word - first_word + 1, eeprom_buff);
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 9722449d7633..2cb12431c371 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -554,7 +554,7 @@ static int igc_ethtool_set_eeprom(struct net_device *netdev,
 	memcpy(ptr, bytes, eeprom->len);
 
 	for (i = 0; i < last_word - first_word + 1; i++)
-		eeprom_buff[i] = cpu_to_le16(eeprom_buff[i]);
+		cpu_to_le16s(&eeprom_buff[i]);
 
 	ret_val = hw->nvm.ops.write(hw, first_word,
 				    last_word - first_word + 1, eeprom_buff);
-- 
2.30.2

