From: John Fastabend <john.fastabend@gmail.com>
Date: Tue, 20 Sep 2016 21:30:36 -0700
Subject: [Intel-wired-lan] [net-next PATCH v2 1/2] e1000: add initial
	XDP support
In-Reply-To: <CAD=hENf9UZppBSx11Pdg8A9U2tmNLYOXeY5tpzyYiBF4dOcGLg@mail.gmail.com>
References: <20160909212915.4001.25504.stgit@john-Precision-Tower-5810>
 <CAD=hENf9UZppBSx11Pdg8A9U2tmNLYOXeY5tpzyYiBF4dOcGLg@mail.gmail.com>
Message-ID: <57E20CEC.4040600@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 16-09-20 09:26 PM, zhuyj wrote:
>  +static int e1000_xdp_set(struct net_device *netdev, struct bpf_prog *prog)
> +{
> +       struct e1000_adapter *adapter = netdev_priv(netdev);
> +       struct bpf_prog *old_prog;
> +
> +       old_prog = xchg(&adapter->prog, prog);
> +       if (old_prog) {
> +               synchronize_net();
> +               bpf_prog_put(old_prog);
> +       }
> +
> +       if (netif_running(netdev))
> +               e1000_reinit_locked(adapter);
> +       else
> +               e1000_reset(adapter);
> +       return 0;
> +}
> 
> To this function, is it better to use "static void
> e1000_xdp_set(struct net_device *netdev, struct bpf_prog *prog)"?
> since it is always to return 0.
> 

In general try to avoid top posting.

Yes making it void would be reasonable and probably a good idea. I'll
do it in v3.

[...]

Thanks,
John

