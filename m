From: Thomas Graf <tgraf@suug.ch>
Date: Fri, 10 Apr 2015 01:43:25 +0200
Subject: [Intel-wired-lan] [PATCH 0/3 net-next] Bring sizeof(net_device)
	down to < 2K bytes
Message-ID: <cover.1428622095.git.tgraf@suug.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The size of struct net_device crossed the 2K boundary a while ago which
is a waste in combination with many net namespaces. This series brings
the size of struct net_device down to well below 2K in total size with
a typical configuration. Some reserves a several holes leave room for
further expansion.

Thomas Graf (3):
  e1000: Allocate pm_qos_req as needed
  net_device: Reorder members to fill holes
  net_device: Add minimal padding to allow for net_device pointer
    alignment

 drivers/net/ethernet/intel/e1000e/netdev.c | 15 ++++++++---
 include/linux/kernel.h                     |  2 ++
 include/linux/netdevice.h                  | 41 ++++++++++++++----------------
 net/core/dev.c                             |  3 +--
 4 files changed, 33 insertions(+), 28 deletions(-)

-- 
@Jeff: I only boot tested the e1000 in a virtual machine.
