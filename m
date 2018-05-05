From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Sat,  5 May 2018 11:40:39 -0400
Subject: [Intel-wired-lan] [PATCH v2 0/1] multi-threading device shutdown
Message-ID: <20180505154040.28614-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Changelog

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

Since, nothing else is running on the machine by the device_shutdown()
s called, there is no reason not to utilize all the available CPU
resources.

Pavel Tatashin (1):
  drivers core: multi-threading device shutdown

 drivers/base/core.c | 275 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 225 insertions(+), 50 deletions(-)

-- 
2.17.0

