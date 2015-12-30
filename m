From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 30 Dec 2015 00:13:19 +0000
Subject: [Intel-wired-lan] [next-queue PATCH] fm10k: demote BUG_ON() to
 WARN_ON() where appropriate
In-Reply-To: <20151222225520.141575.84032.stgit@bwallan-cwp1.jf.intel.com>
References: <20151222225520.141575.84032.stgit@bwallan-cwp1.jf.intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E273208DA@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Bruce Allan
Sent: Tuesday, December 22, 2015 2:55 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [next-queue PATCH] fm10k: demote BUG_ON() to WARN_ON() where appropriate

We don't need to crash the kernel in this instance so just warn about the condition and play on.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


