From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 29 Jun 2018 14:25:38 -0400
Subject: [Intel-wired-lan] [PATCH v6 0/3] multi-threading device shutdown
Message-ID: <20180629182541.6735-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Changelog
v6 - v5
	- Added Review-by from Andy.
	- Synced with mainline
v4 - v5
	- Addressed comments from Andy Shevchenko and Greg
	  Kroah-Hartman
	- Split the patch into a series of 3 patches in order to
	  provide a better bisecting, and facilitate with reviewing.
v3 - v4
	- Added device_shutdown_serial kernel parameter to disable
	  multi-threading as suggested by Greg Kroah-Hartman

v2 - v3
	- Fixed warning from kbuild test.
	- Moved device_lock/device_unlock inside device_shutdown_tree().

v1 - v2
	- It turns out we cannot lock more than MAX_LOCK_DEPTH by a single
	  thread. (By default this value is 48), and is used to detect
	  deadlocks. So, I re-wrote the code to only lock one devices per
	  thread instead of pre-locking all devices by the main thread.
	- Addressed comments from Tobin C. Harding.
	- As suggested by Alexander Duyck removed ixgbe changes. It can be
	  done as a separate work scaling RTNL mutex.

Do a faster shutdown by calling dev->*->shutdown(dev) in parallel.
device_shutdown() calls these functions for every single device but
only using one thread.

Since, nothing else is running on the machine by the time
device_shutdown() is called, there is no reason not to utilize all the
available CPU resources.

Pavel Tatashin (3):
  drivers core: refactor device_shutdown
  drivers core: prepare device_shutdown for multi-threading
  drivers core: multi-threading device shutdown

 drivers/base/core.c | 290 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 243 insertions(+), 47 deletions(-)

-- 
2.18.0

