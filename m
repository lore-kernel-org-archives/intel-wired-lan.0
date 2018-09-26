From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Wed, 26 Sep 2018 16:29:42 +0200
Subject: [Intel-wired-lan] [PATCH 3/5] ixgbe: add AF_XDP zero-copy Rx
 support
In-Reply-To: <20180925075714.75db73ac@cakuba.netronome.com>
References: <20180924163557.1187-1-bjorn.topel@gmail.com>
 <20180924163557.1187-4-bjorn.topel@gmail.com>
 <20180925075714.75db73ac@cakuba.netronome.com>
Message-ID: <CAJ+HfNgidjYYzntZUQEdY=GtYfDNPwkvfpQ7T2xgfpwdcNFtzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Den tis 25 sep. 2018 kl 16:57 skrev Jakub Kicinski
<jakub.kicinski@netronome.com>:
>
> On Mon, 24 Sep 2018 18:35:55 +0200, Bj?rn T?pel wrote:
> > +     if (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)
> > +             return -EINVAL;
> > +
> > +     if (adapter->flags & IXGBE_FLAG_DCB_ENABLED)
> > +             return -EINVAL;
>
> Hm, should you add UMEM checks to all the places these may get
> enabled?  Like fabf1bce103a ("ixgbe: Prevent unsupported configurations
> with XDP") did?

Actually, I can remove these checks, since it's already checked by the
XDP path. AF_XDP ZC is enabled only when XDP is enabled. So there's no
need to have the XDP checks in the AF_XDP path.

Bj?rn
