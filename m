From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 15 Mar 2019 19:08:25 +0800
Subject: [Intel-wired-lan] Opportunistic S0ix blocked by e1000e when
 ethernet is in use
Message-ID: <074E1145-A512-4835-9A6D-8FB6634DBD3C@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jeffrey,

There are several platforms that uses e1000e can?t enter Opportunistic S0ix  
(PC10) when the ethernet has a link partner.

This behavior also exits in out-of-tree e1000e driver 3.4.2.1, but seems  
like 3.4.2.3 fixes the issue.

A quick diff between the two versions shows that this code section may be  
our solution:

         /* Read from EXTCNF_CTRL in e1000_acquire_swflag_ich8lan function
          * may occur during global reset and cause system hang.
          * Configuration space access creates the needed delay.
          * Write to E1000_STRAP RO register E1000_PCI_VENDOR_ID_REGISTER value
          * insures configuration space read is done before global reset.
          */
         pci_read_config_word(hw->adapter->pdev, E1000_PCI_VENDOR_ID_REGISTER,
                              &pci_cfg);
         ew32(STRAP, pci_cfg);
         e_dbg("Issuing a global reset to ich8lan\n");
         ew32(CTRL, (ctrl | E1000_CTRL_RST));
         /* cannot issue a flush here because it hangs the hardware */
         msleep(20);

         /* Configuration space access improve HW level time sync mechanism.
          * Write to E1000_STRAP RO register E1000_PCI_VENDOR_ID_REGISTER
          * value to insure configuration space read is done
          * before any access to mac register.
          */
         pci_read_config_word(hw->adapter->pdev, E1000_PCI_VENDOR_ID_REGISTER,
                              &pci_cfg);
         ew32(STRAP, pci_cfg);

Is there any plan to support this in the upstream kernel?

Kai-Heng
