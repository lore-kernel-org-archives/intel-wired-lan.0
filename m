From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 30 Dec 2015 00:14:09 +0000
Subject: [Intel-wired-lan] [next-queue PATCH] fm10k: Avoid crashing
	the	kernel
In-Reply-To: <20151222221012.91665.98612.stgit@bwallan-cwp1.jf.intel.com>
References: <20151222221012.91665.98612.stgit@bwallan-cwp1.jf.intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E273208EF@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Bruce Allan
Sent: Tuesday, December 22, 2015 2:10 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [next-queue PATCH] fm10k: Avoid crashing the kernel

Use BUILD_BUG_ON() instead of BUG_ON() where appropriate to get a compile error rather than crash the kernel.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


