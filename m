From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 13 Apr 2016 22:42:19 +0000
Subject: [Intel-wired-lan] [PATCH v1 3/4] fm10k: fix
 fm10k_add_ethtool_stats	to zero memory
In-Reply-To: <1460042483-16169-3-git-send-email-jacob.e.keller@intel.com>
References: <1460042483-16169-1-git-send-email-jacob.e.keller@intel.com>
 <1460042483-16169-3-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E273714FC@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Thursday, April 7, 2016 8:21 AM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v1 3/4] fm10k: fix fm10k_add_ethtool_stats to zero memory

The ethtool API does not guarantee zero'd memory, so we need to zero the stats we skip instead of just skipping them.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---


Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

