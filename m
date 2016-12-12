From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 12 Dec 2016 17:51:52 +0000
Subject: [Intel-wired-lan] [PATCH 2/4] fm10k: remove extraneous
	variable	definition in fm10k_ethtool.c
In-Reply-To: <20161102234447.17181-2-jacob.e.keller@intel.com>
References: <20161102234447.17181-1-jacob.e.keller@intel.com>
 <20161102234447.17181-2-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E490F5339@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Wednesday, November 2, 2016 4:45 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH 2/4] fm10k: remove extraneous variable definition in fm10k_ethtool.c

We don't need to typecast a u8 * into a char *, so just remove the extra variable.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

