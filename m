From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Wed,  2 May 2018 23:59:29 -0400
Subject: [Intel-wired-lan] [PATCH 0/2] multi-threading device shutdown
Message-ID: <20180503035931.22439-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Do a faster shutdown by calling dev->*->shutdown(dev) in parallel.
device_shutdown() calls these functions for every single device but
only using one thread.

Since, nothing else is running on the machine by the device_shutdown()
s called, there is no reason not to utilize all the available CPU
resources.

Pavel Tatashin (2):
  ixgbe: release lock for the duration of ixgbe_suspend_close()
  drivers core: multi-threading device shutdown

 drivers/base/core.c                           | 238 ++++++++++++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   9 +-
 2 files changed, 197 insertions(+), 50 deletions(-)

-- 
2.17.0

