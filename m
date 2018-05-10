From: Alice Michael <alice.michael@intel.com>
Date: Thu, 10 May 2018 05:59:40 -0700
Subject: [Intel-wired-lan] [next PATCH S91 02/11] i40evf: Fix client header
 define
In-Reply-To: <20180510125949.79823-1-alice.michael@intel.com>
References: <20180510125949.79823-1-alice.michael@intel.com>
Message-ID: <20180510125949.79823-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

Fix up the VF client header define, since it is the same as the PF
client header.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_client.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_client.h b/drivers/net/ethernet/intel/i40evf/i40evf_client.h
index fc6592c..5585f36 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_client.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_client.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#ifndef _I40E_CLIENT_H_
-#define _I40E_CLIENT_H_
+#ifndef _I40EVF_CLIENT_H_
+#define _I40EVF_CLIENT_H_
 
 #define I40EVF_CLIENT_STR_LENGTH 10
 
@@ -166,4 +166,4 @@ struct i40e_client {
 /* used by clients */
 int i40evf_register_client(struct i40e_client *client);
 int i40evf_unregister_client(struct i40e_client *client);
-#endif /* _I40E_CLIENT_H_ */
+#endif /* _I40EVF_CLIENT_H_ */
-- 
2.9.5

