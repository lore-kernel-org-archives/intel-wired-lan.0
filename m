From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Thu, 15 Apr 2021 12:31:45 +0200
Subject: [Intel-wired-lan] [PATCH net v3] i40e: fix the panic when
 running bpf in xdpdrv mode
In-Reply-To: <20210414190652.00006680@intel.com>
References: <20210413025011.1251-1-kerneljasonxing@gmail.com>
 <20210414023428.10121-1-kerneljasonxing@gmail.com>
 <20210414190652.00006680@intel.com>
Message-ID: <20210415123145.56af01ca@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 14 Apr 2021 19:06:52 -0700
Jesse Brandeburg <jesse.brandeburg@intel.com> wrote:

> kerneljasonxing at gmail.com wrote:
> 
> > From: Jason Xing <xingwanli@kuaishou.com>
> > 
> > Fix this panic by adding more rules to calculate the value of @rss_size_max
> > which could be used in allocating the queues when bpf is loaded, which,
> > however, could cause the failure and then trigger the NULL pointer of
> > vsi->rx_rings. Prio to this fix, the machine doesn't care about how many
> > cpus are online and then allocates 256 queues on the machine with 32 cpus
> > online actually.
> > 
> > Once the load of bpf begins, the log will go like this "failed to get
> > tracking for 256 queues for VSI 0 err -12" and this "setup of MAIN VSI
> > failed".
> > 
> > Thus, I attach the key information of the crash-log here.
> > 
> > BUG: unable to handle kernel NULL pointer dereference at
> > 0000000000000000
> > RIP: 0010:i40e_xdp+0xdd/0x1b0 [i40e]
> > Call Trace:
> > [2160294.717292]  ? i40e_reconfig_rss_queues+0x170/0x170 [i40e]
> > [2160294.717666]  dev_xdp_install+0x4f/0x70
> > [2160294.718036]  dev_change_xdp_fd+0x11f/0x230
> > [2160294.718380]  ? dev_disable_lro+0xe0/0xe0
> > [2160294.718705]  do_setlink+0xac7/0xe70
> > [2160294.719035]  ? __nla_parse+0xed/0x120
> > [2160294.719365]  rtnl_newlink+0x73b/0x860
> > 
> > Fixes: 41c445ff0f48 ("i40e: main driver core")
> > Co-developed-by: Shujin Li <lishujin@kuaishou.com>
> > Signed-off-by: Shujin Li <lishujin@kuaishou.com>
> > Signed-off-by: Jason Xing <xingwanli@kuaishou.com>  
> 
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> @Jakub/@DaveM - feel free to apply this directly.

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

The crash/bug happens in this code:

 static int i40e_xdp_setup(struct i40e_vsi *vsi, struct bpf_prog *prog,
			  struct netlink_ext_ack *extack)
 {
 [...]
	for (i = 0; i < vsi->num_queue_pairs; i++)
		WRITE_ONCE(vsi->rx_rings[i]->xdp_prog, vsi->xdp_prog);


And this is a side effect of i40e_setup_pf_switch() failing with "setup
of MAIN VSI failed".

LGTM
-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

