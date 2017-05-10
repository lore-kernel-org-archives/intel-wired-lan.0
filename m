From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 10 May 2017 14:12:53 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 14/14] i40evf: update
	i40evf.txt with new content
In-Reply-To: <20170510211253.112105-1-jesse.brandeburg@intel.com>
References: <20170510211253.112105-1-jesse.brandeburg@intel.com>
Message-ID: <20170510211253.112105-15-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The addition of the AVF and virtchnl code to the i40evf driver
means we should update the i40evf.txt file with the most up to date
information.

It seems this file hasn't been updated in a while, so the
changes cover a little more than just AVF, but it's all only
in the i40evf.txt.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 Documentation/networking/i40evf.txt | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/i40evf.txt b/Documentation/networking/i40evf.txt
index 21e4127..e9b3035 100644
--- a/Documentation/networking/i40evf.txt
+++ b/Documentation/networking/i40evf.txt
@@ -1,8 +1,8 @@
 Linux* Base Driver for Intel(R) Network Connection
 ==================================================
 
-Intel XL710 X710 Virtual Function Linux driver.
-Copyright(c) 2013 Intel Corporation.
+Intel Ethernet Adaptive Virtual Function Linux driver.
+Copyright(c) 2013-2017 Intel Corporation.
 
 Contents
 ========
@@ -11,19 +11,26 @@ Contents
 - Known Issues/Troubleshooting
 - Support
 
-This file describes the i40evf Linux* Base Driver for the Intel(R) XL710
-X710 Virtual Function.
+This file describes the i40evf Linux* Base Driver.
 
-The i40evf driver supports XL710 and X710 virtual function devices that
-can only be activated on kernels with CONFIG_PCI_IOV enabled.
+The i40evf driver supports the below mentioned virtual function
+devices and can only be activated on kernels running the i40e or
+newer Physical Function (PF) driver compiled with CONFIG_PCI_IOV.
+The i40evf driver requires CONFIG_PCI_MSI to be enabled.
 
 The guest OS loading the i40evf driver must support MSI-X interrupts.
 
+Supported Hardware
+==================
+Intel XL710 X710 Virtual Function
+Intel Ethernet Adaptive Virtual Function
+Intel X722 Virtual Function
+
 Identifying Your Adapter
 ========================
 
-For more information on how to identify your adapter, go to the Adapter &
-Driver ID Guide at:
+For more information on how to identify your adapter, go to the
+Adapter & Driver ID Guide at:
 
     http://support.intel.com/support/go/network/adapter/idguide.htm
 
-- 
2.9.3

