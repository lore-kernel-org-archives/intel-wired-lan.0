From: Alice Michael <alice.michael@intel.com>
Date: Thu,  7 Sep 2017 08:05:47 -0400
Subject: [Intel-wired-lan] [next PATCH S80-V3 02/11] i40evf: fix mac filter
	removal timing issue
In-Reply-To: <20170907120556.45699-1-alice.michael@intel.com>
References: <20170907120556.45699-1-alice.michael@intel.com>
Message-ID: <20170907120556.45699-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

Due to the asynchronous nature in which mac filters are added and
deleted, there exists a bug in which filters are erroneously removed if
removed then added again quickly.

The events are as such:
    - filter marked for removal
    - same filter is re-added before watchdog that cleans up filters
    - we skip re-adding the filter because we have it already in the
list
    - watchdog filter cleanup kicks off and filter is removed

So when we were re-adding the same filter, it didn't actually get added
because it already existed in the list, but was marked for removal and
had yet to actually be removed.

This patch fixes the issue by making sure that when adding a filter, if
we find it already existing in our list, make sure it is not marked to
be removed.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index c5371da..4496c48 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -880,6 +880,8 @@ i40evf_mac_filter *i40evf_add_filter(struct i40evf_adapter *adapter,
 		list_add_tail(&f->list, &adapter->mac_filter_list);
 		f->add = true;
 		adapter->aq_required |= I40EVF_FLAG_AQ_ADD_MAC_FILTER;
+	} else {
+		f->remove = false;
 	}
 
 	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
-- 
2.9.4

