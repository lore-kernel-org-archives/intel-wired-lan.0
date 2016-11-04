From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Fri, 4 Nov 2016 21:39:12 +0000
Subject: [Intel-wired-lan] [PATCH v6] ixgbe: Add X553 FW ALEF support
In-Reply-To: <1478221297-48647-1-git-send-email-donald.c.skidmore@intel.com>
References: <1478221297-48647-1-git-send-email-donald.c.skidmore@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E42E44614@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Donald C Skidmore
Sent: Thursday, November 3, 2016 6:02 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH v6] ixgbe: Add X553 FW ALEF support

From: Don Skidmore <donald.c.skidmore@intel.com>

This patch add X553 FW ALEF support for B0.  ALEF is the new unified FW.  This contains updated register defines for ALEF speed configuration.  Likewise it also removes the AN_CNTL_8 usage from the native SFI flow as it is no longer supported by FW.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

