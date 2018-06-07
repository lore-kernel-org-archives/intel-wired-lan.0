From: Yang, Yi Y <yi.y.yang@intel.com>
Date: Thu, 7 Jun 2018 02:46:47 +0000
Subject: [Intel-wired-lan] Anybody knows how to update firmware for 10G
 82599ES NIC?
Message-ID: <79BBBFE6CB6C9B488C1A45ACD284F51961FB1A5A@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi, guys

We found 10G 82599ES NIC can't work in opencontrail with DPDK 17.11 and uio_pci_generic driver in centos 7.5, the below is NIC information:

driver: ixgbe
version: 5.1.0-k-rh7.5
firmware-version: 0x80000646
expansion-rom-version:
bus-info: 0000:81:00.1
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

But it  is ok when we use the same opencontrail with DPDK 17.02. We also tried opencontrail with DPDK 17.11 and uio_pci_generic driver in centos 7.4, it is ok, NIC information is as below:

driver: ixgbe
version: 4.4.0-k-rh7.4
firmware-version: 0x61c10001
expansion-rom-version:
bus-info: 0000:02:00.1
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: no

So we doubt it is firmware issue, anybody knows which firmware version can work well and how we can update to such firmware version, thank you in advance, this is blocking customers from adopting DPDK 17.11.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180607/b12b1211/attachment.html>
