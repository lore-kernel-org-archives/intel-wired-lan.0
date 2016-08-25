From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 25 Aug 2016 23:39:54 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: prefer READ_ONCE instead
	of	ACCESS_ONCE
In-Reply-To: <20160617232111.27182-1-jacob.e.keller@intel.com>
References: <20160617232111.27182-1-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E273B94B2@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Friday, June 17, 2016 4:21 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH] fm10k: prefer READ_ONCE instead of ACCESS_ONCE

While technically not needed, as all our uses of ACCESS_ONCE are scalar types, we already use READ_ONCE in a few places, and for code readability we can swap all the uses of the older ACCESS_ONCE into READ_ONCE.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

