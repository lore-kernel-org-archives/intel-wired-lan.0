From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Nov 2016 23:38:30 +0000
Subject: [Intel-wired-lan] [PATCH V2] ixgbevf: Handle
	previously-freed	msix_entries
In-Reply-To: <147767679915.21196.12625601185481181813.stgit@mdrustad-wks.jf.intel.com>
References: <147767679915.21196.12625601185481181813.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E42E43998@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Mark D Rustad
Sent: Friday, October 28, 2016 10:47 AM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH V2] ixgbevf: Handle previously-freed msix_entries

The msix_entries memory can be freed by a previous suspend or remove, so don't crash on close when it isn't there. Also only clear the interrupts when the interface is up, because there aren't any when it is not up.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

