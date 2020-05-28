From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Thu, 28 May 2020 12:43:39 -0700
Subject: [Intel-wired-lan] [PATCH 11/14] virtual-bus: remove filename from
 header
In-Reply-To: <20200528194342.3495-1-ranjani.sridharan@linux.intel.com>
References: <20200528194342.3495-1-ranjani.sridharan@linux.intel.com>
Message-ID: <20200528194342.3495-12-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/bus/virtual_bus.c   | 2 +-
 include/linux/virtual_bus.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/virtual_bus.c b/drivers/bus/virtual_bus.c
index 613445640cd0..64d7e588fe7d 100644
--- a/drivers/bus/virtual_bus.c
+++ b/drivers/bus/virtual_bus.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * virtual_bus.c - lightweight software based bus for virtual devices
+ * Lightweight software based bus for virtual devices
  *
  * Copyright (c) 2019-2020 Intel Corporation
  *
diff --git a/include/linux/virtual_bus.h b/include/linux/virtual_bus.h
index aeac7144b220..a34e060ded56 100644
--- a/include/linux/virtual_bus.h
+++ b/include/linux/virtual_bus.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * virtual_bus.h - lightweight software bus
+ * Lightweight software bus
  *
  * Copyright (c) 2019-2020 Intel Corporation
  *
-- 
2.17.1

