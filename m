From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 27 Oct 2015 16:53:29 +0000
Subject: [Intel-wired-lan] [next-queue v2] fm10k: do not assume VF
 always	has 1 queue
In-Reply-To: <1440462444-32504-1-git-send-email-jacob.e.keller@intel.com>
References: <1440462444-32504-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27221358@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Monday, August 24, 2015 5:27 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [next-queue v2] fm10k: do not assume VF always has 1 queue

It is possible that the PF has not yet assigned resources to the VF.
Although rare, this could result in the VF attempting to read queues it does not own and result in FUM or THI faults in the PF. To prevent this, check queue 0 before we continue in init_hw_vf.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


