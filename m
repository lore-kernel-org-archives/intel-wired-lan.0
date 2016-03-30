From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 30 Mar 2016 22:50:03 +0000
Subject: [Intel-wired-lan] [PATCH v6 2/2] fm10k: remove
	remove	debug-statistics support
In-Reply-To: <1457134668-19142-3-git-send-email-jacob.e.keller@intel.com>
References: <1457134668-19142-1-git-send-email-jacob.e.keller@intel.com>
 <1457134668-19142-3-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2735B11F@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Friday, March 4, 2016 3:38 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v6 2/2] fm10k: remove remove debug-statistics support

This change fixes an (ab)use of the ethtool stats API, which could result in corrupt memory or misleading stat output. The ethtool stats API is not robust enough to handle varying number of statistics due to how it requests the size and allocates memory. Remove the poorly conceived support originally added for extra debug statistics. In the future, a new stats api may open up the ability to display these statistics.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>



