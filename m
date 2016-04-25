From: Aaron Sierra <asierra@xes-inc.com>
Date: Mon, 25 Apr 2016 12:35:48 -0500 (CDT)
Subject: [Intel-wired-lan] issue with kernel patch
 2a3cdead8b408351fa1e3079b220fa331480ffbc
In-Reply-To: <1461600045.21920.10.camel@maxwell>
References: <1461577586.24438.14.camel@maxwell>
 <9BBC4E0CF881AA4299206E2E1412B626501BC575@ORSMSX102.amr.corp.intel.com>
 <9B4A1B1917080E46B64F07F2989DADD65ABFD85F@ORSMSX114.amr.corp.intel.com>
 <1768814989.41697.1461598056358.JavaMail.zimbra@xes-inc.com>
 <1461600045.21920.10.camel@maxwell>
Message-ID: <985237851.71212.1461605748986.JavaMail.zimbra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jochen,

> I wonder if this is related to the modified register read/write
> after the patch.

Possibly. The GS40G functions explicitly set the PHY page with every access. I
suspect that your external I210 PHY was left with some other page selected (by
your BIOS?). Try adding the following debug to your driver to see which page is
selected:

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet
index a23aa67..5cd9e91 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -226,6 +226,7 @@ static s32 igb_init_phy_params_82575(struct e1000_hw *hw)
                phy->ops.read_reg = igb_read_phy_reg_sgmii_82575;
                phy->ops.write_reg = igb_write_phy_reg_sgmii_82575;
        } else {
+               u16 page;
                switch (hw->mac.type) {
                case e1000_82580:
                case e1000_i350:
@@ -234,6 +235,8 @@ static s32 igb_init_phy_params_82575(struct e1000_hw *hw)
                case e1000_i211:
                        phy->ops.read_reg = igb_read_phy_reg_82580;
                        phy->ops.write_reg = igb_write_phy_reg_82580;
+                       phy->ops.read_reg(hw, I347AT4_PAGE_SELECT, &page);
+                       pr_info("%s: default page: %x\n", __func__, page);
                        break;
                default:
                        phy->ops.read_reg = igb_read_phy_reg_igp;
@@ -251,6 +254,7 @@ static s32 igb_init_phy_params_82575(struct e1000_hw *hw)
                return ret_val;
 
        /* Verify phy id and set remaining function pointers */
+       pr_info("%s: PHY ID: %x\n", __func__, phy->id);
        switch (phy->id) {
        case M88E1543_E_PHY_ID:
        case M88E1512_E_PHY_ID:

This is the output that I get from an external I210 device attached to a
Bay Trail SoC:

igb 0000:02:00.0: added PHC on eth0
igb 0000:02:00.0: Intel(R) Gigabit Ethernet Network Connection
igb 0000:02:00.0: eth0: (PCIe:2.5Gb/s:Width x1) 00:17:3c:02:88:56
igb 0000:02:00.0: eth0: PBA No: FFFFFF-0FF
igb 0000:02:00.0: Using MSI-X interrupts. 2 rx queue(s), 2 tx queue(s)
igb: igb_init_phy_params_82575: default page: 0
igb: igb_init_phy_params_82575: PHY ID: 1410c00

-Aaron
