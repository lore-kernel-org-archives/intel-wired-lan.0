From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 9 Apr 2020 18:09:55 +0000
Subject: [Intel-wired-lan] [next-queue v2] i40e: Add a check to see if
 MFS is set
In-Reply-To: <20200407221139.2233977-1-jeffrey.t.kirsher@intel.com>
References: <20200407221139.2233977-1-jeffrey.t.kirsher@intel.com>
Message-ID: <4f171aed2dcd4c229ebd5dd5d26c13cb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jeff Kirsher
Sent: Tuesday, April 7, 2020 3:12 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [next-queue v2] i40e: Add a check to see if MFS is set

From: Todd Fujinaka <todd.fujinaka@intel.com>

A customer was chain-booting to provision his systems and one of the steps was setting MFS. MFS isn't cleared by normal warm reboots (clearing requires a GLOBR) and there was no indication of why Jumbo Frame receives were failing.

Add a warning if MFS is set to anything lower than the default.

Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
v2: added missing defines

 drivers/net/ethernet/intel/i40e/i40e_main.c     | 9 +++++++++
 drivers/net/ethernet/intel/i40e/i40e_register.h | 8 ++++++++
 2 files changed, 17 insertions(+)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


