From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 23 Oct 2019 10:42:00 -0700
Subject: [Intel-wired-lan] FW: [PATCH bpf-next 2/4] xsk: allow AF_XDP
 sockets to receive packets directly from a queue
In-Reply-To: <8956a643-0163-5345-34fa-3566762a2b7d@intel.com>
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
Message-ID: <CAADnVQKwnMChzeGaC66A99cHn5szB4hPZaGXq8JAhd8sjrdGeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 22, 2019 at 12:06 PM Samudrala, Sridhar
<sridhar.samudrala@intel.com> wrote:
>
> OK. Here is another data point that shows the perf report with the same test but CPU mitigations
> turned OFF. Here bpf_prog overhead goes down from almost (10.18 + 4.51)% to (3.23 + 1.44%).
>
>    21.40%  ksoftirqd/28     [i40e]                     [k] i40e_clean_rx_irq_zc
>    14.13%  xdpsock          [i40e]                     [k] i40e_clean_rx_irq_zc
>     8.33%  ksoftirqd/28     [kernel.vmlinux]           [k] xsk_rcv
>     6.09%  ksoftirqd/28     [kernel.vmlinux]           [k] xdp_do_redirect
>     5.19%  xdpsock          xdpsock                    [.] main
>     3.48%  ksoftirqd/28     [kernel.vmlinux]           [k] bpf_xdp_redirect_map
>     3.23%  ksoftirqd/28     bpf_prog_3c8251c7e0fef8db  [k] bpf_prog_3c8251c7e0fef8db
>
> So a major component of the bpf_prog overhead seems to be due to the CPU vulnerability mitigations.

I feel that it's an incorrect conclusion because JIT is not doing
any retpolines (because there are no indirect calls in bpf).
There should be no difference in bpf_prog runtime with or without mitigations.
Also you're running root, so no spectre mitigations either.

This 3% seems like a lot for a function that does few loads that should
hit d-cache and one direct call.
Please investigate why you're seeing this 10% cpu cost when mitigations are on.
perf report/annotate is the best.
Also please double check that you're using the latest perf.
Since bpf performance analysis was greatly improved several versions ago.
I don't think old perf will be showing bogus numbers, but better to
run the latest.

> The other component is the bpf_xdp_redirect_map() codepath.
>
> Let me know if it helps to collect any other data that should further help with the perf analysis.
>
