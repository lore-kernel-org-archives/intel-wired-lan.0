From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue,  2 Mar 2021 10:12:08 -0800
Subject: [Intel-wired-lan] [PATCH S55 09/14] ice: remove unnecessary
 duplicated AQ command flag setting
In-Reply-To: <20210302181213.51718-1-anthony.l.nguyen@intel.com>
References: <20210302181213.51718-1-anthony.l.nguyen@intel.com>
Message-ID: <20210302181213.51718-9-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Commit a012dca9f7a2 ("ice: add ethtool -m support for reading i2c eeprom
modules") unnecessarily added the ICE_AQ_FLAG_BUF flag to the descriptor
when sending the indirect Read/Write SFF EEPROM AQ command. The flag is
already added later in the code flow for all indirect AQ commands, i.e.
commands that provide an additional data buffer.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index a20edf1538a0..105504c8cfe7 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -3186,7 +3186,7 @@ ice_aq_sff_eeprom(struct ice_hw *hw, u16 lport, u8 bus_addr,
 
 	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_sff_eeprom);
 	cmd = &desc.params.read_write_sff_param;
-	desc.flags = cpu_to_le16(ICE_AQ_FLAG_RD | ICE_AQ_FLAG_BUF);
+	desc.flags = cpu_to_le16(ICE_AQ_FLAG_RD);
 	cmd->lport_num = (u8)(lport & 0xff);
 	cmd->lport_num_valid = (u8)((lport >> 8) & 0x01);
 	cmd->i2c_bus_addr = cpu_to_le16(((bus_addr >> 1) &
-- 
2.20.1

