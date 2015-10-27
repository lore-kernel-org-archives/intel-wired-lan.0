From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 27 Oct 2015 17:12:22 +0000
Subject: [Intel-wired-lan] [next-queue v5 09/17] fm10k:
	rename	mbx_tx_oversized statistic to mbx_tx_dropped
In-Reply-To: <1445018231-3196-9-git-send-email-jacob.e.keller@intel.com>
References: <1445018231-3196-1-git-send-email-jacob.e.keller@intel.com>
 <1445018231-3196-9-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E272213CE@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Friday, October 16, 2015 10:57 AM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [next-queue v5 09/17] fm10k: rename mbx_tx_oversized statistic to mbx_tx_dropped

Originally this statistic was renamed because the method of dropping was called "drop_oversized_messages", but this logic has changed much, and this counter does actually represent messages which we failed to transmit for a number of reasons. Rename the counter back to tx_dropped since this is when it will increment, and it is less confusing.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


