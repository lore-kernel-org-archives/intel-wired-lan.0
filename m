From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Fri, 25 Oct 2019 11:07:29 +0200
Subject: [Intel-wired-lan] FW: [PATCH bpf-next 2/4] xsk: allow AF_XDP
 sockets to receive packets directly from a queue
In-Reply-To: <CAADnVQKwnMChzeGaC66A99cHn5szB4hPZaGXq8JAhd8sjrdGeA@mail.gmail.com>
References: <1570515415-45593-3-git-send-email-sridhar.samudrala@intel.com>
 <CAADnVQ+XxmvY0cs8MYriMMd7=2TSEm4zCtB+fs2vkwdUY6UgAQ@mail.gmail.com>
 <3ED8E928C4210A4289A677D2FEB48235140134CE@fmsmsx111.amr.corp.intel.com>
 <2bc26acd-170d-634e-c066-71557b2b3e4f@intel.com>
 <CAADnVQ+qq6RLMjh5bB1ugXP5p7vYM2F1fLGFQ2pL=2vhCLiBdA@mail.gmail.com>
 <2032d58c-916f-d26a-db14-bd5ba6ad92b9@intel.com>
 <CAADnVQ+CH1YM52+LfybLS+NK16414Exrvk1QpYOF=HaT4KRaxg@mail.gmail.com>
 <acf69635-5868-f876-f7da-08954d1f690e@intel.com>
 <20191019001449.fk3gnhih4nx724pm@ast-mbp>
 <6f281517-3785-ce46-65de-e2f78576783b@intel.com>
 <20191019022525.w5xbwkav2cpqkfwi@ast-mbp> <877e4zd8py.fsf@toke.dk>
 <CAJ+HfNj07FwmU2GGpUYw56PRwu4pHyHNSkbCOogbMB5zB2QqWA@mail.gmail.com>
 <7642a460-9ba3-d9f7-6cf8-aac45c7eef0d@intel.com>
 <CAADnVQ+jiEO+jnFR-G=xG=zz7UOSBieZbc1NN=sSnAwvPaJjUQ@mail.gmail.com>
 <8956a643-0163-5345-34fa-3566762a2b7d@intel.com>
 <CAADnVQKwnMChzeGaC66A99cHn5szB4hPZaGXq8JAhd8sjrdGeA@mail.gmail.com>
Message-ID: <CAJ+HfNg8NMS7k+f4K3PH-cjA9XFbBbEetfZT55J0ntZejxV-PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 23 Oct 2019 at 19:42, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 22, 2019 at 12:06 PM Samudrala, Sridhar
> <sridhar.samudrala@intel.com> wrote:
> >
> > OK. Here is another data point that shows the perf report with the same test but CPU mitigations
> > turned OFF. Here bpf_prog overhead goes down from almost (10.18 + 4.51)% to (3.23 + 1.44%).
> >
> >    21.40%  ksoftirqd/28     [i40e]                     [k] i40e_clean_rx_irq_zc
> >    14.13%  xdpsock          [i40e]                     [k] i40e_clean_rx_irq_zc
> >     8.33%  ksoftirqd/28     [kernel.vmlinux]           [k] xsk_rcv
> >     6.09%  ksoftirqd/28     [kernel.vmlinux]           [k] xdp_do_redirect
> >     5.19%  xdpsock          xdpsock                    [.] main
> >     3.48%  ksoftirqd/28     [kernel.vmlinux]           [k] bpf_xdp_redirect_map
> >     3.23%  ksoftirqd/28     bpf_prog_3c8251c7e0fef8db  [k] bpf_prog_3c8251c7e0fef8db
> >
> > So a major component of the bpf_prog overhead seems to be due to the CPU vulnerability mitigations.
>
> I feel that it's an incorrect conclusion because JIT is not doing
> any retpolines (because there are no indirect calls in bpf).
> There should be no difference in bpf_prog runtime with or without mitigations.
> Also you're running root, so no spectre mitigations either.
>
> This 3% seems like a lot for a function that does few loads that should
> hit d-cache and one direct call.
> Please investigate why you're seeing this 10% cpu cost when mitigations are on.
> perf report/annotate is the best.
> Also please double check that you're using the latest perf.
> Since bpf performance analysis was greatly improved several versions ago.
> I don't think old perf will be showing bogus numbers, but better to
> run the latest.
>

For comparison, on my Skylake 3GHz with mitigations off. (I have one
internal patch that inlines xsk_rcv() into __xsk_map_redirect, so
that's why it's not showing xsk_rcv(). I'll upstream that...)

  41.79%  [kernel]                   [k] i40e_clean_rx_irq_zc
  15.55%  [kernel]                   [k] __xsk_map_redirect
   9.87%  [kernel]                   [k] xdp_do_redirect
   6.89%  [kernel]                   [k] xsk_umem_peek_addr
   6.37%  [kernel]                   [k] bpf_xdp_redirect_map
   5.02%  bpf_prog_992d9ddc835e5629  [k] bpf_prog_992d9ddc835e5629

Again, it might look weird that simple functions like
bpf_xdp_redirect_map and the XDP program is 6% and 5%.

Let's dig into that. I let the xdpsock program (rxdrop) run on one
core 22, and the ksoftirqd on core 20. Core 20 is only processing
packets, plus the regular kernel householding. I did a processor trace
for core 20 for 207 936 packets.

In total it's 84,407,427 instructions, and bpf_xdp_redirect_map() is
8,109,504 instructions, which is 9.6%. bpf_xdp_redirect_map() executes
39 instructions for AF_XDP. As perf is reporting less than 9.6% means
that the IPC count of that function is more than the average which
perf-stat reports as IPC of 2.88.

The BPF program executes fewer instructions than
bpf_xdp_redirect_map(), so given that perf shows 5%, means that the
IPC count is better than average here as well.

So, it's roughly 405 instructions per packet, and with an IPC of 2.88
that'll give ~140 cycles per packet, which on this machine
(3,000,000,000/140) is ~21.4 Mpps. The xdpsock application reports
21. This is sane.

The TL;DR version is: 6% and 5% for bpf_xdp_redirect_map and
bpf_prog_992d9ddc835e5629 might seem high, but it's just that the
total number of instruction executing is fairly low. So, even though
the functions are small in size, it will show up as non-negligible
percentage in perf.

At these speeds, really small things have an impact on
performance. DPDK has ~50 cycles per packet.


Bj?rn



> > The other component is the bpf_xdp_redirect_map() codepath.
> >
> > Let me know if it helps to collect any other data that should further help with the perf analysis.
> >
