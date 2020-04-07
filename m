From: Andre Guedes <andre.guedes@linux.intel.com>
Date: Tue, 07 Apr 2020 15:55:09 -0700
Subject: [Intel-wired-lan] Wrong conflict resolution in dev-queue
Message-ID: <158630010981.24556.16261609938467026439@sabikunn-mobl1.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jeff,

I'm not sure exactly what is the workflow of dev-queue branch, but I believe we
had a wrong conflict resolution.

In current dev-queue, patch "igc: Use netdev log helpers in igc_ethtool.c"
changes some if-statement lines, however the original patch doesn't.

--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1918,14 +1919,14 @@ static void igc_diag_test(struct net_device *netdev,
                else
                        igc_reset(adapter);

-               netdev_info(adapter->netdev, "register testing starting");
-               if (!igc_reg_test(adapter, &data[TEST_REG]))
+               netdev_info(netdev, "Register testing starting");
+               if (igc_reg_test(adapter, &data[TEST_REG]))
                        eth_test->flags |= ETH_TEST_FL_FAILED;

                igc_reset(adapter);

-               netdev_info(adapter->netdev, "eeprom testing starting");
-               if (!igc_eeprom_test(adapter, &data[TEST_EEP]))
+               netdev_info(netdev, "EEPROM testing starting");
+               if (igc_eeprom_test(adapter, &data[TEST_EEP]))
                        eth_test->flags |= ETH_TEST_FL_FAILED;

This breaks the selftest functionality added by "igc: add support to interrupt,
eeprom, registers and link self-tests" patch.

In addition to that, the original patch fixes the interrupt log message which
is missing in current dev-queue.

Regards,

Andre
