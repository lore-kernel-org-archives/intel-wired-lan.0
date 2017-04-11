From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 11 Apr 2017 15:52:03 +0000
Subject: [Intel-wired-lan] [PATCH 2/3] ixgbe: Add X552 XFI backplane
 support
In-Reply-To: <1483150078-35175-1-git-send-email-donald.c.skidmore@intel.com>
References: <1483150078-35175-1-git-send-email-donald.c.skidmore@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E50B76838@ORSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Donald C Skidmore
Sent: Friday, December 30, 2016 6:08 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH 2/3] ixgbe: Add X552 XFI backplane support

This patch add support for X552 XFI backplane interface.  The XFI backplane requires a custom tuned link.  HW/FW owns the link config for XF backplane and SW must not interfere with it.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

