From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 3 Apr 2017 20:18:37 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Remove driver config for KX4
 PHY
In-Reply-To: <1478033907-10221-1-git-send-email-anthony.l.nguyen@intel.com>
References: <1478033907-10221-1-git-send-email-anthony.l.nguyen@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E50B6EE04@ORSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Tony Nguyen
Sent: Tuesday, November 1, 2016 1:58 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH] ixgbe: Remove driver config for KX4 PHY

The KX4 PHY is configured by the NVM.  Currently, the driver is overwriting the config; remove the code associated with KX4 configuration.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

