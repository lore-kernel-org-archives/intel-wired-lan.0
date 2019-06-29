From: Shiraz Saleem <shiraz.saleem@intel.com>
Date: Sat, 29 Jun 2019 13:54:05 -0500
Subject: [Intel-wired-lan] [PATCH rdma-next 17/17] RDMA/i40iw: Mark i40iw as
 deprecated
In-Reply-To: <20190629185405.1601-1-shiraz.saleem@intel.com>
References: <20190629185405.1601-1-shiraz.saleem@intel.com>
Message-ID: <20190629185405.1601-18-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Mark i40iw as deprecated/obsolete.

irdma is the replacement driver that supports X722.

Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/i40iw/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/i40iw/Kconfig b/drivers/infiniband/hw/i40iw/Kconfig
index d867ef1..7454b84 100644
--- a/drivers/infiniband/hw/i40iw/Kconfig
+++ b/drivers/infiniband/hw/i40iw/Kconfig
@@ -1,8 +1,10 @@
 config INFINIBAND_I40IW
-	tristate "Intel(R) Ethernet X722 iWARP Driver"
+	tristate "Intel(R) Ethernet X722 iWARP Driver (DEPRECATED)"
 	depends on INET && I40E
 	depends on IPV6 || !IPV6
 	depends on PCI
+	depends on !(INFINBAND_IRDMA=y || INFINIBAND_IRDMA=m)
 	select GENERIC_ALLOCATOR
 	---help---
 	Intel(R) Ethernet X722 iWARP Driver
+	This driver is being replaced by irdma.
-- 
1.8.3.1

