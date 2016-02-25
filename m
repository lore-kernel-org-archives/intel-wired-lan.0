From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 25 Feb 2016 20:29:39 +0000
Subject: [Intel-wired-lan] [PATCH 4/6] fm10k: update driver summary
	and	reduce code duplication
In-Reply-To: <1455144351-14758-4-git-send-email-jacob.e.keller@intel.com>
References: <1455144351-14758-1-git-send-email-jacob.e.keller@intel.com>
 <1455144351-14758-4-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2734A972@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Wednesday, February 10, 2016 2:46 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH 4/6] fm10k: update driver summary and reduce code duplication

Use DRV_SUMMARY, similar to DRV_VERSION so that we don't have to duplicate the driver summary. Also update summary to more accurately describe the driver.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

