From: Toke =?unknown-8bit?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Fri, 04 Dec 2020 13:18:31 +0100
Subject: [Intel-wired-lan] [PATCH v2 bpf 1/5] net: ethtool: add xdp
 properties flag set
In-Reply-To: <20201204102901.109709-2-marekx.majtyka@intel.com>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <20201204102901.109709-2-marekx.majtyka@intel.com>
Message-ID: <878sad933c.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

alardam at gmail.com writes:

> From: Marek Majtyka <marekx.majtyka@intel.com>
>
> Implement support for checking what kind of xdp functionality a netdev
> supports. Previously, there was no way to do this other than to try
> to create an AF_XDP socket on the interface or load an XDP program and see
> if it worked. This commit changes this by adding a new variable which
> describes all xdp supported functions on pretty detailed level:

I like the direction this is going! :)

>  - aborted
>  - drop
>  - pass
>  - tx
>  - redirect

Drivers can in principle implement support for the XDP_REDIRECT return
code (and calling xdp_do_redirect()) without implementing ndo_xdp_xmit()
for being the *target* of a redirect. While my quick grepping doesn't
turn up any drivers that do only one of these right now, I think we've
had examples of it in the past, so it would probably be better to split
the redirect feature flag in two.

This would also make it trivial to replace the check in __xdp_enqueue()
(in devmap.c) from looking at whether the ndo is defined, and just
checking the flag. It would be great if you could do this as part of
this series.

Maybe we could even make the 'redirect target' flag be set automatically
if a driver implements ndo_xdp_xmit?

>  - zero copy
>  - hardware offload.
>
> Zerocopy mode requires that redirect xdp operation is implemented
> in a driver and the driver supports also zero copy mode.
> Full mode requires that all xdp operation are implemented in the driver.
> Basic mode is just full mode without redirect operation.
>
> Initially, these new flags are disabled for all drivers by default.
>
> Signed-off-by: Marek Majtyka <marekx.majtyka@intel.com>
> ---
>  .../networking/netdev-xdp-properties.rst      | 42 ++++++++
>  include/linux/netdevice.h                     |  2 +
>  include/linux/xdp_properties.h                | 53 +++++++++++
>  include/net/xdp.h                             | 95 +++++++++++++++++++
>  include/net/xdp_sock_drv.h                    | 10 ++
>  include/uapi/linux/ethtool.h                  |  1 +
>  include/uapi/linux/xdp_properties.h           | 32 +++++++
>  net/ethtool/common.c                          | 11 +++
>  net/ethtool/common.h                          |  4 +
>  net/ethtool/strset.c                          |  5 +
>  10 files changed, 255 insertions(+)
>  create mode 100644 Documentation/networking/netdev-xdp-properties.rst
>  create mode 100644 include/linux/xdp_properties.h
>  create mode 100644 include/uapi/linux/xdp_properties.h
>
> diff --git a/Documentation/networking/netdev-xdp-properties.rst b/Documentation/networking/netdev-xdp-properties.rst
> new file mode 100644
> index 000000000000..4a434a1c512b
> --- /dev/null
> +++ b/Documentation/networking/netdev-xdp-properties.rst
> @@ -0,0 +1,42 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================
> +Netdev XDP properties
> +=====================
> +
> + * XDP PROPERTIES FLAGS
> +
> +Following netdev xdp properties flags can be retrieve over netlink ethtool
> +interface the same way as netdev feature flags. These properties flags are
> +read only and cannot be change in the runtime.
> +
> +
> +*  XDP_ABORTED
> +
> +This property informs if netdev supports xdp aborted action.
> +
> +*  XDP_DROP
> +
> +This property informs if netdev supports xdp drop action.
> +
> +*  XDP_PASS
> +
> +This property informs if netdev supports xdp pass action.
> +
> +*  XDP_TX
> +
> +This property informs if netdev supports xdp tx action.
> +
> +*  XDP_REDIRECT
> +
> +This property informs if netdev supports xdp redirect action.
> +It assumes the all beforehand mentioned flags are enabled.
> +
> +*  XDP_ZEROCOPY
> +
> +This property informs if netdev driver supports xdp zero copy.
> +It assumes the all beforehand mentioned flags are enabled.

Nit: I think 'XDP_ZEROCOPY' can lead people to think that this is
zero-copy support for all XDP operations, which is obviously not the
case. So maybe 'XDP_SOCK_ZEROCOPY' (and update the description to
mention AF_XDP sockets explicitly)?

-Toke

