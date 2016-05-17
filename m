From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 17 May 2016 00:10:53 -0700
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 23/33]
 drivers/net/ethernet/intel/i40evf/i40evf_main.c:2236:7-21: duplicated
 argument to & or | (fwd)
In-Reply-To: <alpine.DEB.2.02.1605170725140.2068@localhost6.localdomain6>
References: <alpine.DEB.2.02.1605170725140.2068@localhost6.localdomain6>
Message-ID: <1463469053.2649.10.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-05-17 at 07:26 +0200, Julia Lawall wrote:
> Lines 2236 and 2240.
> 
> julia

Thanks for catching that, since that is the only change in the patch, I am
going ahead and dropping the patch.

> ---------- Forwarded message ----------
> Date: Tue, 17 May 2016 09:03:11 +0800
> From: kbuild test robot <fengguang.wu@intel.com>
> To: kbuild at 01.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: [jkirsher-next-queue:dev-queue 23/33]
> ????drivers/net/ethernet/intel/i40evf/i40evf_main.c:2236:7-21: duplicated
> ????argument to & or |
> 
> CC: kbuild-all at 01.org
> CC: intel-wired-lan at lists.osuosl.org
> CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> CC: Mitch Williams <mitch.a.williams@intel.com>
> 
> tree:???https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-que
> ue.git dev-queue
> head:???023818611c465ce3e8f7f1895730bf027782c621
> commit: 7be7036b405f4eb7f425ff0fdf35251530db1533 [23/33] i40evf: report
> RSS hash capability to stack
> :::::: branch date: 2 hours ago
> :::::: commit date: 3 hours ago
> 
> > 
> > > 
> > > drivers/net/ethernet/intel/i40evf/i40evf_main.c:2236:7-21: duplicated
> > > argument to & or |
> git remote add jkirsher-next-queue https://git.kernel.org/pub/scm/linux/k
> ernel/git/jkirsher/next-queue.git
> git remote update jkirsher-next-queue
> git checkout 7be7036b405f4eb7f425ff0fdf35251530db1533
> vim +2236 drivers/net/ethernet/intel/i40evf/i40evf_main.c
> 
> e6d038de Mitch Williams??2015-06-04??2220??		return
> -ENODEV;
> e6d038de Mitch Williams??2015-06-04??2221??	}
> e6d038de Mitch Williams??2015-06-04??2222??
> b0fe3306 Alexander Duyck 2016-04-02??2223??	netdev-
> >hw_enc_features |= NETIF_F_SG			|
> e6d038de Mitch Williams??2015-06-04??2224??				
> ???NETIF_F_IP_CSUM		|
> e6d038de Mitch Williams??2015-06-04??2225??				
> ???NETIF_F_IPV6_CSUM		|
> b0fe3306 Alexander Duyck 2016-04-02??2226??				
> ???NETIF_F_HIGHDMA		|
> b0fe3306 Alexander Duyck 2016-04-02??2227??				
> ???NETIF_F_SOFT_FEATURES	|
> e6d038de Mitch Williams??2015-06-04??2228??				
> ???NETIF_F_TSO			|
> f608e6a6 Alexander Duyck 2016-01-24??2229??				
> ???NETIF_F_TSO_ECN		|
> b0fe3306 Alexander Duyck 2016-04-02??2230??				
> ???NETIF_F_TSO6			|
> f608e6a6 Alexander Duyck 2016-01-24??2231??				
> ???NETIF_F_GSO_GRE		|
> 1c7b4a23 Alexander Duyck 2016-04-14??2232??				
> ???NETIF_F_GSO_GRE_CSUM		|
> 577389a5 Alexander Duyck 2016-04-02??2233??				
> ???NETIF_F_GSO_IPIP		|
> 577389a5 Alexander Duyck 2016-04-02??2234??				
> ???NETIF_F_GSO_SIT		|
> f608e6a6 Alexander Duyck 2016-01-24??2235??				
> ???NETIF_F_GSO_UDP_TUNNEL	|
> 7be7036b Mitch Williams??2016-05-16 @2236??				
> ???NETIF_F_RXHASH	????????|
> b0fe3306 Alexander Duyck 2016-04-02??2237??				
> ???NETIF_F_GSO_UDP_TUNNEL_CSUM	|
> 1c7b4a23 Alexander Duyck 2016-04-14??2238??				
> ???NETIF_F_GSO_PARTIAL		|
> b0fe3306 Alexander Duyck 2016-04-02??2239??				
> ???NETIF_F_SCTP_CRC		|
> b0fe3306 Alexander Duyck 2016-04-02??2240??				
> ???NETIF_F_RXHASH		|
> e6d038de Mitch Williams??2015-06-04??2241??				
> ???NETIF_F_RXCSUM		|
> b0fe3306 Alexander Duyck 2016-04-02??2242??				
> ???0;
> e6d038de Mitch Williams??2015-06-04??2243??
> b0fe3306 Alexander Duyck 2016-04-02??2244??	if (!(adapter->flags &
> I40EVF_FLAG_OUTER_UDP_CSUM_CAPABLE))
> 
> ---
> 0-DAY kernel test infrastructure????????????????Open Source Technology
> Center
> https://lists.01.org/pipermail/kbuild-all???????????????????Intel
> Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160517/9c4f941d/attachment.asc>
