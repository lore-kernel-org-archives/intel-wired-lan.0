From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Sun, 20 Dec 2020 10:50:10 +0100
Subject: [Intel-wired-lan] [PATCH] MAINTAINERS: mark dca driver orphan
Message-ID: <20201220095010.20227-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The dca driver did not have any maintainer section since its inclusion.
As discussed with Dan Williams, there is no maintainer for this driver
since the initial developers moved away.

Introduce a new DIRECT CACHE ACCESS (DCA) DRIVER section and mark the
driver orphan.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20201218 and current master

Dan, please pick this trivial clarification patch.

 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f5eafee83bc6..c8cc5e1a759f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5223,6 +5223,11 @@ L:	linux-i2c at vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/busses/i2c-diolan-u2c.c
 
+DIRECT CACHE ACCESS (DCA) DRIVER
+S:	Orphan
+F:	drivers/dca/
+F:	include/linux/dca.h
+
 DIRECTORY NOTIFICATION (DNOTIFY)
 M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
-- 
2.17.1

