From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 10 Oct 2018 12:16:02 -0700
Subject: [Intel-wired-lan] [PATCH v2 01/12] Documentation: e100,
 e1000: Add missing SPDX header
In-Reply-To: <20181010191613.2770-1-jeffrey.t.kirsher@intel.com>
References: <20181010191613.2770-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20181010191613.2770-2-jeffrey.t.kirsher@intel.com>
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
 2 files changed, 4 insertions(+), 2 deletions(-)

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
 
-- 
2.17.1

