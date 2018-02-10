From: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
Date: Sat, 10 Feb 2018 02:00:39 -0200
Subject: [Intel-wired-lan] [PATCH] i40e: Fix bad state due to failed dcbx
 autonegotiation
Message-ID: <1518235239-16757-1-git-send-email-maurosr@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When connected to a dcbx capable switch, during the earlier link
negotiations, a device can be left in a bad state which compromises the
probe process of all interfaces:

[   11.404108] i40e 0002:01:00.0: capability discovery failed, err OK
aq_err I40E_AQ_RC_EMODE

The message above tell us that something failed during the capability
discovery process, the error I40E_AQ_RC_EMODE (21) means the device is
in a mode that such operation is not allowed, according to the
datasheet. Digging some more in the source code it's possible to check
that it fails during the I40E_PRTGEN_CNF read using
i40e_aq_debug_read_register within i40e_parse_discover_capabilities,
which, again according to the datasheet, was not supposed to return
that.

I also verified that any attempt to read a register, I40E_GL_FWSTS for
instance, fails as well.

Disabling the dcbx capability or setting it to dcbx-1.01, OUI=  ,
instead of autonegotiation or ieee-dcbx, OUI= , mitgates the issue.

Another evidence of the device getting into a bad state is tcpdump
capture during the autonegotiation. It's possible to see the switch
sharing its dcbx settings with willing bit=0. The device then answers
with willing=1 to learn the dcbx configuration:
"        1... .... = Willing: Yes"

After that there is no other communication coming from the NIC, that
make me to believe the device entered the bad state when trying to
replicate switch dcbx's settings.

From a device driver standpoint it's possible to recover from the bad
state by issuing a Global Reset and ask PCI subsystem to probe the
device again after it, by return -EPROBE_DEFER, we will see the
following messages with this patch:

[  400.178850] i40e 0002:01:00.0: Using 64-bit DMA iommu bypass
[  404.179406] i40e 0002:01:00.0: fw 5.1.40981 api 1.5 nvm 5.03
0x80002469 1.1313.0
[  404.420382] i40e 0002:01:00.0: capability discovery failed, err OK
aq_err I40E_AQ_RC_EMODE
[  404.420473] i40e 0002:01:00.0: Probe failed due to unexpected
device state, trying to fix it by resetting the device.

Since the reset was done the other ports will probe just fine,

[  404.420610] i40e 0002:01:00.1: Using 64-bit DMA iommu bypass
[  407.659108] i40e 0002:01:00.1: fw 5.1.40981 api 1.5 nvm 5.03
0x80002469 1.1313.0
[  407.900214] i40e 0002:01:00.1: MAC address: 0c:c4:7a:b7:ff:d9
[  407.908532] i40e 0002:01:00.1 enP2p1s0f1: renamed from eth0
[  407.909071] i40e 0002:01:00.1: PCI-Express: Speed 8.0GT/s Width x8
[  407.909630] i40e 0002:01:00.1: Features: PF-id[1] VFs: 32 VSIs: 34
QP: 20 RSS FD_ATR FD_SB NTUPLE DCB VxLAN Geneve PTP VEPA

then the first port will be re-probed later.

[  408.203217] i40e 0002:01:00.0: fw 5.1.40981 api 1.5 nvm 5.03
0x80002469 1.1313.0
[  408.447187] i40e 0002:01:00.0: MAC address: 0c:c4:7a:b7:ff:d8
[  408.699988] i40e 0002:01:00.0 enP2p1s0f0: renamed from eth0
[  408.702453] i40e 0002:01:00.0: PCI-Express: Speed 8.0GT/s Width x8
[  408.703011] i40e 0002:01:00.0: Features: PF-id[0] VFs: 32 VSIs: 34
QP: 20 RSS FD_ATR FD_SB NTUPLE DCB VxLAN Geneve PTP VEPA

Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>

Conflicts:
	drivers/net/ethernet/intel/i40e/i40e_main.c
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e31adbc..c41bb0e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13513,8 +13513,18 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	i40e_clear_pxe_mode(hw);
 	err = i40e_get_capabilities(pf, i40e_aqc_opc_list_func_capabilities);
-	if (err)
+	if (err) {
+		if (hw->aq.asq_last_status == I40E_AQ_RC_EMODE) {
+			dev_warn(&pdev->dev, "Probe failed due to unexpected device state, trying to fix it by resetting the device.\n");
+			i40e_do_reset(pf, BIT(__I40E_GLOBAL_RESET_REQUESTED),
+				      false);
+			/* In this situation we reset and ask for re-probe
+			 * later.
+			 */
+			err = -EPROBE_DEFER;
+		}
 		goto err_adminq_setup;
+	}
 
 	err = i40e_sw_init(pf);
 	if (err) {
-- 
1.8.3.1

