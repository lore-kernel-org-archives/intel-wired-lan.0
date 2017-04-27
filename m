From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 27 Apr 2017 00:03:48 +0000
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Remove MAC X550EM_X
 1Gbase-t	led_[on|off] support
In-Reply-To: <1492767433-7430-1-git-send-email-paul.greenwalt@intel.com>
References: <1492767433-7430-1-git-send-email-paul.greenwalt@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E50B8878C@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Paul Greenwalt
Sent: Friday, April 21, 2017 2:37 AM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Remove MAC X550EM_X 1Gbase-t led_[on|off] support

Since FW configures the PHY and MAC X550EM_X has no PHY access, led_[on|off] is not supported with the 1Gbase-t design.

Removed MAC X550EM_X 1Gbase-t led_[on|off] support by setting function pointers to NULL and added NULL pointer checks. Also set init_led_link_act to NULL and added NULL pointer check.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

