From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 28 Oct 2015 00:47:18 +0000
Subject: [Intel-wired-lan] [next-queue 05/17] fm10k: always check
 init_hw	for errors
In-Reply-To: <1444779554-20464-5-git-send-email-jacob.e.keller@intel.com>
References: <1444779554-20464-1-git-send-email-jacob.e.keller@intel.com>
 <1444779554-20464-5-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27221978@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Tuesday, October 13, 2015 4:39 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [next-queue 05/17] fm10k: always check init_hw for errors

A recent change to the SHARED code makes it such that in some flows, init_hw may fail. For example, init_hw_vf will fail if the 1st queue is not owned by the VF. However, previously some flows called init_hw without checking the return code, or checked it but only to display a diagnostic message.

Fix this by (a) always returning and preventing the netdevice from going up, and (b) printing the diagnostic in every flow for consistency. This should resolve an issue where VF drivers would attempt to come up before the PF has finished assigning queues.

In addition, change the dmesg output to explicitly show the actual function that failed, instead of combining reset_hw and init_hw into a single check.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


