From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 23 Jan 2019 08:51:38 -0800
Subject: [Intel-wired-lan] [PATCH 1/3] treewide: Lift switch variables
 out of switches
In-Reply-To: <20190123110349.35882-2-keescook@chromium.org>
References: <20190123110349.35882-1-keescook@chromium.org>
 <20190123110349.35882-2-keescook@chromium.org>
Message-ID: <7d8a6120ea335d74c41a5fba3754518ea60e936e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2019-01-23 at 03:03 -0800, Kees Cook wrote:
> Variables declared in a switch statement before any case statements
> cannot be initialized, so move all instances out of the switches.
> After this, future always-initialized stack variables will work
> and not throw warnings like this:
> 
> fs/fcntl.c: In function ?send_sigio_to_task?:
> fs/fcntl.c:738:13: warning: statement will never be executed [-
> Wswitch-unreachable]
>    siginfo_t si;
>              ^~
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

For the e1000 changes.

> ---
>  arch/x86/xen/enlighten_pv.c                   |  7 ++++---
>  drivers/char/pcmcia/cm4000_cs.c               |  2 +-
>  drivers/char/ppdev.c                          | 20 ++++++++---------
> --
>  drivers/gpu/drm/drm_edid.c                    |  4 ++--
>  drivers/gpu/drm/i915/intel_display.c          |  2 +-
>  drivers/gpu/drm/i915/intel_pm.c               |  4 ++--
>  drivers/net/ethernet/intel/e1000/e1000_main.c |  3 ++-
>  drivers/tty/n_tty.c                           |  3 +--
>  drivers/usb/gadget/udc/net2280.c              |  5 ++---
>  fs/fcntl.c                                    |  3 ++-
>  mm/shmem.c                                    |  5 +++--
>  net/core/skbuff.c                             |  4 ++--
>  net/ipv6/ip6_gre.c                            |  4 ++--
>  net/ipv6/ip6_tunnel.c                         |  4 ++--
>  net/openvswitch/flow_netlink.c                |  7 +++----
>  security/tomoyo/common.c                      |  3 ++-
>  security/tomoyo/condition.c                   |  7 ++++---
>  security/tomoyo/util.c                        |  4 ++--
>  18 files changed, 45 insertions(+), 46 deletions(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190123/cd7b302b/attachment.asc>
