From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Sat, 15 Jun 2019 21:13:15 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 0/6] add need_wakeup flag to
 the AF_XDP rings
In-Reply-To: <20190614161720.00002da5@gmail.com>
References: <1560411450-29121-1-git-send-email-magnus.karlsson@intel.com>
 <b84b2128-da38-3f0e-35fe-7d1466005dca@mellanox.com>
 <20190614161720.00002da5@gmail.com>
Message-ID: <CAJ8uoz2szX=+JXXAMyuVmvSsMXZuDqp6a8rjDQpTioxbZwxFmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jun 14, 2019 at 4:18 PM Maciej Fijalkowski
<maciejromanfijalkowski@gmail.com> wrote:
>
> On Fri, 14 Jun 2019 13:38:04 +0000
> Maxim Mikityanskiy <maximmi@mellanox.com> wrote:
>
> > On 2019-06-13 10:37, Magnus Karlsson wrote:
> > >
> > > This patch set adds support for a new flag called need_wakeup in the
> > > AF_XDP Tx and fill rings. When this flag is set by the driver, it
> > > means that the application has to explicitly wake up the kernel Rx
> > > (for the bit in the fill ring) or kernel Tx (for bit in the Tx ring)
> > > processing by issuing a syscall. Poll() can wake up both and sendto()
> > > will wake up Tx processing only.
> >
> > At first sight, sounds useful! (I didn't have time to have a deeper look
> > at the series yet.)
> >
> > I see you are replacing ndo_xsk_async_xmit with another function to
> > support your extension, and some driver changes are made. Does it mean
> > that every driver must support the new extension? How about making it
> > optional? I.e. the kernel can check whether the new NDO is implemented
> > or not, and use the new feature with drivers that support it.
>
> I think I can speak up for Magnus.
> That NDO was just renamed in order to better reflect cases where it is
> currently being used, e.g. having ndo_xsk_async_xmit() called in order to get
> into NAPI and take the buffers from fill queue was misleading a bit, as you
> were waking up the Rx side.

This is correct. As a side note, the Rx/Tx flag is not used in the
Intel drivers as Rx and Tx is done in the same napi. If you wake up
one, you wake up the other too. I put the flag there as a courtesy for
drivers that have Rx and Tx in different napi contexts. If there are
no such drivers out there, let me know and I will remove it.

The other small change that is done to the drivers in patch 2 is that
one of the new functions xsk_[set|clear]_[rx|tx]_need_wakeup need to
be called at the end of Rx and Tx processing respectively. These just
indicate if the flag (Rx or Tx) should be set or cleared. Basically,
does the driver need to be woken up or not. To your point about
compatibility, if the driver does not support this but the application
does: the Rx flag is default set to 0 and the Tx flag is set to 1. If
the driver does not support changing the flag (i.e., it has no support
for this), the app will not call any poll() for Rx since the flag is 0
and always call sendto() for Tx as that flag is always one. This
defaults to the same behavior as previously. The driver will busy-poll
the fill queue and the application will slam sendto() at regular
intervals as it has no idea if it is needed or not.

With that said, I noticed that I forgot to put the Tx flag
initialization to one in the code, sigh. Will fix that in v2.

These lines in xdp_assign_dev() in xdp_umem.c

if (flags & XDP_USE_NEED_WAKEUP)
                umem->flags |= XDP_UMEM_MIGHT_SLEEP;

should be:

if (flags & XDP_USE_NEED_WAKEUP) {
                umem->flags |= XDP_UMEM_MIGHT_SLEEP;
                /* Tx needs to be explicitly woken up the first time.
                 * Also for supporting drivers that do not implement this
                 * feature. They will always have to call sendto().
                 */
                xsk_set_tx_need_wakeup(umem);
        }

Thanks: Magnus

> The functionality of that NDO stays the same. Magnus also provided explanations
> in commit messages, which I suppose will clarify it more once you go through
> the series.
>
> >
> > Thanks,
> > Max
> >
> > > The main reason for introducing this new flag is to be able to
> > > efficiently support the case when application and driver is executing
> > > on the same core. Previously, the driver was just busy-spinning on the
> > > fill ring if it ran out of buffers in the HW and there were none to
> > > get from the fill ring. This approach works when the application and
> > > driver is running on different cores as the application can replenish
> > > the fill ring while the driver is busy-spinning. Though, this is a
> > > lousy approach if both of them are running on the same core as the
> > > probability of the fill ring getting more entries when the driver is
> > > busy-spinning is zero. With this new feature the driver now sets the
> > > need_wakeup flag and returns to the application. The application can
> > > then replenish the fill queue and then explicitly wake up the Rx
> > > processing in the kernel using the syscall poll(). For Tx, the flag is
> > > only set to one if the driver has no outstanding Tx completion
> > > interrupts. If it has some, the flag is zero as it will be woken up by
> > > a completion interrupt anyway. This flag can also be used in other
> > > situations where the driver needs to be woken up explicitly.
> > >
> > > As a nice side effect, this new flag also improves the Tx performance
> > > of the case where application and driver are running on two different
> > > cores as it reduces the number of syscalls to the kernel. The kernel
> > > tells user space if it needs to be woken up by a syscall, and this
> > > eliminates many of the syscalls. The Rx performance of the 2-core case
> > > is on the other hand slightly worse, since there is a need to use a
> > > syscall now to wake up the driver, instead of the driver
> > > busy-spinning. It does waste less CPU cycles though, which might lead
> > > to better overall system performance.
> > >
> > > This new flag needs some simple driver support. If the driver does not
> > > support it, the Rx flag is always zero and the Tx flag is always
> > > one. This makes any application relying on this feature default to the
> > > old behavior of not requiring any syscalls in the Rx path and always
> > > having to call sendto() in the Tx path.
> > >
> > > For backwards compatibility reasons, this feature has to be explicitly
> > > turned on using a new bind flag (XDP_USE_NEED_WAKEUP). I recommend
> > > that you always turn it on as it has a large positive performance
> > > impact for the one core case and does not degrade 2 core performance
> > > and actually improves it for Tx heavy workloads.
> > >
> > > Here are some performance numbers measured on my local,
> > > non-performance optimized development system. That is why you are
> > > seeing numbers lower than the ones from Bj?rn and Jesper. 64 byte
> > > packets at 40Gbit/s line rate. All results in Mpps. Cores == 1 means
> > > that both application and driver is executing on the same core. Cores
> > > == 2 that they are on different cores.
> > >
> > >                                Applications
> > > need_wakeup  cores    txpush    rxdrop      l2fwd
> > > ---------------------------------------------------------------
> > >       n         1       0.07      0.06        0.03
> > >       y         1       21.6      8.2         6.5
> > >       n         2       32.3      11.7        8.7
> > >       y         2       33.1      11.7        8.7
> > >
> > > Overall, the need_wakeup flag provides the same or better performance
> > > in all the micro-benchmarks. The reduction of sendto() calls in txpush
> > > is large. Only a few per second is needed. For l2fwd, the drop is 50%
> > > for the 1 core case and more than 99.9% for the 2 core case. Do not
> > > know why I am not seeing the same drop for the 1 core case yet.
> > >
> > > The name and inspiration of the flag has been taken from io_uring by
> > > Jens Axboe. Details about this feature in io_uring can be found in
> > > http://kernel.dk/io_uring.pdf, section 8.3. It also addresses most of
> > > the denial of service and sendto() concerns raised by Maxim
> > > Mikityanskiy in https://www.spinics.net/lists/netdev/msg554657.html.
> > >
> > > The typical Tx part of an application will have to change from:
> > >
> > > ret = sendto(fd,....)
> > >
> > > to:
> > >
> > > if (xsk_ring_prod__needs_wakeup(&xsk->tx))
> > >         ret = sendto(fd,....)
> > >
> > > and th Rx part from:
> > >
> > > rcvd = xsk_ring_cons__peek(&xsk->rx, BATCH_SIZE, &idx_rx);
> > > if (!rcvd)
> > >         return;
> > >
> > > to:
> > >
> > > rcvd = xsk_ring_cons__peek(&xsk->rx, BATCH_SIZE, &idx_rx);
> > > if (!rcvd) {
> > >         if (xsk_ring_prod__needs_wakeup(&xsk->umem->fq))
> > >                ret = poll(fd,.....);
> > >         return;
> > > }
> > >
> > > This patch has been applied against commit aee450cbe482 ("bpf: silence warning messages in core")
> > >
> > > Structure of the patch set:
> > >
> > > Patch 1: Replaces the ndo_xsk_async_xmit with ndo_xsk_wakeup to
> > >           support waking up both Rx and Tx processing
> > > Patch 2: Implements the need_wakeup functionality in common code
> > > Patch 3-4: Add need_wakeup support to the i40e and ixgbe drivers
> > > Patch 5: Add need_wakeup support to libbpf
> > > Patch 6: Add need_wakeup support to the xdpsock sample application
> > >
> > > Thanks: Magnus
> > >
> > > Magnus Karlsson (6):
> > >    xsk: replace ndo_xsk_async_xmit with ndo_xsk_wakeup
> > >    xsk: add support for need_wakeup flag in AF_XDP rings
> > >    i40e: add support for AF_XDP need_wakup feature
> > >    ixgbe: add support for AF_XDP need_wakup feature
> > >    libbpf: add support for need_wakeup flag in AF_XDP part
> > >    samples/bpf: add use of need_sleep flag in xdpsock
> > >
> > >   drivers/net/ethernet/intel/i40e/i40e_main.c        |   5 +-
> > >   drivers/net/ethernet/intel/i40e/i40e_xsk.c         |  23 ++-
> > >   drivers/net/ethernet/intel/i40e/i40e_xsk.h         |   2 +-
> > >   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   5 +-
> > >   .../net/ethernet/intel/ixgbe/ixgbe_txrx_common.h   |   2 +-
> > >   drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c       |  20 ++-
> > >   include/linux/netdevice.h                          |  18 +-
> > >   include/net/xdp_sock.h                             |  33 +++-
> > >   include/uapi/linux/if_xdp.h                        |  13 ++
> > >   net/xdp/xdp_umem.c                                 |   6 +-
> > >   net/xdp/xsk.c                                      |  93 +++++++++-
> > >   net/xdp/xsk_queue.h                                |   1 +
> > >   samples/bpf/xdpsock_user.c                         | 191 +++++++++++++--------
> > >   tools/include/uapi/linux/if_xdp.h                  |  13 ++
> > >   tools/lib/bpf/xsk.c                                |   4 +
> > >   tools/lib/bpf/xsk.h                                |   6 +
> > >   16 files changed, 343 insertions(+), 92 deletions(-)
> > >
> > > --
> > > 2.7.4
> > >
> >
>
