From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 16 Dec 2015 02:46:02 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] fm10k: constify fm10k_mac_ops,
 fm10k_iov_ops and fm10k_info structures
In-Reply-To: <20151208235039.125723.9402.stgit@bwallan-cwp1.jf.intel.com>
References: <20151208235034.125723.15232.stgit@bwallan-cwp1.jf.intel.com>
 <20151208235039.125723.9402.stgit@bwallan-cwp1.jf.intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27313AEF@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Bruce Allan
Sent: Tuesday, December 8, 2015 3:51 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH 2/2] fm10k: constify fm10k_mac_ops, fm10k_iov_ops and fm10k_info structures

These structures never change so declare them as const.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

