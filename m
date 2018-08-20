From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 20 Aug 2018 14:48:01 -0700
Subject: [Intel-wired-lan] [PATCH] Documentation: e100, e1000,
 ixgb: Add missing SPDX header
Message-ID: <20180820214801.12975-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add the SPDX-Lincense-Identifier to the Intel wired Ethernet *.rst
kernel documentation.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 Documentation/networking/e100.rst  | 3 ++-
 Documentation/networking/e1000.rst | 3 ++-
 Documentation/networking/ixgb.rst  | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/e100.rst b/Documentation/networking/e100.rst
index f81111eba9c5..5e2839b4ec92 100644
--- a/Documentation/networking/e100.rst
+++ b/Documentation/networking/e100.rst
@@ -1,4 +1,5 @@
-==============================================================
+.. SPDX-License-Identifier: GPL-2.0+
+
 Linux* Base Driver for the Intel(R) PRO/100 Family of Adapters
 ==============================================================
 
diff --git a/Documentation/networking/e1000.rst b/Documentation/networking/e1000.rst
index f10dd4086921..6379d4d20771 100644
--- a/Documentation/networking/e1000.rst
+++ b/Documentation/networking/e1000.rst
@@ -1,4 +1,5 @@
-===========================================================
+.. SPDX-License-Identifier: GPL-2.0+
+
 Linux* Base Driver for Intel(R) Ethernet Network Connection
 ===========================================================
 
diff --git a/Documentation/networking/ixgb.rst b/Documentation/networking/ixgb.rst
index 86b18330666c..b85d48a75194 100644
--- a/Documentation/networking/ixgb.rst
+++ b/Documentation/networking/ixgb.rst
@@ -1,4 +1,5 @@
-=====================================================================
+.. SPDX-License-Identifier: GPL-2.0+
+
 Linux Base Driver for 10 Gigabit Intel(R) Ethernet Network Connection
 =====================================================================
 
-- 
2.17.1

