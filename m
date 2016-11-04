From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Fri, 4 Nov 2016 21:36:43 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add support to retrieve and
 store	LED link active
In-Reply-To: <1477014120-23682-1-git-send-email-donald.c.skidmore@intel.com>
References: <1477014120-23682-1-git-send-email-donald.c.skidmore@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E42E445EC@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Donald C Skidmore
Sent: Thursday, October 20, 2016 6:42 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add support to retrieve and store LED link active

This patch adds support to get the LED link active via the LEDCTL register.  If the LEDCTL register does not have LED link active (LED mode field = 0x0100) set then default LED link active returned.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

