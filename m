From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 14 May 2015 17:23:43 +0000
Subject: [Intel-wired-lan] [PATCH 2/3] fm10k: fold fm10k_pull_tail
	into	fm10k_add_rx_frag
In-Reply-To: <20150423044925.18903.17284.stgit@ahduyck-vm-fedora22>
References: <20150423040941.18903.3545.stgit@ahduyck-vm-fedora22>
 <20150423044925.18903.17284.stgit@ahduyck-vm-fedora22>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2716DA19@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Alexander Duyck
Sent: Wednesday, April 22, 2015 9:49 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH 2/3] fm10k: fold fm10k_pull_tail into fm10k_add_rx_frag

This change folds the fm10k_pull_tail call into fm10k_add_rx_frag.  The advantage to doing this is that the fragment doesn't have to be modified after it is added to the skb.

Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c |   66 ++++++++-----------------
 1 file changed, 20 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 1b0661e3573b..4eafdad318b4 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
