From: Vasily Averin <vvs@virtuozzo.com>
Date: Tue, 07 Jul 2015 18:53:55 +0300
Subject: [Intel-wired-lan] [PATCH 3/3] ipmr_free_table() should be called
	under taken rtnl_lock
Message-ID: <559BF613.7090904@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ipmr_free_table() calls unregister_netdevice_many() inside
and changes net_todo_list protected by rtnl_lock

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 net/ipv6/ip6mr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 74ceb73..9108636 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -250,7 +250,9 @@ static int __net_init ip6mr_rules_init(struct net *net)
 	return 0;
 
 err2:
+	rtnl_lock();
 	ip6mr_free_table(mrt);
+	rtnl_unlock();
 err1:
 	fib_rules_unregister(ops);
 	return err;
-- 
1.9.1

