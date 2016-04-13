From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 13 Apr 2016 22:30:51 +0000
Subject: [Intel-wired-lan] [PATCH v7] fm10k: add helper functions to
	set	strings and data for ethtool stats
In-Reply-To: <1459534509-4972-2-git-send-email-jacob.e.keller@intel.com>
References: <1459534509-4972-1-git-send-email-jacob.e.keller@intel.com>
 <1459534509-4972-2-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2737140D@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Friday, April 1, 2016 11:15 AM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v7] fm10k: add helper functions to set strings and data for ethtool stats

Reduce duplicate code and the amount of indentation by adding fm10k_add_stat_strings and fm10k_add_ethtool_stats functions which help add fm10k_stat structures to the ethtool stats callbacks. This helps increase ease of use for future stat additions, and increases code readability.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

