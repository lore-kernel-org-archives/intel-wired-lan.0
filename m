From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 22 Apr 2020 18:49:03 +0000
Subject: [Intel-wired-lan] [net-next v2] i40e: Add a check to see if MFS
 is set
In-Reply-To: <20200421221734.503494-1-jeffrey.t.kirsher@intel.com>
References: <20200421221734.503494-1-jeffrey.t.kirsher@intel.com>
Message-ID: <38c988b9d043460a804500d8c765af85@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jeff Kirsher
Sent: Tuesday, April 21, 2020 3:18 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [net-next v2] i40e: Add a check to see if MFS is set

From: Todd Fujinaka <todd.fujinaka@intel.com>

A customer was chain-booting to provision his systems and one of the steps was setting MFS. MFS isn't cleared by normal warm reboots (clearing requires a GLOBR) and there was no indication of why Jumbo Frame receives were failing.

Add a warning if MFS is set to anything lower than the default.

Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
---
v2: fix the math calculation on accessing the SAH register

 drivers/net/ethernet/intel/i40e/i40e_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)



Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
