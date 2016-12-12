From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 12 Dec 2016 17:24:02 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] fm10k: report the receive
 timestamp	in FM10K_CB(skb)->tstamp
In-Reply-To: <20161118174539.30191-1-jacob.e.keller@intel.com>
References: <20161118174539.30191-1-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E490F52C2@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Friday, November 18, 2016 9:46 AM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH 1/2] fm10k: report the receive timestamp in FM10K_CB(skb)->tstamp

This was accidentally removed when we defeatured the full 1588 Clock support. We need to report the Rx descriptor timestamp value so that applications built on top of the IES API can function properly.

Additionally, remove the FM10K_FLAG_RX_TS_ENABLED, as it is not used now that 1588 functionality has been removed.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

