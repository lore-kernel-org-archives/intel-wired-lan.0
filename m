From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 12 Dec 2016 17:24:49 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] fm10k: remove
 FM10K_FLAG_DEBUG_STATS
In-Reply-To: <20161118174539.30191-2-jacob.e.keller@intel.com>
References: <20161118174539.30191-1-jacob.e.keller@intel.com>
 <20161118174539.30191-2-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E490F52D6@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Friday, November 18, 2016 9:46 AM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH 2/2] fm10k: remove FM10K_FLAG_DEBUG_STATS

The debug statistics were removed due to complications with the ethtool statistics API which are not possible to resolve without a new statistics interface. The flag was left behind, but we no longer need it.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

