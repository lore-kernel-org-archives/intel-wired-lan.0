From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 28 Mar 2017 16:00:17 +0000
Subject: [Intel-wired-lan] [PATCH 4/5] fm10k: update function header
 comment	for fm10k_get_stats64
In-Reply-To: <20170112235942.5767-4-jacob.e.keller@intel.com>
References: <20170112235942.5767-1-jacob.e.keller@intel.com>
 <20170112235942.5767-4-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E491465D8@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Thursday, January 12, 2017 4:00 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH 4/5] fm10k: update function header comment for fm10k_get_stats64

Re-word the comment to avoid stating that we return a value for this void function. Additionally, there is no need to mention older kernels, since this is the upstream kernel.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

