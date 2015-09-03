From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 3 Sep 2015 22:22:12 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Avoid needless phy access
	on	copper phys
In-Reply-To: <20150626004957.67855.1341.stgit@mdrustad-wks.jf.intel.com>
References: <20150626004957.67855.1341.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B62B6@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Mark D Rustad
Sent: Thursday, June 25, 2015 5:50 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH] ixgbe: Avoid needless phy access on copper phys

Avoid a needless phy access on copper phys to save the 10ms wait time for each phy access. A helper function is introduced to actually do the register access and process the contents.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---

Tested-By: Krishneil Singh <Krishneil.k.singh@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
