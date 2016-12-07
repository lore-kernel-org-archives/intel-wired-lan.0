From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 7 Dec 2016 22:43:46 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Support 2.5Gb and 5Gb speed
In-Reply-To: <1478822493-29862-1-git-send-email-anthony.l.nguyen@intel.com>
References: <1478822493-29862-1-git-send-email-anthony.l.nguyen@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E490F4284@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Tony Nguyen
Sent: Thursday, November 10, 2016 4:02 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH] ixgbe: Support 2.5Gb and 5Gb speed

Though not advertised through ethtool, if the link partner advertises a 2.5Gb or 5Gb connection, and the adapter supports it, allow the speed to be used.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

