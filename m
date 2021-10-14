From: Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 13 Oct 2021 22:05:16 -0700
Subject: [Intel-wired-lan] [PATCH net-next] net: intel: igc_ptp: fix build
 for UML
Message-ID: <20211014050516.6846-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On a UML build, the igc_ptp driver uses CONFIG_X86_TSC for timestamp
conversion. The function that is used is not available on UML builds,
so have the function use the default system_counterval_t timestamp
instead for UML builds.

Prevents this build error on UML:

../drivers/net/ethernet/intel/igc/igc_ptp.c: In function ?igc_device_tstamp_to_system?:
../drivers/net/ethernet/intel/igc/igc_ptp.c:777:9: error: implicit declaration of function ?convert_art_ns_to_tsc? [-Werror=implicit-function-declaration]
  return convert_art_ns_to_tsc(tstamp);
../drivers/net/ethernet/intel/igc/igc_ptp.c:777:9: error: incompatible types when returning type ?int? but ?struct system_counterval_t? was expected
  return convert_art_ns_to_tsc(tstamp);

Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-um at lists.infradead.org
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan at lists.osuosl.org
---
 drivers/net/ethernet/intel/igc/igc_ptp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20211013.orig/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ linux-next-20211013/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -773,7 +773,7 @@ static bool igc_is_crosststamp_supported
 
 static struct system_counterval_t igc_device_tstamp_to_system(u64 tstamp)
 {
-#if IS_ENABLED(CONFIG_X86_TSC)
+#if IS_ENABLED(CONFIG_X86_TSC) && !defined(CONFIG_UML)
 	return convert_art_ns_to_tsc(tstamp);
 #else
 	return (struct system_counterval_t) { };
