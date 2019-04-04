From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu,  4 Apr 2019 14:56:32 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v1] igb: Fix limiting the
 number of queues to number of cpus
Message-ID: <20190404215632.9881-1-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We have seen some reports[1] of users complaining that they aren't
able to use some queues when their machines have less than 4 cpus.
This affects some TSN workloads, as different traffic classes are
assigned different queues. The current behavior limits the number of
traffic classes that can be reliably handled.

In practice, what is not working, it returns an invalid parameter
error, in hosts with less than 4 cpus is something like this:

$ tc qdisc replace dev IFACE parent root mqprio	\
     	   num_tc 3 map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2	\
	   queues 1 at 0 1 at 1 2 at 2 hw 0

Because changing the default logic of the allocation of queues could
bring other effects, we propose adding a module parameter so expert
users may override that decision.

[1] https://github.com/jeez/iproute2/issues/1

Reported-by: Bhagath Singh Karunakaran <bhagath@kalycito.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---

A similar fix should also be needed for igc, even if I don't have the
hardware to test, I can produce a patch, if others are able to test.

I am not totally sure that using a module parameter is the best
solution, so, suggestions are welcome.

 drivers/net/ethernet/intel/igb/igb_main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 32d61d5a2706..87072d47c305 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -247,6 +247,10 @@ static int debug = -1;
 module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 
+static unsigned int num_queues;
+module_param(num_queues, uint, 0);
+MODULE_PARM_DESC(num_queues, "Allocate at maximum this number of queues (0=num_cpus(), default)");
+
 struct igb_reg_info {
 	u32 ofs;
 	char *name;
@@ -3763,7 +3767,13 @@ static void igb_init_queue_configuration(struct igb_adapter *adapter)
 	u32 max_rss_queues;
 
 	max_rss_queues = igb_get_max_rss_queues(adapter);
-	adapter->rss_queues = min_t(u32, max_rss_queues, num_online_cpus());
+
+	if (num_queues > 0)
+		adapter->rss_queues = min_t(u32, max_rss_queues,
+					    num_queues);
+	else
+		adapter->rss_queues = min_t(u32, max_rss_queues,
+					    num_online_cpus());
 
 	igb_set_flag_queue_pairs(adapter, max_rss_queues);
 }
-- 
2.21.0

