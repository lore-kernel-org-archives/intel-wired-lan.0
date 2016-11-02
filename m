From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Nov 2016 23:37:37 +0000
Subject: [Intel-wired-lan] [PATCH v2] ixgbevf: handle race between close
 and suspend on shutdown
In-Reply-To: <20161101201041.25498.20160.stgit@localhost6.localdomain6>
References: <20161101201041.25498.20160.stgit@localhost6.localdomain6>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E42E43983@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Emil Tantilov
Sent: Tuesday, November 1, 2016 1:11 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH v2] ixgbevf: handle race between close and suspend on shutdown

When an interface is part of a namespace it is possible that
ixgbevf_close() may be called while ixgbevf_suspend() is running which ends up in a double free WARN and/or a BUG in free_msi_irqs()

To handle this situation we extend the rtnl_lock() to protect the call to netif_device_detach() and check for !netif_device_present() to avoid entering close while in suspend.

Also added rtnl locks to ixgbevf_queue_reset_subtask().

-v2 handle the race with netif_device_detach/present() and rtnl locks as suggested by Alex Duyck

CC: Alexander Duyck <alexander.h.duyck@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

