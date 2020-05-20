From: Shiraz Saleem <shiraz.saleem@intel.com>
Date: Tue, 19 May 2020 19:16:13 -0500
Subject: [Intel-wired-lan] [PATCH RFC v6 16/16] RDMA/irdma: Update
 MAINTAINERS file
In-Reply-To: <20200520001613.475-1-shiraz.saleem@intel.com>
References: <20200520001613.475-1-shiraz.saleem@intel.com>
Message-ID: <20200520001613.475-17-shiraz.saleem@intel.com>
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
index bdfbed1..73386fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8749,6 +8749,14 @@ L:	linux-pm at vger.kernel.org
 S:	Supported
 F:	drivers/cpufreq/intel_pstate.c
 
+INTEL ETHERNET PROTOCL DRIVER FOR RDMA
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

