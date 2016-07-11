From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 11 Jul 2016 19:26:21 +0000
Subject: [Intel-wired-lan] [PATCH v2] fm10k: use software values
	when	checking for Tx hangs in hot path
In-Reply-To: <20160609215605.19957-1-jacob.e.keller@intel.com>
References: <20160609215605.19957-1-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E273A1893@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Thursday, June 9, 2016 2:56 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v2] fm10k: use software values when checking for Tx hangs in hot path

A previous patch added support to check for hardware tx pending in the fm10k_down routine. This support was intended to ensure that we accurately check what the hardware state is. However, checking for Tx hangs in this manor during the hotpath results in a large performance hit. Avoid this by making the hotpath check use the SW counters instead.

Fixes: a0f53cf49cb0 ("fm10k: use actual hardware registers when checking for pending Tx", 2016-06-08)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---


Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

