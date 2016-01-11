From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 11 Jan 2016 23:22:24 +0000
Subject: [Intel-wired-lan] [next-queue PATCH 2/2] fm10k: cleanup
 remaining	right-bit-shifted 1
In-Reply-To: <20151222214349.42447.44013.stgit@bwallan-cwp1.jf.intel.com>
References: <20151222214344.42447.71576.stgit@bwallan-cwp1.jf.intel.com>
 <20151222214349.42447.44013.stgit@bwallan-cwp1.jf.intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27325C6C@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Bruce Allan
Sent: Tuesday, December 22, 2015 1:44 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [next-queue PATCH 2/2] fm10k: cleanup remaining right-bit-shifted 1

Use BIT() macro instead.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

