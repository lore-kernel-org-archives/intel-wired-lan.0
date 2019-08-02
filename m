From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Fri, 2 Aug 2019 09:26:55 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next v4 03/11] libbpf: add flags
 to umem config
In-Reply-To: <CAEf4Bzar-KgCjUEfKVeWzcB77xvXDagZFRQKDvWo1o9-JzCirw@mail.gmail.com>
References: <20190724051043.14348-1-kevin.laatz@intel.com>
 <20190730085400.10376-1-kevin.laatz@intel.com>
 <20190730085400.10376-4-kevin.laatz@intel.com>
 <CAJ+HfNifxfgycmZFz8eBZq=FZXAgNQezNqUiy3Q1z4JBrUEkew@mail.gmail.com>
 <CAEf4BzbTbX-Teth+4-yiorO-oHp+JhGfW2e08iBoCsBA4JCbMQ@mail.gmail.com>
 <CAJ+HfNhYe_FgV0tGTLzaFGVSiimVnthgESN8Psdtpxw696w0OQ@mail.gmail.com>
 <CAEf4Bzar-KgCjUEfKVeWzcB77xvXDagZFRQKDvWo1o9-JzCirw@mail.gmail.com>
Message-ID: <CAJ+HfNhQFs4jgJORmdPh6zeJXXMd-9j3YgdSUac3PxRQrGzNDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2 Aug 2019 at 09:19, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Aug 1, 2019 at 12:34 AM Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
> >
[...]
> >
> > Old application, dynamically linked to new libbpf.so will crash,
> > right? Old application passes old version of xsk_umem_config, and new
> > library accesses (non-existing) flag struct member.
>
> I think we have similar problems for all the _xattr type of commands
> (as well some of btf stuff accepting extra opts structs). How is this
> problem solved in general? Do we version same function multiple times,
> one for each added field? It feels like there should be some better
> way to handle this...
>

If the size of the struct was passed as an argument (and extra care is
taken when adding members to the struct), it could be handled w/o
versioning... but that's not the case here. :-( Versioning is a mess
to deal with, so I'd be happy if it could be avoided...
