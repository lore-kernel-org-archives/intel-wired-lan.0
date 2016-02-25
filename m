From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 25 Feb 2016 20:26:31 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] fm10k: Avoid crashing the kernel
In-Reply-To: <1455668365-30782-2-git-send-email-jacob.e.keller@intel.com>
References: <1455668365-30782-1-git-send-email-jacob.e.keller@intel.com>
 <1455668365-30782-2-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2734A923@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Tuesday, February 16, 2016 4:19 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH 2/2] fm10k: Avoid crashing the kernel

Use BUILD_BUG_ON() instead of BUG_ON() where appropriate to get a compile error rather than crash the kernel.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

