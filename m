From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 27 Jun 2017 10:24:44 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 52/57]
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c:161:4: warning: format '%lx'
 expects argument of type 'long unsigned int',
 but argument 3 has type 'u64 {aka long long unsigned int}'
Message-ID: <201706271030.S1SW6d7C%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   ea3e0e4ac54c250449123f82d5d35f5fb53cec9e
commit: d15813888dabcb98b5226a70d4ebcb61de76d05a [52/57] i40e/i40evf: organize and re-number feature flags
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout d15813888dabcb98b5226a70d4ebcb61de76d05a
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/dma-mapping.h:6:0,
                    from include/linux/skbuff.h:34,
                    from include/linux/tcp.h:21,
                    from include/net/tcp.h:24,
                    from drivers/net/ethernet/intel/i40e/i40e.h:30,
                    from drivers/net/ethernet/intel/i40e/i40e_debugfs.c:32:
   drivers/net/ethernet/intel/i40e/i40e_debugfs.c: In function 'i40e_dbg_dump_vsi_seid':
>> drivers/net/ethernet/intel/i40e/i40e_debugfs.c:161:4: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64 {aka long long unsigned int}' [-Wformat=]
       "    flags = 0x%08lx, netdev_registered = %i, current_netdev_flags = 0x%04x\n",
       ^
   include/linux/device.h:1317:51: note: in definition of macro 'dev_info'
    #define dev_info(dev, fmt, arg...) _dev_info(dev, fmt, ##arg)
                                                      ^~~

vim +161 drivers/net/ethernet/intel/i40e/i40e_debugfs.c

02e9c290 Jesse Brandeburg 2013-09-11   26  
02e9c290 Jesse Brandeburg 2013-09-11   27  #ifdef CONFIG_DEBUG_FS
02e9c290 Jesse Brandeburg 2013-09-11   28  
02e9c290 Jesse Brandeburg 2013-09-11   29  #include <linux/fs.h>
02e9c290 Jesse Brandeburg 2013-09-11   30  #include <linux/debugfs.h>
02e9c290 Jesse Brandeburg 2013-09-11   31  
02e9c290 Jesse Brandeburg 2013-09-11  @32  #include "i40e.h"
02e9c290 Jesse Brandeburg 2013-09-11   33  
02e9c290 Jesse Brandeburg 2013-09-11   34  static struct dentry *i40e_dbg_root;
02e9c290 Jesse Brandeburg 2013-09-11   35  
02e9c290 Jesse Brandeburg 2013-09-11   36  /**
02e9c290 Jesse Brandeburg 2013-09-11   37   * i40e_dbg_find_vsi - searches for the vsi with the given seid
b40c82e6 Jeff Kirsher     2015-02-27   38   * @pf - the PF structure to search for the vsi
02e9c290 Jesse Brandeburg 2013-09-11   39   * @seid - seid of the vsi it is searching for
02e9c290 Jesse Brandeburg 2013-09-11   40   **/
02e9c290 Jesse Brandeburg 2013-09-11   41  static struct i40e_vsi *i40e_dbg_find_vsi(struct i40e_pf *pf, int seid)
02e9c290 Jesse Brandeburg 2013-09-11   42  {
02e9c290 Jesse Brandeburg 2013-09-11   43  	int i;
02e9c290 Jesse Brandeburg 2013-09-11   44  
02e9c290 Jesse Brandeburg 2013-09-11   45  	if (seid < 0)
02e9c290 Jesse Brandeburg 2013-09-11   46  		dev_info(&pf->pdev->dev, "%d: bad seid\n", seid);
02e9c290 Jesse Brandeburg 2013-09-11   47  	else
505682cd Mitch Williams   2014-05-20   48  		for (i = 0; i < pf->num_alloc_vsi; i++)
02e9c290 Jesse Brandeburg 2013-09-11   49  			if (pf->vsi[i] && (pf->vsi[i]->seid == seid))
02e9c290 Jesse Brandeburg 2013-09-11   50  				return pf->vsi[i];
02e9c290 Jesse Brandeburg 2013-09-11   51  
02e9c290 Jesse Brandeburg 2013-09-11   52  	return NULL;
02e9c290 Jesse Brandeburg 2013-09-11   53  }
02e9c290 Jesse Brandeburg 2013-09-11   54  
02e9c290 Jesse Brandeburg 2013-09-11   55  /**
02e9c290 Jesse Brandeburg 2013-09-11   56   * i40e_dbg_find_veb - searches for the veb with the given seid
b40c82e6 Jeff Kirsher     2015-02-27   57   * @pf - the PF structure to search for the veb
02e9c290 Jesse Brandeburg 2013-09-11   58   * @seid - seid of the veb it is searching for
02e9c290 Jesse Brandeburg 2013-09-11   59   **/
02e9c290 Jesse Brandeburg 2013-09-11   60  static struct i40e_veb *i40e_dbg_find_veb(struct i40e_pf *pf, int seid)
02e9c290 Jesse Brandeburg 2013-09-11   61  {
02e9c290 Jesse Brandeburg 2013-09-11   62  	int i;
02e9c290 Jesse Brandeburg 2013-09-11   63  
02e9c290 Jesse Brandeburg 2013-09-11   64  	for (i = 0; i < I40E_MAX_VEB; i++)
02e9c290 Jesse Brandeburg 2013-09-11   65  		if (pf->veb[i] && pf->veb[i]->seid == seid)
02e9c290 Jesse Brandeburg 2013-09-11   66  			return pf->veb[i];
02e9c290 Jesse Brandeburg 2013-09-11   67  	return NULL;
02e9c290 Jesse Brandeburg 2013-09-11   68  }
02e9c290 Jesse Brandeburg 2013-09-11   69  
02e9c290 Jesse Brandeburg 2013-09-11   70  /**************************************************************
02e9c290 Jesse Brandeburg 2013-09-11   71   * command
02e9c290 Jesse Brandeburg 2013-09-11   72   * The command entry in debugfs is for giving the driver commands
02e9c290 Jesse Brandeburg 2013-09-11   73   * to be executed - these may be for changing the internal switch
02e9c290 Jesse Brandeburg 2013-09-11   74   * setup, adding or removing filters, or other things.  Many of
02e9c290 Jesse Brandeburg 2013-09-11   75   * these will be useful for some forms of unit testing.
02e9c290 Jesse Brandeburg 2013-09-11   76   **************************************************************/
d1da3ac0 Greg Rose        2015-02-27   77  static char i40e_dbg_command_buf[256] = "";
02e9c290 Jesse Brandeburg 2013-09-11   78  
02e9c290 Jesse Brandeburg 2013-09-11   79  /**
02e9c290 Jesse Brandeburg 2013-09-11   80   * i40e_dbg_command_read - read for command datum
02e9c290 Jesse Brandeburg 2013-09-11   81   * @filp: the opened file
02e9c290 Jesse Brandeburg 2013-09-11   82   * @buffer: where to write the data for the user to read
02e9c290 Jesse Brandeburg 2013-09-11   83   * @count: the size of the user's buffer
02e9c290 Jesse Brandeburg 2013-09-11   84   * @ppos: file position offset
02e9c290 Jesse Brandeburg 2013-09-11   85   **/
02e9c290 Jesse Brandeburg 2013-09-11   86  static ssize_t i40e_dbg_command_read(struct file *filp, char __user *buffer,
02e9c290 Jesse Brandeburg 2013-09-11   87  				     size_t count, loff_t *ppos)
02e9c290 Jesse Brandeburg 2013-09-11   88  {
02e9c290 Jesse Brandeburg 2013-09-11   89  	struct i40e_pf *pf = filp->private_data;
02e9c290 Jesse Brandeburg 2013-09-11   90  	int bytes_not_copied;
02e9c290 Jesse Brandeburg 2013-09-11   91  	int buf_size = 256;
02e9c290 Jesse Brandeburg 2013-09-11   92  	char *buf;
02e9c290 Jesse Brandeburg 2013-09-11   93  	int len;
02e9c290 Jesse Brandeburg 2013-09-11   94  
02e9c290 Jesse Brandeburg 2013-09-11   95  	/* don't allow partial reads */
02e9c290 Jesse Brandeburg 2013-09-11   96  	if (*ppos != 0)
02e9c290 Jesse Brandeburg 2013-09-11   97  		return 0;
02e9c290 Jesse Brandeburg 2013-09-11   98  	if (count < buf_size)
02e9c290 Jesse Brandeburg 2013-09-11   99  		return -ENOSPC;
02e9c290 Jesse Brandeburg 2013-09-11  100  
02e9c290 Jesse Brandeburg 2013-09-11  101  	buf = kzalloc(buf_size, GFP_KERNEL);
02e9c290 Jesse Brandeburg 2013-09-11  102  	if (!buf)
02e9c290 Jesse Brandeburg 2013-09-11  103  		return -ENOSPC;
02e9c290 Jesse Brandeburg 2013-09-11  104  
02e9c290 Jesse Brandeburg 2013-09-11  105  	len = snprintf(buf, buf_size, "%s: %s\n",
02e9c290 Jesse Brandeburg 2013-09-11  106  		       pf->vsi[pf->lan_vsi]->netdev->name,
02e9c290 Jesse Brandeburg 2013-09-11  107  		       i40e_dbg_command_buf);
02e9c290 Jesse Brandeburg 2013-09-11  108  
02e9c290 Jesse Brandeburg 2013-09-11  109  	bytes_not_copied = copy_to_user(buffer, buf, len);
02e9c290 Jesse Brandeburg 2013-09-11  110  	kfree(buf);
02e9c290 Jesse Brandeburg 2013-09-11  111  
0286c67e Rasmus Villemoes 2015-10-17  112  	if (bytes_not_copied)
0286c67e Rasmus Villemoes 2015-10-17  113  		return -EFAULT;
02e9c290 Jesse Brandeburg 2013-09-11  114  
02e9c290 Jesse Brandeburg 2013-09-11  115  	*ppos = len;
02e9c290 Jesse Brandeburg 2013-09-11  116  	return len;
02e9c290 Jesse Brandeburg 2013-09-11  117  }
02e9c290 Jesse Brandeburg 2013-09-11  118  
c3c7ea27 Mitch Williams   2016-06-20  119  static char *i40e_filter_state_string[] = {
c3c7ea27 Mitch Williams   2016-06-20  120  	"INVALID",
c3c7ea27 Mitch Williams   2016-06-20  121  	"NEW",
c3c7ea27 Mitch Williams   2016-06-20  122  	"ACTIVE",
c3c7ea27 Mitch Williams   2016-06-20  123  	"FAILED",
c3c7ea27 Mitch Williams   2016-06-20  124  	"REMOVE",
c3c7ea27 Mitch Williams   2016-06-20  125  };
c3c7ea27 Mitch Williams   2016-06-20  126  
02e9c290 Jesse Brandeburg 2013-09-11  127  /**
e625f71b Shannon Nelson   2013-11-26  128   * i40e_dbg_dump_vsi_seid - handles dump vsi seid write into command datum
02e9c290 Jesse Brandeburg 2013-09-11  129   * @pf: the i40e_pf created in command write
02e9c290 Jesse Brandeburg 2013-09-11  130   * @seid: the seid the user put in
02e9c290 Jesse Brandeburg 2013-09-11  131   **/
02e9c290 Jesse Brandeburg 2013-09-11  132  static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
02e9c290 Jesse Brandeburg 2013-09-11  133  {
02e9c290 Jesse Brandeburg 2013-09-11  134  	struct rtnl_link_stats64 *nstat;
02e9c290 Jesse Brandeburg 2013-09-11  135  	struct i40e_mac_filter *f;
02e9c290 Jesse Brandeburg 2013-09-11  136  	struct i40e_vsi *vsi;
278e7d0b Jacob Keller     2016-10-05  137  	int i, bkt;
02e9c290 Jesse Brandeburg 2013-09-11  138  
02e9c290 Jesse Brandeburg 2013-09-11  139  	vsi = i40e_dbg_find_vsi(pf, seid);
02e9c290 Jesse Brandeburg 2013-09-11  140  	if (!vsi) {
02e9c290 Jesse Brandeburg 2013-09-11  141  		dev_info(&pf->pdev->dev,
02e9c290 Jesse Brandeburg 2013-09-11  142  			 "dump %d: seid not found\n", seid);
02e9c290 Jesse Brandeburg 2013-09-11  143  		return;
02e9c290 Jesse Brandeburg 2013-09-11  144  	}
02e9c290 Jesse Brandeburg 2013-09-11  145  	dev_info(&pf->pdev->dev, "vsi seid %d\n", seid);
de1017f7 Shannon Nelson   2015-12-23  146  	if (vsi->netdev) {
de1017f7 Shannon Nelson   2015-12-23  147  		struct net_device *nd = vsi->netdev;
de1017f7 Shannon Nelson   2015-12-23  148  
de1017f7 Shannon Nelson   2015-12-23  149  		dev_info(&pf->pdev->dev, "    netdev: name = %s, state = %lu, flags = 0x%08x\n",
de1017f7 Shannon Nelson   2015-12-23  150  			 nd->name, nd->state, nd->flags);
de1017f7 Shannon Nelson   2015-12-23  151  		dev_info(&pf->pdev->dev, "        features      = 0x%08lx\n",
de1017f7 Shannon Nelson   2015-12-23  152  			 (unsigned long int)nd->features);
de1017f7 Shannon Nelson   2015-12-23  153  		dev_info(&pf->pdev->dev, "        hw_features   = 0x%08lx\n",
de1017f7 Shannon Nelson   2015-12-23  154  			 (unsigned long int)nd->hw_features);
de1017f7 Shannon Nelson   2015-12-23  155  		dev_info(&pf->pdev->dev, "        vlan_features = 0x%08lx\n",
de1017f7 Shannon Nelson   2015-12-23  156  			 (unsigned long int)nd->vlan_features);
de1017f7 Shannon Nelson   2015-12-23  157  	}
02e9c290 Jesse Brandeburg 2013-09-11  158  	dev_info(&pf->pdev->dev,
02e9c290 Jesse Brandeburg 2013-09-11  159  		 "    vlgrp: & = %p\n", vsi->active_vlans);
02e9c290 Jesse Brandeburg 2013-09-11  160  	dev_info(&pf->pdev->dev,
0da36b97 Jacob Keller     2017-04-19 @161  		 "    flags = 0x%08lx, netdev_registered = %i, current_netdev_flags = 0x%04x\n",
0da36b97 Jacob Keller     2017-04-19  162  		 vsi->flags, vsi->netdev_registered, vsi->current_netdev_flags);
0da36b97 Jacob Keller     2017-04-19  163  	for (i = 0; i < BITS_TO_LONGS(__I40E_VSI_STATE_SIZE__); i++)
0da36b97 Jacob Keller     2017-04-19  164  		dev_info(&pf->pdev->dev,

:::::: The code at line 161 was first introduced by commit
:::::: 0da36b9774cc24bac4bff446edf49f31aa98a282 i40e: use DECLARE_BITMAP for state fields

:::::: TO: Jacob Keller <jacob.e.keller@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 47784 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170627/7578d3dc/attachment-0001.bin>
