From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Nov 2016 23:44:25 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Handle
	previously-freed	msix_entries
In-Reply-To: <147510219815.65927.11331530245019014313.stgit@mdrustad-wks.jf.intel.com>
References: <147510219815.65927.11331530245019014313.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E42E439B9@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Mark D Rustad
Sent: Wednesday, September 28, 2016 3:37 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH] ixgbe: Handle previously-freed msix_entries

The msix_entries memory can be freed by a previous suspend or remove, so don't crash on close when it isn't there.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---


Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>


