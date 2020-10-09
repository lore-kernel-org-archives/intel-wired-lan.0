From: ira.weiny@intel.com <ira.weiny@intel.com>
Date: Fri,  9 Oct 2020 12:50:33 -0700
Subject: [Intel-wired-lan] [PATCH RFC PKS/PMEM 58/58] [dax|pmem]: Enable
 stray access protection
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
Message-ID: <20201009195033.3208459-59-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ira Weiny <ira.weiny@intel.com>

Protecting against stray writes is particularly important for PMEM
because, unlike writes to anonymous memory, writes to PMEM persists
across a reboot.  Thus data corruption could result in permanent loss of
data.

While stray writes are more serious than reads, protection is also
enabled for reads.  This helps to detect bugs in code which would
incorrectly access device memory and prevents a more serious machine
checks should those bug reads from a poison page.

Enable stray access protection by setting the flag in pgmap which
requests it.  There is no option presented to the user.  If Zone Device
Access Protection not be supported this flag will have no affect.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/dax/device.c  | 2 ++
 drivers/nvdimm/pmem.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 1e89513f3c59..e6fb35b4f0fb 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -430,6 +430,8 @@ int dev_dax_probe(struct device *dev)
 	}
 
 	dev_dax->pgmap.type = MEMORY_DEVICE_GENERIC;
+	dev_dax->pgmap.flags |= PGMAP_PROT_ENABLED;
+
 	addr = devm_memremap_pages(dev, &dev_dax->pgmap);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index e4dc1ae990fc..9fcd8338e23f 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -426,6 +426,8 @@ static int pmem_attach_disk(struct device *dev,
 		return -EBUSY;
 	}
 
+	pmem->pgmap.flags |= PGMAP_PROT_ENABLED;
+
 	q = blk_alloc_queue(dev_to_node(dev));
 	if (!q)
 		return -ENOMEM;
-- 
2.28.0.rc0.12.gb6a658bd00c9

