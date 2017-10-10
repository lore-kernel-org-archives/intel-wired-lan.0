From: Diorge Tavares <diorge.tavares@flightaware.com>
Date: Tue, 10 Oct 2017 16:45:49 +0000
Subject: [Intel-wired-lan] Linux Ubuntu 17.04 Hung Queue Messages - Intel
	X710 ixl driver
Message-ID: <DC0F0577-D384-438B-BE36-35E18F418A93@flightaware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

We have been working with Intel FreeBSD support and found a bug in the lastest driver release for ixl Intel XL710 NIC. It has to do with buffer sizes and MDD events occurring because of them.

Intel FreeBSD proposed fix

If you want to modify the driver again, then change this piece in ixl_tso_detect_sparse() in ixl_txrx.c:

                if (mss < 1) {
                        if (num > IXL_SPARSE_CHAIN)
                                return (true);
                        num = (mss == 0) ? 0 : 1;
                        mss += mp->m_pkthdr.tso_segsz;
                }

to

                if (num > IXL_SPARSE_CHAIN)
                        return (true);
                if (mss < 1) {
                        num = (mss == 0) ? 0 : 1;
                        mss += mp->m_pkthdr.tso_segsz;
                }

This will definitely prevent MDDs on the buffers you sent me.


We are now experiencing similar issues with Linux (Ubuntu 17.04).. See dmesg below.

Please advise how we can correct this.

[2501243.181829] i40e 0000:01:00.1 eno2: VSI_seid 390, Hung TX queue 17, tx_pending_hw: 1, NTC:0x16b, HWB: 0x16b, NTU: 0x16c, TAIL: 0x16c

Dmesg details about driver in use
[    1.606179] i40e: Intel(R) Ethernet Connection XL710 Network Driver - version 1.6.25-k

Details on Ubuntu in use
[    0.000000] Linux version 4.10.0-28-generic (buildd at lgw01-11) (gcc version 6.3.0 20170406 (Ubuntu 6.3.0-12ubuntu2) ) #32-Ubuntu SMP Fri Jun 30 05:32:18 UTC 2017 (Ubuntu 4.10.0-28.32-generic 4.10.17)

$ cat /etc/os-release
NAME="Ubuntu"
VERSION="17.04 (Zesty Zapus)"

--
Diorge Tavares
http://flightaware.com<http://flightaware.com/>
+1 713 993-0015

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20171010/8c0cbd67/attachment.html>
