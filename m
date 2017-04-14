From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Fri, 14 Apr 2017 22:01:37 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add 1000Base-T device based
	on	X550EM_X MAC
In-Reply-To: <1492085227-52152-1-git-send-email-paul.greenwalt@intel.com>
References: <1492085227-52152-1-git-send-email-paul.greenwalt@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E50B7C20C@ORSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Paul Greenwalt
Sent: Thursday, April 13, 2017 5:07 AM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add 1000Base-T device based on X550EM_X MAC

Add support for new 1000Base-T device based on X550EM_X MAC type. All PHY operations are disabled as the PHY is controlled by FW.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>



