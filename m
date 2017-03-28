From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 28 Mar 2017 15:57:37 +0000
Subject: [Intel-wired-lan] [PATCH 2/5] fm10k: future-proof state
	bitmaps	using DECLARE_BITMAP
In-Reply-To: <20170112235942.5767-2-jacob.e.keller@intel.com>
References: <20170112235942.5767-1-jacob.e.keller@intel.com>
 <20170112235942.5767-2-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E49146598@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Thursday, January 12, 2017 4:00 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH 2/5] fm10k: future-proof state bitmaps using DECLARE_BITMAP

This ensures that future programmers do not have to remember to re-size the bitmaps due to adding new values. Although this is unlikely for this driver, it may happen and it's best to prevent it from ever being an issue.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

