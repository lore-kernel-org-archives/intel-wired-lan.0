From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Thu, 22 Mar 2018 13:20:21 +0100
Subject: [Intel-wired-lan] [PATCH v2 2/2] i40e: add support for
 XDP_REDIRECT
In-Reply-To: <20180322125811.0dcc1b28@redhat.com>
References: <20180322090307.14409-1-bjorn.topel@gmail.com>
 <20180322090307.14409-2-bjorn.topel@gmail.com>
 <20180322125811.0dcc1b28@redhat.com>
Message-ID: <CAJ+HfNiGWgJEE9K1rh3OrgixFaTJE4mDCBzYVGQJv3R8_rpLTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

2018-03-22 12:58 GMT+01:00 Jesper Dangaard Brouer <brouer@redhat.com>:
>
> On Thu, 22 Mar 2018 10:03:07 +0100 Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
>
>> +/**
>> + * i40e_xdp_xmit - Implements ndo_xdp_xmit
>> + * @dev: netdev
>> + * @xdp: XDP buffer
>> + *
>> + * Returns Zero if sent, else an error code
>> + **/
>> +int i40e_xdp_xmit(struct net_device *dev, struct xdp_buff *xdp)
>> +{
>
> The return code is used by the XDP redirect tracepoint... this is the
> only way we have to debug/troubleshoot runtime issues with XDP. Thus,
> these need to be consistent across drives and distinguishable.
>

Thanks for pointing this out! I'll address all your comments and do a
respin (but I'll wait for Alex' comments, if any).


Bj?rn

>> +     struct i40e_netdev_priv *np = netdev_priv(dev);
>> +     unsigned int queue_index = smp_processor_id();
>> +     struct i40e_vsi *vsi = np->vsi;
>> +     int err;
>> +
>> +     if (test_bit(__I40E_VSI_DOWN, vsi->state))
>> +             return -EINVAL;
>
> Should be: -ENETDOWN
>
>> +
>> +     if (!i40e_enabled_xdp_vsi(vsi) || queue_index >= vsi->num_queue_pairs)
>> +             return -EINVAL;
>
> Should be: -ENXIO
>
>> +     err = i40e_xmit_xdp_ring(xdp, vsi->xdp_rings[queue_index]);
>> +     if (err != I40E_XDP_TX)
>> +             return -ENOMEM;
>
> Should be: -ENOSPC
>
> The ENOSPC return code is important, as this can be used as a feedback
> to a XDP_REDIRECT load-balancer facility.
>
> --
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
