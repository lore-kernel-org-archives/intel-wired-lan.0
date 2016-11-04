From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Fri, 4 Nov 2016 21:35:09 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add X553 PHY FC autoneg support
In-Reply-To: <1475001072-42418-1-git-send-email-donald.c.skidmore@intel.com>
References: <1475001072-42418-1-git-send-email-donald.c.skidmore@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E42E445D8@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Donald C Skidmore
Sent: Tuesday, September 27, 2016 11:31 AM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add X553 PHY FC autoneg support

This patch adds X553 flow control auto negotiation for fiber and backplain.  To enable this new function pointers were added as well as creating a function to dynamically set function pointer we can't define only on MAC type.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

