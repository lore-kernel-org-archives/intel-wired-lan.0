From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 27 Oct 2015 19:51:37 +0000
Subject: [Intel-wired-lan] [next-queue v5 08/17] fm10k: add statistics
 for	actual DWORD count of mbmem mailbox
In-Reply-To: <1445018231-3196-8-git-send-email-jacob.e.keller@intel.com>
References: <1445018231-3196-1-git-send-email-jacob.e.keller@intel.com>
 <1445018231-3196-8-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27221649@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Friday, October 16, 2015 10:57 AM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [next-queue v5 08/17] fm10k: add statistics for actual DWORD count of mbmem mailbox

A previous bug was uncovered by addition of a debug stat to indicate the actual number of DWORDS we pulled from the mbmem. It turned out this was not the same as the tx_dwords counter. While the previous bug fix should have corrected this in all cases, add some debug stats that count the number of DWORDs pushed or pulled from the mbmem. A future debugger may take advantage of this statistic for debugging purposes. Since we're modifying fm10k_mbx.h, update the copyright year as well.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


