From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 26 Oct 2016 23:44:17 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Report driver version to
 firmware	for x550 devices
In-Reply-To: <1476735882-5310-1-git-send-email-anthony.l.nguyen@intel.com>
References: <1476735882-5310-1-git-send-email-anthony.l.nguyen@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E42E40701@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Tony Nguyen
Sent: Monday, October 17, 2016 1:25 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH] ixgbe: Report driver version to firmware for x550 devices

Some x550 devices require the driver version reported to its firmware; this patch sends the driver version string to the firmware through the host interface command for x550 devices.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>


