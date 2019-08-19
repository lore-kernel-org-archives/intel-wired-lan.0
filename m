From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Mon, 19 Aug 2019 09:39:28 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 0/5] Add support for SKIP_BPF
 flag for AF_XDP sockets
In-Reply-To: <331CAEDB-776A-4928-93EF-F45F1339848F@gmail.com>
References: <1565840783-8269-1-git-send-email-sridhar.samudrala@intel.com>
 <bebfb097-5357-91d8-ebc7-2f8ede392ad7@intel.com>
 <cc3a09eb-bcb8-a6e1-7175-77bddaf10c11@intel.com>
 <CAJ+HfNj=devuEky3VwbibA-j+o=bKi4Gg=MeHsuuDGAKc9p2Vw@mail.gmail.com>
 <331CAEDB-776A-4928-93EF-F45F1339848F@gmail.com>
Message-ID: <CAJ+HfNgeSYRuQ8+80zepsAj8f+gdXEqsnbebuvmJggYOBUsj9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, 17 Aug 2019 at 00:08, Jonathan Lemon <jonathan.lemon@gmail.com> wrote:
> On 16 Aug 2019, at 6:32, Bj?rn T?pel wrote:
[...]
> >
> > Today, from a driver perspective, to enable XDP you pass a struct
> > bpf_prog pointer via the ndo_bpf. The program get executed in
> > BPF_PROG_RUN (via bpf_prog_run_xdp) from include/linux/filter.h.
> >
> > I think it's possible to achieve what you're doing w/o *any* driver
> > modification. Pass a special, invalid, pointer to the driver (say
> > (void *)0x1 or smth more elegant), which has a special handling in
> > BPF_RUN_PROG e.g. setting a per-cpu state and return XDP_REDIRECT. The
> > per-cpu state is picked up in xdp_do_redirect and xdp_flush.
> >
> > An approach like this would be general, and apply to all modes
> > automatically.
> >
> > Thoughts?
>
> All the default program does is check that the map entry contains a xsk,
> and call bpf_redirect_map().  So this is pretty much the same as above,
> without any special case handling.
>
> Why would this be so expensive?  Is the JIT compilation time being
> counted?

No, not the JIT compilation time, only the fast-path. The gain is from
removing the indirect call (hitting a retpoline) when calling the XDP
program, and reducing code from xdp_do_redirect/xdp_flush.

But, as Jakub pointed out, the XDP batching work by Maciej, might
reduce the retpoline impact quite a bit.


Bj?rn
