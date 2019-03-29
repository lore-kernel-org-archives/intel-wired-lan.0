From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 29 Mar 2019 16:38:48 -0700
Subject: [Intel-wired-lan] [PATCH 4/6] iavf: use struct_size() in kzalloc()
In-Reply-To: <20190329233850.29630-1-jeffrey.t.kirsher@intel.com>
References: <20190329233850.29630-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20190329233850.29630-4-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    struct boo entry[];
};

size = sizeof(struct foo) + count * sizeof(struct boo);
instance = kzalloc(size, GFP_KERNEL)

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL)

Notice that, in this case, variable bufsz is not necessary, hence it
is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 4569d69a2b55..78340b297dab 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3353,7 +3353,7 @@ static void iavf_init_task(struct work_struct *work)
 	struct net_device *netdev = adapter->netdev;
 	struct iavf_hw *hw = &adapter->hw;
 	struct pci_dev *pdev = adapter->pdev;
-	int err, bufsz;
+	int err;
 
 	switch (adapter->state) {
 	case __IAVF_STARTUP:
@@ -3423,10 +3423,9 @@ static void iavf_init_task(struct work_struct *work)
 	case __IAVF_INIT_GET_RESOURCES:
 		/* aq msg sent, awaiting reply */
 		if (!adapter->vf_res) {
-			bufsz = sizeof(struct virtchnl_vf_resource) +
-				(IAVF_MAX_VF_VSI *
-				 sizeof(struct virtchnl_vsi_resource));
-			adapter->vf_res = kzalloc(bufsz, GFP_KERNEL);
+			adapter->vf_res = kzalloc(struct_size(adapter->vf_res,
+						  vsi_res, IAVF_MAX_VF_VSI),
+						  GFP_KERNEL);
 			if (!adapter->vf_res)
 				goto err;
 		}
-- 
2.20.1

