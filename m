From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 13 Apr 2016 22:40:41 +0000
Subject: [Intel-wired-lan] [PATCH v1 9/9] fm10k: Reset multicast mode
 when	deleting lport
In-Reply-To: <1459552659-22959-10-git-send-email-jacob.e.keller@intel.com>
References: <1459552659-22959-1-git-send-email-jacob.e.keller@intel.com>
 <1459552659-22959-10-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E273714D4@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Friday, April 1, 2016 4:18 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Kwan, Ngai-mint <ngai-mint.kwan@intel.com>
Subject: [Intel-wired-lan] [PATCH v1 9/9] fm10k: Reset multicast mode when deleting lport

From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>

Deleting lport when multicast mode is configured to FM10K_XCAST_MODE_ALLMULTI or FM10K_XCAST_MODE_PROMISC will result in generating orphaned multicast-group entries in the switch manager.
Before deleting the lport, reset multicast mode to FM10K_XCAST_MODE_NONE to flush out these multicast-group entries.

Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

