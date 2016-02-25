From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 25 Feb 2016 20:27:03 +0000
Subject: [Intel-wired-lan] [PATCH 1/6] fm10k: Avoid crashing the kernel
In-Reply-To: <1455144351-14758-1-git-send-email-jacob.e.keller@intel.com>
References: <1455144351-14758-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2734A937@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Wednesday, February 10, 2016 2:46 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH 1/6] fm10k: Avoid crashing the kernel

From: Bruce Allan <bruce.w.allan@intel.com>

Use BUILD_BUG_ON() instead of BUG_ON() where appropriate to get a compile error rather than crash the kernel.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

