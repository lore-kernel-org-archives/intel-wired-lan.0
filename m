From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Fri, 9 Dec 2016 13:35:37 +0100
Subject: [Intel-wired-lan] [PATCH v2 1/3] i40e: Initial support for XDP
In-Reply-To: <201612091910.q6chuROB%fengguang.wu@intel.com>
References: <20161209082212.29549-2-bjorn.topel@gmail.com>
 <201612091910.q6chuROB%fengguang.wu@intel.com>
Message-ID: <CAJ+HfNgO71tR_Kw+BY+8EG4s=_zu9_JfBzi8iP8d9nj4qcxUVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jeff,

I rebased the series on net-next v4.9-rc8-1700-gf006b2c5dff3.

2016-12-09 12:56 GMT+01:00 kbuild test robot <lkp@intel.com>:
> Hi Bj?rn,
>
> [auto build test ERROR on next-20161208]
> [cannot apply to jkirsher-next-queue/dev-queue v4.9-rc8 v4.9-rc7 v4.9-rc6 v4.9-rc8]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Bj-rn-T-pel/i40e-Initial-support-for-XDP/20161209-182749
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
>    drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_xdp_setup':
>>> drivers/net/ethernet/intel/i40e/i40e_main.c:9218:18: error: 'struct bpf_prog' has no member named 'xdp_adjust_head'
>      if (prog && prog->xdp_adjust_head)
>                      ^~
>
> vim +9218 drivers/net/ethernet/intel/i40e/i40e_main.c
>
>   9212                            struct bpf_prog *prog)
>   9213  {
>   9214          struct i40e_pf *pf = vsi->back;
>   9215          struct net_device *netdev = vsi->netdev;
>   9216          int frame_size = netdev->mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
>   9217
>> 9218          if (prog && prog->xdp_adjust_head)

xdp_adjust_head was introduced in:
  17bedab27231 ("bpf: xdp: Allow head adjustment in XDP prog")

Can I tell the builder to use this tree? What's the typical path here?


Thanks,
Bj?rn
