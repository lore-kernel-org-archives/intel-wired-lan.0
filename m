From: Brandeburg, Jesse <jesse.brandeburg@intel.com>
Date: Thu, 18 Feb 2016 00:36:18 +0000
Subject: [Intel-wired-lan] [next PATCH S29 12/14] i40e: Fix for the
	NPAR	PSOD issue
In-Reply-To: <1455754344-6372-13-git-send-email-avinash.dayanand@intel.com>
References: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
 <1455754344-6372-13-git-send-email-avinash.dayanand@intel.com>
Message-ID: <253CF818969A9240AB2054BF91F2C2BC37734421@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The title of this patch must be fixed.

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Avinash Dayanand
Sent: Wednesday, February 17, 2016 4:12 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [next PATCH S29 12/14] i40e: Fix for the NPAR PSOD issue

From: Pandi Kumar Maharajan <pandi.maharajan@intel.com>

We need to suspend scheduling or any pending service task during driver
unload process, so that new task will not be scheduled. This patch sets
the suspend flag bit during reload which avoids service task execution.

Signed-off-by: Pandi Kumar Maharajan <pandi.maharajan@intel.com>
Change-ID: I017c57b5d6656564556e3c5387da671369a572ac
