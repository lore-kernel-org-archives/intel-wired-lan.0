From: kbuild test robot <lkp@intel.com>
Date: Fri, 9 Dec 2016 19:56:32 +0800
Subject: [Intel-wired-lan] [PATCH v2 1/3] i40e: Initial support for XDP
In-Reply-To: <20161209082212.29549-2-bjorn.topel@gmail.com>
Message-ID: <201612091910.q6chuROB%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Bj?rn,

[auto build test ERROR on next-20161208]
[cannot apply to jkirsher-next-queue/dev-queue v4.9-rc8 v4.9-rc7 v4.9-rc6 v4.9-rc8]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bj-rn-T-pel/i40e-Initial-support-for-XDP/20161209-182749
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_xdp_setup':
>> drivers/net/ethernet/intel/i40e/i40e_main.c:9218:18: error: 'struct bpf_prog' has no member named 'xdp_adjust_head'
     if (prog && prog->xdp_adjust_head)
                     ^~

vim +9218 drivers/net/ethernet/intel/i40e/i40e_main.c

  9212				  struct bpf_prog *prog)
  9213	{
  9214		struct i40e_pf *pf = vsi->back;
  9215		struct net_device *netdev = vsi->netdev;
  9216		int frame_size = netdev->mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
  9217	
> 9218		if (prog && prog->xdp_adjust_head)
  9219			return -EOPNOTSUPP;
  9220	
  9221		if (frame_size > I40E_RXBUFFER_2048)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 57890 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161209/12f41a90/attachment-0001.bin>
