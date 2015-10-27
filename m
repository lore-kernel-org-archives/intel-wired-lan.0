From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 27 Oct 2015 17:06:04 +0000
Subject: [Intel-wired-lan] [net PATCH 2/3] fm10k: Fix handling of napi
 budget when multiple queues are enabled per vector
In-Reply-To: <20150922213535.2774.9863.stgit@ahduyck-vm-fedora22>
References: <20150922213002.2774.37924.stgit@ahduyck-vm-fedora22>
 <20150922213535.2774.9863.stgit@ahduyck-vm-fedora22>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27221380@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Alexander Duyck
Sent: Tuesday, September 22, 2015 2:36 PM
To: netdev@vger.kernel.org; intel-wired-lan at lists.osuosl.org
Subject: [Intel-wired-lan] [net PATCH 2/3] fm10k: Fix handling of napi budget when multiple queues are enabled per vector

This patch corrects an issue in which the polling routine would increase the budget for Rx to at least 1 per queue if multiple queues were present.
This would result in Rx packets being processed when the budget was 0 which is meant to indicate that no Rx can be handled.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


