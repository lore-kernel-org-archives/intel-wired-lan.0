From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 11 Jul 2016 19:24:07 +0000
Subject: [Intel-wired-lan] [PATCH v1 02/18] fm10k: avoid possible
	null	pointer dereference in fm10k_update_stats
In-Reply-To: <20160603224228.10192-3-jacob.e.keller@intel.com>
References: <20160603224228.10192-1-jacob.e.keller@intel.com>
 <20160603224228.10192-3-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E273A1863@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Friday, June 3, 2016 3:42 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v1 02/18] fm10k: avoid possible null pointer dereference in fm10k_update_stats

It's currently possible for fm10k_update_stats to be called during the window when we go down and the rings are removed. This can result in a null pointer dereference. In fm10k_get_stats64 we work around this by using ACCESS_ONCE and a null pointer check inside the loop. Use this same flow in the fm10k_update_stats to avoid the potential null pointer.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---


Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

