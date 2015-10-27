From: Alexander Duyck <aduyck@mirantis.com>
Date: Tue, 27 Oct 2015 16:59:12 -0700
Subject: [Intel-wired-lan] [next PATCH 1/5] fm10k: Cleanup MSI-X interrupts
	in case of failure
In-Reply-To: <20151027235341.30048.46286.stgit@localhost.localdomain>
References: <20151027235341.30048.46286.stgit@localhost.localdomain>
Message-ID: <20151027235912.30048.59266.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If the q_vector allocation fails we should free the resources associated
with the MSI-X vector table.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index b8c9f58354bf..983b1f3b5f22 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -2002,8 +2002,10 @@ int fm10k_init_queueing_scheme(struct fm10k_intfc *interface)
 
 	/* Allocate memory for queues */
 	err = fm10k_alloc_q_vectors(interface);
-	if (err)
+	if (err) {
+		fm10k_reset_msix_capability(interface);
 		return err;
+	}
 
 	/* Map rings to devices, and map devices to physical queues */
 	fm10k_assign_rings(interface);

