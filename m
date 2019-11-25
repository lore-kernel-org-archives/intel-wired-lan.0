From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 25 Nov 2019 17:44:26 +0100
Subject: [Intel-wired-lan] [PATCH net 1/2] i40e: need_wakeup flag might
 not be set for Tx
In-Reply-To: <adee745d-6522-309d-a944-7a54869ac945@mellanox.com>
References: <1573243090-2721-1-git-send-email-magnus.karlsson@intel.com>
 <adee745d-6522-309d-a944-7a54869ac945@mellanox.com>
Message-ID: <CAJ8uoz2xsdEqy5OoK_GRLZ8+nX1TdOPQAQ+pCrgELjSX6uw3+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Nov 25, 2019 at 4:40 PM Maxim Mikityanskiy <maximmi@mellanox.com> wrote:
>
> Hi Magnus,
>
> On 2019-11-08 21:58, Magnus Karlsson wrote:
> > This happens if there is at least one
> > outstanding packet that has not been completed by the hardware and we
> > get that corresponding completion (which will not generate an
> > interrupt since interrupts are disabled in the napi poll loop) between
> > the time we stopped processing the Tx completions and interrupts are
> > enabled again.
>
> > But if this completion interrupt occurs before interrupts
> > are enable, we lose it
> Why can't it happen for regular traffic? From your description it looks
> to me as if you can miss a completion for non-AF_XDP traffic, too. Is
> there any detail that makes this issue AF_XDP-specific?

It can happen for regular traffic too, but it does not matter in that
case since the application is not dependent on getting a notification
on completion. The only thing that will happen is that there is some
memory and HW descriptors being used for longer than necessary. It
will get completed and reused next time there is some Tx action.

In the cases where it matters, the skb path code has feature that arms
a later interrupt. I need to introduce something similar for the
AF_XDP ZC path.

/Magnus

> Thanks,
> Max
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
