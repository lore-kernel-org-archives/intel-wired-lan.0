From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 Aug 2019 00:19:29 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next v4 03/11] libbpf: add flags
 to umem config
In-Reply-To: <CAJ+HfNhYe_FgV0tGTLzaFGVSiimVnthgESN8Psdtpxw696w0OQ@mail.gmail.com>
References: <20190724051043.14348-1-kevin.laatz@intel.com>
 <20190730085400.10376-1-kevin.laatz@intel.com>
 <20190730085400.10376-4-kevin.laatz@intel.com>
 <CAJ+HfNifxfgycmZFz8eBZq=FZXAgNQezNqUiy3Q1z4JBrUEkew@mail.gmail.com>
 <CAEf4BzbTbX-Teth+4-yiorO-oHp+JhGfW2e08iBoCsBA4JCbMQ@mail.gmail.com>
 <CAJ+HfNhYe_FgV0tGTLzaFGVSiimVnthgESN8Psdtpxw696w0OQ@mail.gmail.com>
Message-ID: <CAEf4Bzar-KgCjUEfKVeWzcB77xvXDagZFRQKDvWo1o9-JzCirw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Aug 1, 2019 at 12:34 AM Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
>
> On Thu, 1 Aug 2019 at 08:59, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Jul 31, 2019 at 8:21 AM Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
> > >
> > > On Tue, 30 Jul 2019 at 19:43, Kevin Laatz <kevin.laatz@intel.com> wrote:
> > > >
> > > > This patch adds a 'flags' field to the umem_config and umem_reg structs.
> > > > This will allow for more options to be added for configuring umems.
> > > >
> > > > The first use for the flags field is to add a flag for unaligned chunks
> > > > mode. These flags can either be user-provided or filled with a default.
> > > >
> > > > Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
> > > > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > > >
> > > > ---
> > > > v2:
> > > >   - Removed the headroom check from this patch. It has moved to the
> > > >     previous patch.
> > > >
> > > > v4:
> > > >   - modified chunk flag define
> > > > ---
> >
> > [...]
> >
> > > > diff --git a/tools/lib/bpf/xsk.h b/tools/lib/bpf/xsk.h
> > > > index 833a6e60d065..44a03d8c34b9 100644
> > > > --- a/tools/lib/bpf/xsk.h
> > > > +++ b/tools/lib/bpf/xsk.h
> > > > @@ -170,12 +170,14 @@ LIBBPF_API int xsk_socket__fd(const struct xsk_socket *xsk);
> > > >  #define XSK_UMEM__DEFAULT_FRAME_SHIFT    12 /* 4096 bytes */
> > > >  #define XSK_UMEM__DEFAULT_FRAME_SIZE     (1 << XSK_UMEM__DEFAULT_FRAME_SHIFT)
> > > >  #define XSK_UMEM__DEFAULT_FRAME_HEADROOM 0
> > > > +#define XSK_UMEM__DEFAULT_FLAGS 0
> > > >
> > > >  struct xsk_umem_config {
> > > >         __u32 fill_size;
> > > >         __u32 comp_size;
> > > >         __u32 frame_size;
> > > >         __u32 frame_headroom;
> > > > +       __u32 flags;
> > >
> > > And the flags addition here, unfortunately, requires symbol versioning
> > > of xsk_umem__create(). That'll be the first in libbpf! :-)
> >
> > xsk_umem_config is passed by pointer to xsk_umem__create(), so this
> > doesn't break ABI, does it?
> >
>
> Old application, dynamically linked to new libbpf.so will crash,
> right? Old application passes old version of xsk_umem_config, and new
> library accesses (non-existing) flag struct member.

I think we have similar problems for all the _xattr type of commands
(as well some of btf stuff accepting extra opts structs). How is this
problem solved in general? Do we version same function multiple times,
one for each added field? It feels like there should be some better
way to handle this...

>
>
> Bj?rn
>
>
> > >
> > >
> > > Bj?rn
> > >
> > > >  };
> > > >
> > > >  /* Flags for the libbpf_flags field. */
> > > > --
> > > > 2.17.1
> > > >
> > > > _______________________________________________
> > > > Intel-wired-lan mailing list
> > > > Intel-wired-lan at osuosl.org
> > > > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
