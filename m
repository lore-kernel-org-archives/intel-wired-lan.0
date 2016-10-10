From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 10 Oct 2016 23:57:15 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: do not use ixgbe specific
 mdio	defines
In-Reply-To: <20160926210813.30339.95294.stgit@localhost6.localdomain6>
References: <20160926210813.30339.95294.stgit@localhost6.localdomain6>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E42E36C13@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Emil Tantilov
Sent: Monday, September 26, 2016 2:08 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: do not use ixgbe specific mdio defines

Replace some ixgbe specific MDIO defines with their equivalent from the kernel.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---

Tested-by: Krishneil Singh <krishneil.k.singh @intel.com>

