From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 12 Dec 2016 17:18:20 +0000
Subject: [Intel-wired-lan] [PATCH 1/4] fm10k-shared: use mac-> instead
 of	hw->mac.
In-Reply-To: <20161102234447.17181-1-jacob.e.keller@intel.com>
References: <20161102234447.17181-1-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E490F526C@ORSMSX103.amr.corp.intel.com>
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
Subject: [Intel-wired-lan] [PATCH 1/4] fm10k-shared: use mac-> instead of hw->mac.

From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>

Since a pointer "mac" to fm10k_mac_info structure exists, use it to access the contents of its members.

Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

