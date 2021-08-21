From: Julia Lawall <julia.lawall@inria.fr>
Date: Sat, 21 Aug 2021 12:36:27 +0200 (CEST)
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue 101/126]
 drivers/net/ethernet/intel/ice/ice_tc_lib.c:673:36-61: WARNING avoid
 newline at end of message in NL_SET_ERR_MSG_MOD (fwd)
Message-ID: <alpine.DEB.2.22.394.2108211234180.4015@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

A newline is not needed at the end of the string on line 673.  Could
consider whether to capitalize the first word in this string as well, and
in the second call on line 676.

julia

---------- Forwarded message ----------
Date: Sat, 21 Aug 2021 15:30:34 +0800
From: kernel test robot <lkp@intel.com>
To: kbuild@lists.01.org
Cc: lkp at intel.com, Julia Lawall <julia.lawall@lip6.fr>
Subject: [tnguy-next-queue:dev-queue 101/126]
    drivers/net/ethernet/intel/ice/ice_tc_lib.c:673:36-61: WARNING avoid newline
     at end of message in NL_SET_ERR_MSG_MOD

CC: kbuild-all at lists.01.org
CC: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
CC: linux-kernel at vger.kernel.org
TO: Kiran Patil <kiran.patil@intel.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: Priyalee Kushwaha <priyalee.kushwaha@intel.com>
CC: Wojciech Drewek <wojciech.drewek@intel.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   69bbbd98f4a8fc0e241aa3a01a34985eba06fb0b
commit: 8ef5de630bd1efb718cddc57430f23ef7ed79cf2 [101/126] ice: ndo_setup_tc implementation for PF
:::::: branch date: 13 hours ago
:::::: commit date: 13 hours ago
config: ia64-randconfig-c024-20210821 (attached as .config)
compiler: ia64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>


cocci warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/intel/ice/ice_tc_lib.c:673:36-61: WARNING avoid newline at end of message in NL_SET_ERR_MSG_MOD

vim +673 drivers/net/ethernet/intel/ice/ice_tc_lib.c

8ef5de630bd1ef Kiran Patil 2021-08-06  653
8ef5de630bd1ef Kiran Patil 2021-08-06  654  /**
8ef5de630bd1ef Kiran Patil 2021-08-06  655   * ice_del_tc_fltr - deletes a filter from HW table
8ef5de630bd1ef Kiran Patil 2021-08-06  656   * @vsi: Pointer to VSI
8ef5de630bd1ef Kiran Patil 2021-08-06  657   * @fltr: Pointer to struct ice_tc_flower_fltr
8ef5de630bd1ef Kiran Patil 2021-08-06  658   *
8ef5de630bd1ef Kiran Patil 2021-08-06  659   * This function deletes a filter from HW table and manages book-keeping
8ef5de630bd1ef Kiran Patil 2021-08-06  660   */
8ef5de630bd1ef Kiran Patil 2021-08-06  661  static int ice_del_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
8ef5de630bd1ef Kiran Patil 2021-08-06  662  {
8ef5de630bd1ef Kiran Patil 2021-08-06  663  	struct ice_rule_query_data rule_rem;
8ef5de630bd1ef Kiran Patil 2021-08-06  664  	struct ice_pf *pf = vsi->back;
8ef5de630bd1ef Kiran Patil 2021-08-06  665  	int err;
8ef5de630bd1ef Kiran Patil 2021-08-06  666
8ef5de630bd1ef Kiran Patil 2021-08-06  667  	rule_rem.rid = fltr->rid;
8ef5de630bd1ef Kiran Patil 2021-08-06  668  	rule_rem.rule_id = fltr->rule_id;
8ef5de630bd1ef Kiran Patil 2021-08-06  669  	rule_rem.vsi_handle = fltr->dest_id;
8ef5de630bd1ef Kiran Patil 2021-08-06  670  	err = ice_rem_adv_rule_by_id(&pf->hw, &rule_rem);
8ef5de630bd1ef Kiran Patil 2021-08-06  671  	if (err) {
8ef5de630bd1ef Kiran Patil 2021-08-06  672  		if (err == ICE_ERR_DOES_NOT_EXIST) {
8ef5de630bd1ef Kiran Patil 2021-08-06 @673  			NL_SET_ERR_MSG_MOD(fltr->extack, "filter does not exist\n");
8ef5de630bd1ef Kiran Patil 2021-08-06  674  			return -ENOENT;
8ef5de630bd1ef Kiran Patil 2021-08-06  675  		}
8ef5de630bd1ef Kiran Patil 2021-08-06  676  		NL_SET_ERR_MSG_MOD(fltr->extack, "Failed to delete TC flower filter");
8ef5de630bd1ef Kiran Patil 2021-08-06  677  		return -EIO;
8ef5de630bd1ef Kiran Patil 2021-08-06  678  	}
8ef5de630bd1ef Kiran Patil 2021-08-06  679
8ef5de630bd1ef Kiran Patil 2021-08-06  680  	return 0;
8ef5de630bd1ef Kiran Patil 2021-08-06  681  }
8ef5de630bd1ef Kiran Patil 2021-08-06  682

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 35177 bytes
Desc: 
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210821/c48b6af0/attachment-0001.bin>
