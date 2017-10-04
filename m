From: Ben Hutchings <ben@decadent.org.uk>
Date: Wed, 4 Oct 2017 02:52:08 +0100
Subject: [Intel-wired-lan] [RFC PATCH] i40e: Build for 64-bit targets only
Message-ID: <20171004015208.GA2971@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

i40e now uses cmpxchg64(), which only works on a 64-bit (or non-SMP)
system.  (It is currently defined for many 32-bit SMP configurations,
but not correctly!)  It seems reasonable to expect that 40G hardware
is not used on 32-bit systems.

Fixes: 841c950d67c6 ("i40e/i40evf: use cmpxchg64 when updating private ...")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
I specifically found a build failure on 32-bit parisc:

https://buildd.debian.org/status/fetch.php?pkg=linux&arch=hppa&ver=4.14%7Erc3-1%7Eexp1&stamp=1507045758&raw=0

Ben.

 drivers/net/ethernet/intel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 1feb54b6d92e..dd17bdf5561e 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -215,6 +215,7 @@ config I40E
 	tristate "Intel(R) Ethernet Controller XL710 Family support"
 	imply PTP_1588_CLOCK
 	depends on PCI
+	depends on 64BIT
 	---help---
 	  This driver supports Intel(R) Ethernet Controller XL710 Family of
 	  devices.  For more information on how to identify your adapter, go
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: Digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20171004/a7d4ff8b/attachment-0001.asc>
