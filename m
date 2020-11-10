From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 10 Nov 2020 08:12:54 +0100
Subject: [Intel-wired-lan] [PATCH bpf-next 2/6] samples/bpf: increment
 Tx stats at sending
In-Reply-To: <5fa9aae46c442_8c0e208b5@john-XPS-13-9370.notmuch>
References: <1604498942-24274-1-git-send-email-magnus.karlsson@gmail.com>
 <1604498942-24274-3-git-send-email-magnus.karlsson@gmail.com>
 <5fa9aae46c442_8c0e208b5@john-XPS-13-9370.notmuch>
Message-ID: <CAJ8uoz1f=-2Dysg-iwo=Grn0eS5nJB0hNE8HuPeHYPgeE4Bfmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Nov 9, 2020 at 9:47 PM John Fastabend <john.fastabend@gmail.com> wrote:
>
> Magnus Karlsson wrote:
> > From: Magnus Karlsson <magnus.karlsson@intel.com>
> >
> > Increment the statistics over how many Tx packets have been sent at
> > the time of sending instead of at the time of completion. This as a
> > completion event means that the buffer has been sent AND returned to
> > user space. The packet always gets sent shortly after sendto() is
> > called. The kernel might, for performance reasons, decide to not
> > return every single buffer to user space immediately after sending,
> > for example, only after a batch of packets have been
> > transmitted. Incrementing the number of packets sent at completion,
> > will in that case be confusing as if you send a single packet, the
> > counter might show zero for a while even though the packet has been
> > transmitted.
> >
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
>
> LGTM. Just one question then if we wanted to know the old value, packet
> completion counter it looks like (tx_npkts - outstanding_tx) would give
> that value?

That is correct.

> Acked-by: John Fastabend <john.fastabend@gmail.com>
