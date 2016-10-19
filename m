From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 19 Oct 2016 22:42:51 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: set device if before
	calling	get_invariants
In-Reply-To: <20161012193425.20797.48614.stgit@localhost6.localdomain6>
References: <20161012193425.20797.48614.stgit@localhost6.localdomain6>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E42E3AE2A@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Emil Tantilov
Sent: Wednesday, October 12, 2016 12:34 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH] ixgbe: set device if before calling get_invariants

Fix an issue where set_phy_power was NULL for X550 copper devices because get_invariants was called before hw->device_id was set.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

