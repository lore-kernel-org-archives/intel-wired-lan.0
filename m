From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 28 Mar 2017 15:41:44 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: correctly check if interface
 is	removed.
In-Reply-To: <20161123183358.16851-1-phil.turnbull@oracle.com>
References: <20161123183358.16851-1-phil.turnbull@oracle.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E491464C0@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Phil Turnbull
Sent: Wednesday, November 23, 2016 10:34 AM
To: intel-wired-lan@lists.osuosl.org
Cc: Phil Turnbull <phil.turnbull@oracle.com>
Subject: [Intel-wired-lan] [PATCH] fm10k: correctly check if interface is removed.

FM10K_REMOVED expects a hardware address, not a 'struct fm10k_hw'.

Fixes: 5cb8db4a4cbc ("fm10k: Add support for VF")
Signed-off-by: Phil Turnbull <phil.turnbull@oracle.com>
---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>


