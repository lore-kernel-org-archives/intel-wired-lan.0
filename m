From: Vasily Averin <vvs@virtuozzo.com>
Date: Tue, 07 Jul 2015 18:53:28 +0300
Subject: [Intel-wired-lan] [PATCH 0/3] rtnl_lock fixes
Message-ID: <559BF5F8.2000500@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

While investigation possible reasons of net_todo_list corruption 
on rhel6 based OpenVZ kernel I've found few places not fixed in mainline.

Vasily Averin (3):
  missing rtnl_unlock in i40evf_resume()
  missing rtnl_unlock in igb_sriov_reinit()
  ipmr_free_table() should be called under taken rtnl_lock

 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 1 +
 drivers/net/ethernet/intel/igb/igb_main.c       | 1 +
 net/ipv6/ip6mr.c                                | 2 ++
 3 files changed, 4 insertions(+)

-- 
1.9.1

