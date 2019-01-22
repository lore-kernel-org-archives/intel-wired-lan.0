From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 22 Jan 2019 07:51:32 +0100
Subject: [Intel-wired-lan] [PATCH] i40e: replace switch-statement with
 if-clause
In-Reply-To: <20190121201213.4cb33c97@redhat.com>
References: <20190121163356.31332-1-bjorn.topel@gmail.com>
 <60f67e64-568c-bf04-5e9c-0429c5ae2882@molgen.mpg.de>
 <CAJ+HfNhg=iZN2x7F0As_WtpiOsQZXNPts4-XSOXVRYRN--WrFw@mail.gmail.com>
 <20190121201213.4cb33c97@redhat.com>
Message-ID: <CAJ+HfNh413-hLDM+aOTcD6H8VOvtbRD=B2JEtryhTLayp4+kLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Den m?n 21 jan. 2019 kl 20:12 skrev Jesper Dangaard Brouer <brouer@redhat.com>:
>
> On Mon, 21 Jan 2019 17:53:45 +0100
> Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
>
> > > If that jump tables are a common problem, I wonder, why the compiler
> > > cannot be adapted to generate better performing code or an option passed
> > > to the compiler.
> > >
> >
> > It might make sense to use -fno-jump-tables or a better value for the
> > case-values-threshold param for the i40e code. However, doing that
> > would require a much broader testing, since there are a number of
> > different places where a switch-statement is used. And depending on
> > the context, a jump table might still be a better option.
>
> I recently found out that it is possible to disable GCC attributes per
> function basis.  See how I played with it here:
>   https://github.com/xdp-project/xdp-project/blob/master/areas/dma/dma01_test_hellwig_direct_dma.org#investigate-overhead-of-bpf-indirect-retpoline
>

Nice! ...but does that help here? I mean, excluding the thunks in jump
table call generation isn't really an option?

Is it possible in a function scoped way to change, say, the
case-values-threshold?


Bj?rn

> --
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
