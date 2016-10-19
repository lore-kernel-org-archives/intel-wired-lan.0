From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 19 Oct 2016 22:43:54 +0000
Subject: [Intel-wired-lan] [Patch V5 ] ixgbe: Add X553 FW ALEF support
In-Reply-To: <1476402830-32229-1-git-send-email-donald.c.skidmore@intel.com>
References: <1476402830-32229-1-git-send-email-donald.c.skidmore@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E42E3AE3E@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Donald C Skidmore
Sent: Thursday, October 13, 2016 4:54 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [Patch V5 ] ixgbe: Add X553 FW ALEF support

From: Don Skidmore <donald.c.skidmore@intel.com>

This patch add X553 FW ALEF support for B0.  ALEF is the new unified FW.  This contains updated register defines for ALEF speed configuration.  Likewise it also removes the AN_CNTL_8 usage from the native SFI flow as it is no longer supported by FW.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

