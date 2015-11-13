From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 14 Nov 2015 06:10:40 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 156/160]
 drivers/net/ethernet/intel/i40e/i40e_main.c:8774:2: error: unknown field
 'ndo_add_vxlan_port' specified in initializer
Message-ID: <201511140634.gOiRX11H%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   7c2cae61768b0da68519e4c45a86aafab84dda28
commit: b38838432894149338100207df9c2b0b6b38a536 [156/160] net: Generalize udp based tunnel offload
config: i386-allmodconfig (attached as .config)
reproduce:
        git checkout b38838432894149338100207df9c2b0b6b38a536
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/i40e/i40e_main.c:8774:2: error: unknown field 'ndo_add_vxlan_port' specified in initializer
     .ndo_add_vxlan_port = i40e_add_vxlan_port,
     ^
>> drivers/net/ethernet/intel/i40e/i40e_main.c:8774:24: error: 'i40e_add_vxlan_port' undeclared here (not in a function)
     .ndo_add_vxlan_port = i40e_add_vxlan_port,
                           ^
>> drivers/net/ethernet/intel/i40e/i40e_main.c:8775:2: error: unknown field 'ndo_del_vxlan_port' specified in initializer
     .ndo_del_vxlan_port = i40e_del_vxlan_port,
     ^
>> drivers/net/ethernet/intel/i40e/i40e_main.c:8775:24: error: 'i40e_del_vxlan_port' undeclared here (not in a function)
     .ndo_del_vxlan_port = i40e_del_vxlan_port,
                           ^

vim +/ndo_add_vxlan_port +8774 drivers/net/ethernet/intel/i40e/i40e_main.c

41c445ff Jesse Brandeburg    2013-09-11  8768  	.ndo_set_vf_vlan	= i40e_ndo_set_vf_port_vlan,
ed616689 Sucheta Chakraborty 2014-05-22  8769  	.ndo_set_vf_rate	= i40e_ndo_set_vf_bw,
41c445ff Jesse Brandeburg    2013-09-11  8770  	.ndo_get_vf_config	= i40e_ndo_get_vf_config,
588aefa0 Mitch Williams      2014-02-11  8771  	.ndo_set_vf_link_state	= i40e_ndo_set_vf_link_state,
e6d9004d Serey Kong          2014-07-12  8772  	.ndo_set_vf_spoofchk	= i40e_ndo_set_vf_spoofchk,
a1c9a9d9 Jeff Kirsher        2013-12-28  8773  #ifdef CONFIG_I40E_VXLAN
a1c9a9d9 Jeff Kirsher        2013-12-28 @8774  	.ndo_add_vxlan_port	= i40e_add_vxlan_port,
a1c9a9d9 Jeff Kirsher        2013-12-28 @8775  	.ndo_del_vxlan_port	= i40e_del_vxlan_port,
a1c9a9d9 Jeff Kirsher        2013-12-28  8776  #endif
b3883843 Anjali Singhai      2015-11-13  8777  	.ndo_add_udp_tunnel_port	= i40e_add_tunnel_port,
b3883843 Anjali Singhai      2015-11-13  8778  	.ndo_del_udp_tunnel_port	= i40e_del_tunnel_port,

:::::: The code at line 8774 was first introduced by commit
:::::: a1c9a9d9984d9acf276089525b43a6528feab29b i40e: Implementation of VXLAN ndo's

:::::: TO: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 52523 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151114/88baac22/attachment-0001.obj>
