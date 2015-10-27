From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 27 Oct 2015 17:08:56 +0000
Subject: [Intel-wired-lan] [PATCH 3/3] fm10k: use napi_schedule_irqoff()
In-Reply-To: <20150929221956.3388.23153.stgit@ahduyck-vm-fedora22>
References: <20150929215117.3388.48642.stgit@ahduyck-vm-fedora22>
 <20150929221956.3388.23153.stgit@ahduyck-vm-fedora22>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2722139C@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Alexander Duyck
Sent: Tuesday, September 29, 2015 3:20 PM
To: netdev@vger.kernel.org; intel-wired-lan at lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH 3/3] fm10k: use napi_schedule_irqoff()

The fm10k_msix_clean_rings function runs from hard interrupt context or with interrupts already disabled in netpoll.

It can use napi_schedule_irqoff() instead of napi_schedule()

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


