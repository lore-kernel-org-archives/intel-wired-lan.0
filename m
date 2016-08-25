From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 25 Aug 2016 23:39:05 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: remove fm10k_get_reta_size
 from	namespace
In-Reply-To: <20160617213645.11660-1-jacob.e.keller@intel.com>
References: <20160617213645.11660-1-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E273B949E@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Friday, June 17, 2016 2:37 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH] fm10k: remove fm10k_get_reta_size from namespace

The function is only used in fm10k_ethtool.c, so make it static.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

