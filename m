From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 13 Dec 2016 17:01:24 +0000
Subject: [Intel-wired-lan] [PATCH 4/4] fm10k: do not clear global
 mailbox	interrupt bits
In-Reply-To: <20161102234447.17181-4-jacob.e.keller@intel.com>
References: <20161102234447.17181-1-jacob.e.keller@intel.com>
 <20161102234447.17181-4-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E490F59B5@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Wednesday, November 2, 2016 4:45 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Kwan, Ngai-mint <ngai-mint.kwan@intel.com>
Subject: [Intel-wired-lan] [PATCH 4/4] fm10k: do not clear global mailbox interrupt bits

From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>

Partially revert commit 5e93cbadd3e9 ("fm10k: Reset mailbox global interrupts", 2016-06-07)

The register bits related to this commit are now solely being handled by the IES API. Recent changes in the IES API will allow an automatic recovery from improper handling of these bits.

Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

