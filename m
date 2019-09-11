From: Shiraz Saleem <shiraz.saleem@intel.com>
Date: Tue, 10 Sep 2019 20:30:10 -0500
Subject: [Intel-wired-lan] [RFC rdma-next 15/17] RDMA/irdma: Update
 MAINTAINERS file
In-Reply-To: <20190911013012.710-1-shiraz.saleem@intel.com>
References: <20190911013012.710-1-shiraz.saleem@intel.com>
Message-ID: <20190911013012.710-16-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add maintainer entry for irdma driver.

Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 MAINTAINERS | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43604d6..f91b183 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8307,7 +8307,15 @@ L:	linux-pm at vger.kernel.org
 S:	Supported
 F:	drivers/cpufreq/intel_pstate.c
 
-INTEL RDMA RNIC DRIVER
+INTEL ETHERNET RDMA DRIVER
+M:	Mustafa Ismail <mustafa.ismail@intel.com>
+M:	Shiraz Saleem <shiraz.saleem@intel.com>
+L:	linux-rdma at vger.kernel.org
+S:	Supported
+F:	drivers/infiniband/hw/irdma/
+F:	include/uapi/rdma/irdma-abi.h
+
+INTEL X722 RDMA RNIC DRIVER
 M:	Faisal Latif <faisal.latif@intel.com>
 M:	Shiraz Saleem <shiraz.saleem@intel.com>
 L:	linux-rdma at vger.kernel.org
-- 
1.8.3.1

