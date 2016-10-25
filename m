From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Tue, 25 Oct 2016 11:37:41 -0400
Subject: [Intel-wired-lan] [net-next PATCH 10/27] arch/hexagon: Add option
 to skip DMA sync as a part of mapping
In-Reply-To: <20161025153220.4815.61239.stgit@ahduyck-blue-test.jf.intel.com>
References: <20161025153220.4815.61239.stgit@ahduyck-blue-test.jf.intel.com>
Message-ID: <20161025153741.4815.68818.stgit@ahduyck-blue-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This change allows us to pass DMA_ATTR_SKIP_CPU_SYNC which allows us to
avoid invoking cache line invalidation if the driver will just handle it
later via a sync_for_cpu or sync_for_device call.

Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon at vger.kernel.org
Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 arch/hexagon/kernel/dma.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index b901778..dbc4f10 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -119,6 +119,9 @@ static int hexagon_map_sg(struct device *hwdev, struct scatterlist *sg,
 
 		s->dma_length = s->length;
 
+		if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
+			continue;
+
 		flush_dcache_range(dma_addr_to_virt(s->dma_address),
 				   dma_addr_to_virt(s->dma_address + s->length));
 	}
@@ -180,7 +183,8 @@ static dma_addr_t hexagon_map_page(struct device *dev, struct page *page,
 	if (!check_addr("map_single", dev, bus, size))
 		return bad_dma_address;
 
-	dma_sync(dma_addr_to_virt(bus), size, dir);
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		dma_sync(dma_addr_to_virt(bus), size, dir);
 
 	return bus;
 }

