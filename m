From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 31 Mar 2017 17:10:15 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Allow disabling VFs when they are
	pre-existing
Message-ID: <20170401001015.29245.28963.stgit@mdrustad-mac04.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Right now if VFs existing when the driver is loaded, it is not
possible to destroy those VFs, even though messages from the driver
suggest doing that when trying to change the number. This change
permits the disabling of SR-IOV for the case when there are
pre-existing VFs.

Testing-hints:

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
Change-type: DefectResolution
Title: ixgbe: Allow disabling VFs when they are pre-existing
---
 src/CORE/ixgbe_sriov.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/CORE/ixgbe_sriov.c b/src/CORE/ixgbe_sriov.c
index 9b7d05110fe9..231acf274a70 100644
--- a/src/CORE/ixgbe_sriov.c
+++ b/src/CORE/ixgbe_sriov.c
@@ -603,7 +603,7 @@ static int ixgbe_pci_sriov_disable(struct pci_dev *dev)
 	u32 current_flags = adapter->flags;
 #endif
 
-	if (adapter->num_vfs == 0)
+	if (!adapter->num_vfs && !pci_num_vf(dev))
 		return -EINVAL;
 
 	err = ixgbe_disable_sriov(adapter);

