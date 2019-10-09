From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 8 Oct 2019 18:20:15 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next 2/4] xsk: allow AF_XDP
 sockets to receive packets directly from a queue
In-Reply-To: <1570515415-45593-3-git-send-email-sridhar.samudrala@intel.com>
References: <1570515415-45593-1-git-send-email-sridhar.samudrala@intel.com>
 <1570515415-45593-3-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <CAADnVQ+XxmvY0cs8MYriMMd7=2TSEm4zCtB+fs2vkwdUY6UgAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Oct 7, 2019 at 11:18 PM Sridhar Samudrala
<sridhar.samudrala@intel.com> wrote:
> +
> +u32 bpf_direct_xsk(const struct bpf_prog *prog, struct xdp_buff *xdp)
> +{
> +       struct xdp_sock *xsk;
> +
> +       xsk = xdp_get_xsk_from_qid(xdp->rxq->dev, xdp->rxq->queue_index);
> +       if (xsk) {
> +               struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
> +
> +               ri->xsk = xsk;
> +               return XDP_REDIRECT;
> +       }
> +
> +       return XDP_PASS;
> +}
> +EXPORT_SYMBOL(bpf_direct_xsk);

So you're saying there is a:
"""
xdpsock rxdrop 1 core (both app and queue's irq pinned to the same core)
   default : taskset -c 1 ./xdpsock -i enp66s0f0 -r -q 1
   direct-xsk :taskset -c 1 ./xdpsock -i enp66s0f0 -r -q 1
6.1x improvement in drop rate
"""

6.1x gain running above C code vs exactly equivalent BPF code?
How is that possible?
