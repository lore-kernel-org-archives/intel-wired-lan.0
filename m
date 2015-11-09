From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 9 Nov 2015 22:37:07 +0000
Subject: [Intel-wired-lan] [next-queue PATCH] fm10k: do not
	inline	fm10k_iov_select_vid()
In-Reply-To: <20151028230440.10576.56731.stgit@bwallan-cwp1.jf.intel.com>
References: <20151028230440.10576.56731.stgit@bwallan-cwp1.jf.intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27232BDC@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Bruce Allan
Sent: Wednesday, October 28, 2015 4:05 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [next-queue PATCH] fm10k: do not inline fm10k_iov_select_vid()

The function declaration does not need to be 'inline'd here.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

