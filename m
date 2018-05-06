From: kbuild test robot <lkp@intel.com>
Date: Sun, 6 May 2018 09:56:33 +0800
Subject: [Intel-wired-lan] [RFC PATCH] drivers core: device_root_tasks_done
 can be static
In-Reply-To: <20180505154040.28614-2-pasha.tatashin@oracle.com>
References: <20180505154040.28614-2-pasha.tatashin@oracle.com>
Message-ID: <20180506015633.GA91045@lkp-hsx03>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Fixes: 6d54ba128905 ("drivers core: multi-threading device shutdown")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 110d797..666c163 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2874,7 +2874,7 @@ static int device_shutdown_child_task(void *data);
  */
 static atomic_t		device_root_tasks_finished;
 static atomic_t		device_root_tasks_started;
-struct completion	device_root_tasks_done;
+static struct completion	device_root_tasks_done;
 
 /**
  * Shutdown device tree with root started in dev. If dev has no children
