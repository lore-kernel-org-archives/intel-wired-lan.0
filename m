From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 9 Oct 2019 18:06:53 -0700
Subject: [Intel-wired-lan] FW: [PATCH bpf-next 2/4] xsk: allow AF_XDP
 sockets to receive packets directly from a queue
In-Reply-To: <2032d58c-916f-d26a-db14-bd5ba6ad92b9@intel.com>
References: <1570515415-45593-1-git-send-email-sridhar.samudrala@intel.com>
 <1570515415-45593-3-git-send-email-sridhar.samudrala@intel.com>
 <CAADnVQ+XxmvY0cs8MYriMMd7=2TSEm4zCtB+fs2vkwdUY6UgAQ@mail.gmail.com>
 <3ED8E928C4210A4289A677D2FEB48235140134CE@fmsmsx111.amr.corp.intel.com>
 <2bc26acd-170d-634e-c066-71557b2b3e4f@intel.com>
 <CAADnVQ+qq6RLMjh5bB1ugXP5p7vYM2F1fLGFQ2pL=2vhCLiBdA@mail.gmail.com>
 <2032d58c-916f-d26a-db14-bd5ba6ad92b9@intel.com>
Message-ID: <CAADnVQ+CH1YM52+LfybLS+NK16414Exrvk1QpYOF=HaT4KRaxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Oct 9, 2019 at 12:12 PM Samudrala, Sridhar
<sridhar.samudrala@intel.com> wrote:
> >>     34.57%  xdpsock          xdpsock           [.] main
> >>     17.19%  ksoftirqd/1      [kernel.vmlinux]  [k] ___bpf_prog_run
> >>     13.12%  xdpsock          [kernel.vmlinux]  [k] ___bpf_prog_run
> >
> > That must be a bad joke.
> > The whole patch set is based on comparing native code to interpreter?!
> > It's pretty awesome that interpreter is only 1.5x slower than native x86.
> > Just turn the JIT on.
>
> Thanks Alexei for pointing out that i didn't have JIT on.
> When i turn it on, the performance improvement is a more modest 1.5x
> with rxdrop and 1.2x with l2fwd.

I want to see perf reports back to back with proper performance analysis.

> >
> > Obvious Nack to the patch set.
> >
>
> Will update the patchset with the right performance data and address
> feedback from Bjorn.
> Hope you are not totally against direct XDP approach as it does provide
> value when an AF_XDP socket is bound to a queue and a HW filter can
> direct packets targeted for that queue.

I used to be in favor of providing "prog bypass" for af_xdp,
because of anecdotal evidence that it will make af_xdp faster.
Now seeing the numbers and the way they were collected
I'm against such bypass.
I want to see hard proof that trivial bpf prog is actually slowing things down
before reviewing any new patch sets.
