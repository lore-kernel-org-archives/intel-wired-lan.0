From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 15 Nov 2021 17:58:45 +0100
Subject: [Intel-wired-lan] [PATCH 5.15 430/917] net: intel: igc_ptp: fix
 build for UML
In-Reply-To: <20211115165428.722074685@linuxfoundation.org>
References: <20211115165428.722074685@linuxfoundation.org>
Message-ID: <20211115165443.371123535@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 523994ba3ad1b7b55abe4a72e156897b5e2db825 ]

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
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan at lists.osuosl.org
Link: https://lore.kernel.org/r/20211014050516.6846-1-rdunlap at infradead.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 0f021909b430a..30568e3544cda 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -773,7 +773,7 @@ static bool igc_is_crosststamp_supported(struct igc_adapter *adapter)
 
 static struct system_counterval_t igc_device_tstamp_to_system(u64 tstamp)
 {
-#if IS_ENABLED(CONFIG_X86_TSC)
+#if IS_ENABLED(CONFIG_X86_TSC) && !defined(CONFIG_UML)
 	return convert_art_ns_to_tsc(tstamp);
 #else
 	return (struct system_counterval_t) { };
-- 
2.33.0



