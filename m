From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu,  4 May 2017 02:35:16 -0700
Subject: [Intel-wired-lan] [net-next v2 01/13] i40evf: drop i40e_type.h
	include
In-Reply-To: <20170504093528.76047-1-jeffrey.t.kirsher@intel.com>
References: <20170504093528.76047-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20170504093528.76047-2-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

This drops the i40e_type.h include in anticipation of the next
patch which moves this file to a location where type.h doesn't
exist, and all the places this file is included already include
i40e_type.h before this file.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

diff --git a/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h b/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
index b0b8de5..7d6da3a 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
@@ -27,8 +27,6 @@
 #ifndef _I40E_VIRTCHNL_H_
 #define _I40E_VIRTCHNL_H_
 
-#include "i40e_type.h"
-
 /* Description:
  * This header file describes the VF-PF communication protocol used
  * by the various i40e drivers.
-- 
1.8.3.1

