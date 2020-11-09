From: John Fastabend <john.fastabend@gmail.com>
Date: Mon, 09 Nov 2020 12:47:32 -0800
Subject: [Intel-wired-lan] [PATCH bpf-next 2/6] samples/bpf: increment
 Tx stats at sending
In-Reply-To: <1604498942-24274-3-git-send-email-magnus.karlsson@gmail.com>
References: <1604498942-24274-1-git-send-email-magnus.karlsson@gmail.com>
 <1604498942-24274-3-git-send-email-magnus.karlsson@gmail.com>
Message-ID: <5fa9aae46c442_8c0e208b5@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Increment the statistics over how many Tx packets have been sent at
> the time of sending instead of at the time of completion. This as a
> completion event means that the buffer has been sent AND returned to
> user space. The packet always gets sent shortly after sendto() is
> called. The kernel might, for performance reasons, decide to not
> return every single buffer to user space immediately after sending,
> for example, only after a batch of packets have been
> transmitted. Incrementing the number of packets sent at completion,
> will in that case be confusing as if you send a single packet, the
> counter might show zero for a while even though the packet has been
> transmitted.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---

LGTM. Just one question then if we wanted to know the old value, packet
completion counter it looks like (tx_npkts - outstanding_tx) would give
that value?

Acked-by: John Fastabend <john.fastabend@gmail.com>
