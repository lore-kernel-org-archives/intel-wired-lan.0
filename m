From: David Yang <david_yang@accton.com>
Date: Thu, 31 Dec 2015 05:46:43 +0000
Subject: [Intel-wired-lan] [PATCH] patch for Intel igb driver to support
	broadcom phys
Message-ID: <1831EC2B04379B47B6D129255B9BF2212D34A8D1@SRV-EXMBX2.accton.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



Howdy,

We are bare metal network switch developers who contribute codes
for OCP ONIE (https://github.com/opencomputeproject/onie).

Up to now, many switches have Intel CPU module with Ethernet 
controller (i354) which connects to external Broadcom PHY (bcm54616s).
We revised linux igb driver for making the PHY work.

The patch is for linux-4.1.12.  Please help to review the 
patch for upstream to the igb driver.

Many thanks.
David

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-patch-for-Intel-igb-driver-to-support-broadcom-phys.patch
Type: application/octet-stream
Size: 2340 bytes
Desc: 0001-patch-for-Intel-igb-driver-to-support-broadcom-phys.patch
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151231/a1491aca/attachment-0001.obj>
