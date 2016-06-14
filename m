From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 14 Jun 2016 16:31:49 +0000
Subject: [Intel-wired-lan] [next-queue PATCH] fm10k: Align Rx buffers
	to	512B blocks
In-Reply-To: <20160415170046.3137.8553.stgit@ahduyck-xeon-server>
References: <20160415170046.3137.8553.stgit@ahduyck-xeon-server>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27395485@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Alexander Duyck
Sent: Friday, April 15, 2016 10:01 AM
To: intel-wired-lan@lists.osuosl.org; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; alexander.duyck at gmail.com
Subject: [Intel-wired-lan] [next-queue PATCH] fm10k: Align Rx buffers to 512B blocks

While reviewing the i40e driver changes to support page based receive I realized that I had overlooked the fact that the fm10k hardware required a
512 byte alignment for Rx buffers.  This patch is meant to address that by changing the alignment for Rx buffers to 512 bytes instead of allowing it to be L1 cache aligned.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

