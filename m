From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon,  9 Nov 2015 05:03:47 -0800
Subject: [Intel-wired-lan] [net v2] e100.txt: Cleanup license info in kernel
	doc
Message-ID: <1447074227-102307-1-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Apparently the e100.txt document contained a "License" section left
over from days of old, which does not need to be in the kernel
documentation.  So clean it up..

CC: John Ronciak <john.ronciak@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
v2: fixed subject, since this was not patch 2 of a 2 patch series :-)

 Documentation/networking/e100.txt | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/Documentation/networking/e100.txt b/Documentation/networking/e100.txt
index f862cf3..42ddbd4 100644
--- a/Documentation/networking/e100.txt
+++ b/Documentation/networking/e100.txt
@@ -181,17 +181,3 @@ For general information, go to the Intel support website at:
 If an issue is identified with the released source code on the supported
 kernel with a supported adapter, email the specific information related to the
 issue to e1000-devel at lists.sourceforge.net.
-
-
-License
-=======
-
-This software program is released under the terms of a license agreement
-between you ('Licensee') and Intel. Do not use or load this software or any
-associated materials (collectively, the 'Software') until you have carefully
-read the full terms and conditions of the file COPYING located in this software
-package. By loading or using the Software, you agree to the terms of this
-Agreement. If you do not agree with the terms of this Agreement, do not install
-or use the Software.
-
-* Other names and brands may be claimed as the property of others.
-- 
2.5.0

