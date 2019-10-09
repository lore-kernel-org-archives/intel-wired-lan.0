From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 9 Oct 2019 10:17:19 -0700
Subject: [Intel-wired-lan] FW: [PATCH bpf-next 2/4] xsk: allow AF_XDP
 sockets to receive packets directly from a queue
In-Reply-To: <2bc26acd-170d-634e-c066-71557b2b3e4f@intel.com>
References: <1570515415-45593-1-git-send-email-sridhar.samudrala@intel.com>
 <1570515415-45593-3-git-send-email-sridhar.samudrala@intel.com>
 <CAADnVQ+XxmvY0cs8MYriMMd7=2TSEm4zCtB+fs2vkwdUY6UgAQ@mail.gmail.com>
 <3ED8E928C4210A4289A677D2FEB48235140134CE@fmsmsx111.amr.corp.intel.com>
 <2bc26acd-170d-634e-c066-71557b2b3e4f@intel.com>
Message-ID: <CAADnVQ+qq6RLMjh5bB1ugXP5p7vYM2F1fLGFQ2pL=2vhCLiBdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Oct 9, 2019 at 9:53 AM Samudrala, Sridhar
<sridhar.samudrala@intel.com> wrote:
>
>
> >> +
> >> +u32 bpf_direct_xsk(const struct bpf_prog *prog, struct xdp_buff *xdp)
> >> +{
> >> +       struct xdp_sock *xsk;
> >> +
> >> +       xsk = xdp_get_xsk_from_qid(xdp->rxq->dev, xdp->rxq->queue_index);
> >> +       if (xsk) {
> >> +               struct bpf_redirect_info *ri =
> >> + this_cpu_ptr(&bpf_redirect_info);
> >> +
> >> +               ri->xsk = xsk;
> >> +               return XDP_REDIRECT;
> >> +       }
> >> +
> >> +       return XDP_PASS;
> >> +}
> >> +EXPORT_SYMBOL(bpf_direct_xsk);
> >
> > So you're saying there is a:
> > """
> > xdpsock rxdrop 1 core (both app and queue's irq pinned to the same core)
> >     default : taskset -c 1 ./xdpsock -i enp66s0f0 -r -q 1
> >     direct-xsk :taskset -c 1 ./xdpsock -i enp66s0f0 -r -q 1 6.1x improvement in drop rate """
> >
> > 6.1x gain running above C code vs exactly equivalent BPF code?
> > How is that possible?
>
> It seems to be due to the overhead of __bpf_prog_run on older processors
> (Ivybridge). The overhead is smaller on newer processors, but even on
> skylake i see around 1.5x improvement.
>
> perf report with default xdpsock
> ================================
> Samples: 2K of event 'cycles:ppp', Event count (approx.): 8437658090
> Overhead  Command          Shared Object     Symbol
>    34.57%  xdpsock          xdpsock           [.] main
>    17.19%  ksoftirqd/1      [kernel.vmlinux]  [k] ___bpf_prog_run
>    13.12%  xdpsock          [kernel.vmlinux]  [k] ___bpf_prog_run

That must be a bad joke.
The whole patch set is based on comparing native code to interpreter?!
It's pretty awesome that interpreter is only 1.5x slower than native x86.
Just turn the JIT on.

Obvious Nack to the patch set.
