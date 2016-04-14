From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 14 Apr 2016 22:50:14 +0000
Subject: [Intel-wired-lan] [PATCH 4/5] fm10k: Add support for bulk Tx
 cleanup & cleanup boolean logic
In-Reply-To: <20160307173015.5682.15247.stgit@localhost.localdomain>
References: <20160307172722.5682.38580.stgit@localhost.localdomain>
 <20160307173015.5682.15247.stgit@localhost.localdomain>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27372E43@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Alexander Duyck
Sent: Monday, March 7, 2016 9:30 AM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH 4/5] fm10k: Add support for bulk Tx cleanup & cleanup boolean logic

This patch enables bulk free in Tx cleanup for fm10k and cleans up the boolean logic in the polling routines for fm10k in the hopes of avoiding any mix-ups similar to what occurred with i40e and i40evf.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

