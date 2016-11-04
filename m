From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Fri, 4 Nov 2016 21:37:57 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Update setup PHY link to unset
 all	speeds
In-Reply-To: <1477098654-29228-1-git-send-email-donald.c.skidmore@intel.com>
References: <1477098654-29228-1-git-send-email-donald.c.skidmore@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E42E44600@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Donald C Skidmore
Sent: Friday, October 21, 2016 6:11 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH] ixgbe: Update setup PHY link to unset all speeds

This patch updates ixgbe_setup_phy_link_generic to set/unset auto-negotiation for all speeds. This ensures that unsupported speeds are unset. This is necessary since the PHY NVM may advertise unsupported speeds.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

