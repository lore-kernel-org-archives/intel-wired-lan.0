From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 31 May 2016 18:11:47 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/4] fm10k: fix possible null
 pointer	deref after kcalloc
In-Reply-To: <1460042483-16169-1-git-send-email-jacob.e.keller@intel.com>
References: <1460042483-16169-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2738EBCA@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Thursday, April 7, 2016 8:21 AM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v1 1/4] fm10k: fix possible null pointer deref after kcalloc

When writing a new default redirection table, we needed to populate a new RSS table using ethtool_rxfh_indir_default. We populated this table into a region of memory allocated using kcalloc, but never checked this for NULL. Fix this by moving the default table generation into fm10k_write_reta. If this function is passed a table, use it. Otherwise, generate the default table using ethtool_rxfh_indir_default, 4 at at time.

Fixes: 0ea7fae44094 ("fm10k: use ethtool_rxfh_indir_default for default redirection table", 2016-02-16)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

