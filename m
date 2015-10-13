From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 13 Oct 2015 13:37:04 +0200
Subject: [Intel-wired-lan] [PATCH] i40evf: fix 32 bit build warnings
In-Reply-To: <1444717101.2870.16.camel@intel.com>
References: <6607276.TY67sbLLqL@wuerfel> <1444717101.2870.16.camel@intel.com>
Message-ID: <57023416.17EujnXPCo@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Monday 12 October 2015 23:18:21 you wrote:
> On Wed, 2015-10-07 at 22:13 +0200, Arnd Bergmann wrote:
> > Jesse Brandeburg fixed a bug for 32-bit systems in the i40e driver
> > in commit 9c70d7cebfec5 ("i40e: fix 32 bit build warnings"), but the
> > same code still exists in the i40evf driver and causes compilation
> > warnings in ARM and x86 allmodconfig:
> > 
> > drivers/net/ethernet/intel/i40evf/i40e_common.c:445:68: warning: cast
> > from pointer to integer of different size [-Wpointer-to-int-cast]
> > drivers/net/ethernet/intel/i40evf/i40e_common.c:446:71: warning: cast
> > from pointer to integer of different size [-Wpointer-to-int-cast]
> > 
> > This applies the same fix by removing the broken code.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Does not apply at all to my next-queue tree (dev-queue branch), my
> guess is that this is already fixed in one of the patches already in my
> queue.
> 

I still get these warnings on your branch:

/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c: In function 'i40e_aq_get_set_rss_lut':
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:446:68: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:446:128: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:446:207: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:446:285: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:446:363: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:446:444: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:447:71: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:447:115: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:447:178: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:447:240: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:447:302: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:447:367: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c: In function 'i40e_aq_get_set_rss_key':
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:523:68: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:523:128: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:523:207: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:523:285: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:523:363: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:523:444: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:524:71: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:524:115: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:524:178: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:524:240: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:524:302: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
/git/arm-soc/drivers/net/ethernet/intel/i40evf/i40e_common.c:524:367: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]

This is the majority of all build warnings we get on allmodconfig (both i386 and arm),
so it would be really nice to have it fixed before 4.3. For all I can tell, the
patch still applies on your branch too, but see below for the rebased version.

I also note that your branch is not part of linux-next, is that intentional?

	Arnd

8<-------
From e6245d40a1ad7faa9064c23aa3d737d67d628683 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Oct 2015 21:56:09 +0200
Subject: [PATCH] i40evf: fix 32 bit build warnings

Jesse Brandeburg fixed a bug for 32-bit systems in the i40e driver
in commit 9c70d7cebfec5 ("i40e: fix 32 bit build warnings"), but the
same code still exists in the i40evf driver and causes compilation
warnings in ARM and x86 allmodconfig:

drivers/net/ethernet/intel/i40evf/i40e_common.c:445:68: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40evf/i40e_common.c:446:71: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]

This applies the same fix by removing the broken code.

Cc: kbuild-all at 01.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Andrew Bowers <andrewx.bowers@intel.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/net/ethernet/intel/i40evf/i40e_common.c b/drivers/net/ethernet/intel/i40evf/i40e_common.c
index b98b642b897a..a98a31f1e246 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_common.c
@@ -443,9 +443,6 @@ static i40e_status i40e_aq_get_set_rss_lut(struct i40e_hw *hw,
 					I40E_AQC_SET_RSS_LUT_TABLE_TYPE_SHIFT) &
 					I40E_AQC_SET_RSS_LUT_TABLE_TYPE_MASK));
 
-	cmd_resp->addr_high = cpu_to_le32(high_16_bits((u64)lut));
-	cmd_resp->addr_low = cpu_to_le32(lower_32_bits((u64)lut));
-
 	status = i40evf_asq_send_command(hw, &desc, lut, lut_size, NULL);
 
 	return status;
@@ -520,8 +517,6 @@ static i40e_status i40e_aq_get_set_rss_key(struct i40e_hw *hw,
 					  I40E_AQC_SET_RSS_KEY_VSI_ID_SHIFT) &
 					  I40E_AQC_SET_RSS_KEY_VSI_ID_MASK));
 	cmd_resp->vsi_id |= cpu_to_le16((u16)I40E_AQC_SET_RSS_KEY_VSI_VALID);
-	cmd_resp->addr_high = cpu_to_le32(high_16_bits((u64)key));
-	cmd_resp->addr_low = cpu_to_le32(lower_32_bits((u64)key));
 
 	status = i40evf_asq_send_command(hw, &desc, key, key_size, NULL);
 

