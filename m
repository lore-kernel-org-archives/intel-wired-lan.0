From: Alexander Duyck <aduyck@mirantis.com>
Date: Tue, 29 Sep 2015 15:19:56 -0700
Subject: [Intel-wired-lan] [PATCH 3/3] fm10k: use napi_schedule_irqoff()
In-Reply-To: <20150929215117.3388.48642.stgit@ahduyck-vm-fedora22>
References: <20150929215117.3388.48642.stgit@ahduyck-vm-fedora22>
Message-ID: <20150929221956.3388.23153.stgit@ahduyck-vm-fedora22>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The fm10k_msix_clean_rings function runs from hard interrupt context or
with interrupts already disabled in netpoll.

It can use napi_schedule_irqoff() instead of napi_schedule()

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 74be792f3f1b..5fbffbaefe32 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -846,7 +846,7 @@ static irqreturn_t fm10k_msix_clean_rings(int __always_unused irq, void *data)
 	struct fm10k_q_vector *q_vector = data;
 
 	if (q_vector->rx.count || q_vector->tx.count)
-		napi_schedule(&q_vector->napi);
+		napi_schedule_irqoff(&q_vector->napi);
 
 	return IRQ_HANDLED;
 }

