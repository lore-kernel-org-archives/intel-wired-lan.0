From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 3 Sep 2015 21:22:45 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix bounds checking
	in	ixgbe_setup_tc for 82598
In-Reply-To: <20150713185851.12746.72369.stgit@localhost6.localdomain6>
References: <20150713185851.12746.72369.stgit@localhost6.localdomain6>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B6225@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Emil Tantilov
Sent: Monday, July 13, 2015 11:59 AM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix bounds checking in ixgbe_setup_tc for 82598

This patch resolves an issue where users were not able to dynamically set number of queues for 82598 via ethtool -L

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reported-by: Tal Abudi <talabudi@gmail.com>
---
 
Tested-By: Krishneil Singh <Krishneil.k.singh@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
