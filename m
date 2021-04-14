From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 14 Apr 2021 09:37:10 +0800
Subject: [Intel-wired-lan] [PATCH net v2] i40e: fix the panic when
 running bpf in xdpdrv mode
In-Reply-To: <20210413091812.0000383d@intel.com>
References: <20210412065759.2907-1-kerneljasonxing@gmail.com>
 <20210413025011.1251-1-kerneljasonxing@gmail.com>
 <20210413091812.0000383d@intel.com>
Message-ID: <CAL+tcoBHdVa8eJQVYK4aQj+XWAgcN8VOaL558z=2YuHSa8mbKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Apr 14, 2021 at 12:27 AM Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:
>
> kerneljasonxing at gmail.com wrote:
>
> > From: Jason Xing <xingwanli@kuaishou.com>
>
> Hi Jason,
>
> Sorry, I missed this on the first time: Added intel-wired-lan,
> please include on any future submissions for Intel drivers.
> get-maintainers script might help here?
>

Hi, Jesse

In the first patch, I did send to intel-wired-lan but it told me that
it is open for the member only, so
I got rid of it in this patch v2.

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
> >
>
> This Fixes line should be connected to the Sign offs with
> no linefeeds between.
>
> > Signed-off-by: Jason Xing <xingwanli@kuaishou.com>
> > Signed-off-by: Shujin Li <lishujin@kuaishou.com>
>
> Did Shujin contribute to this patch? Why are they signing off? If
> they developed this patch with you, it should say:
> Co-developed-by: Shujin ....
> Signed-off-by: Shujin ...
> Signed-off-by: Jason ...
>

Well, yes, I will add a Co-developed-by label later.

> Your signature should be last if you sent the patch. The sign-offs are
> like a chain of custody, please review
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
>

Thanks so much for your detailed instructions. I'm about to correct
them all together and then resend the patch v3.

Jason

> Thanks,
>  Jesse
