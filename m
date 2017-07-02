From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 3 Jul 2017 01:08:51 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 46/57]
 drivers/net/ethernet/intel/i40e/i40e_main.c:2437: warning: unused variable
 'max_frame'
Message-ID: <201707030149.lnICrpXJ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   c8e535dfc418c2f2f3e03a4b38af6dd3397293af
commit: 854d38a89c8add869e3eb0dd8a258ff4c3f9fac2 [46/57] i40e/i40evf: adjust packet size to account for double VLANs
config: x86_64-randconfig-v0-07022319 (attached as .config)
compiler: gcc-4.4 (Debian 4.4.7-8) 4.4.7
reproduce:
        git checkout 854d38a89c8add869e3eb0dd8a258ff4c3f9fac2
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_change_mtu':
>> drivers/net/ethernet/intel/i40e/i40e_main.c:2437: warning: unused variable 'max_frame'
--
   drivers/net/ethernet/intel/i40evf/i40evf_main.c: In function 'i40evf_change_mtu':
>> drivers/net/ethernet/intel/i40evf/i40evf_main.c:2272: warning: unused variable 'max_frame'

vim +/max_frame +2437 drivers/net/ethernet/intel/i40e/i40e_main.c

  2421		if (PAGE_SIZE >= 8192 || (vsi->back->flags & I40E_FLAG_LEGACY_RX))
  2422			return I40E_RXBUFFER_2048;
  2423		else
  2424			return I40E_RXBUFFER_3072;
  2425	}
  2426	
  2427	/**
  2428	 * i40e_change_mtu - NDO callback to change the Maximum Transfer Unit
  2429	 * @netdev: network interface device structure
  2430	 * @new_mtu: new value for maximum frame size
  2431	 *
  2432	 * Returns 0 on success, negative on failure
  2433	 **/
  2434	static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
  2435	{
  2436		struct i40e_netdev_priv *np = netdev_priv(netdev);
> 2437		int max_frame = new_mtu + I40E_PACKET_HDR_PAD;
  2438		struct i40e_vsi *vsi = np->vsi;
  2439		struct i40e_pf *pf = vsi->back;
  2440	
  2441		if (i40e_enabled_xdp_vsi(vsi)) {
  2442			int frame_size = new_mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
  2443	
  2444			if (frame_size > i40e_max_xdp_frame_size(vsi))
  2445				return -EINVAL;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 32828 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170703/da3196b7/attachment-0001.bin>
