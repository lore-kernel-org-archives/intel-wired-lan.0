From: Shiraz Saleem <shiraz.saleem@intel.com>
Date: Thu, 16 Jan 2020 17:05:08 -0600
Subject: [Intel-wired-lan] [PATCH RFC rdma 16/16] RDMA/irdma: Update
 MAINTAINERS file
In-Reply-To: <20200116230508.1814-1-shiraz.saleem@intel.com>
References: <20200116230508.1814-1-shiraz.saleem@intel.com>
Message-ID: <20200116230508.1814-17-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add maintainer entry for irdma driver.

Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 254317e..71c0e86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8525,6 +8525,14 @@ L:	linux-pm at vger.kernel.org
 S:	Supported
 F:	drivers/cpufreq/intel_pstate.c
 
+INTEL ETHERNET RDMA DRIVER
+M:	Mustafa Ismail <mustafa.ismail@intel.com>
+M:	Shiraz Saleem <shiraz.saleem@intel.com>
+L:	linux-rdma at vger.kernel.org
+S:	Supported
+F:	drivers/infiniband/hw/irdma/
+F:	include/uapi/rdma/irdma-abi.h
+
 INTEL SPEED SELECT TECHNOLOGY
 M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
 L:	platform-driver-x86 at vger.kernel.org
-- 
1.8.3.1

