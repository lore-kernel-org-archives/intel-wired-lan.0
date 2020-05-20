From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Wed, 20 May 2020 19:19:22 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next v4 07/15] i40e: separate
 kernel allocated rx_bi rings from AF_XDP rings
In-Reply-To: <20200520100218.56e4ee2c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20200520094742.337678-1-bjorn.topel@gmail.com>
 <20200520094742.337678-8-bjorn.topel@gmail.com>
 <20200520100218.56e4ee2c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <CAJ+HfNgE5TTFfGa-XNS7_=ukcNJ=jMUoBLmmA_c=iVY3C_DXZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 20 May 2020 at 19:02, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 20 May 2020 11:47:34 +0200 Bj?rn T?pel wrote:
> > From: Bj?rn T?pel <bjorn.topel@intel.com>
> >
> > Continuing the path to support MEM_TYPE_XSK_BUFF_POOL, the AF_XDP
> > zero-copy/sk_buff rx_bi rings are now separate. Functions to properly
> > allocate the different rings are added as well.
> >
> > v3->v4: Made i40e_fd_handle_status() static. (kbuild test robot)
> >
> > Cc: intel-wired-lan at lists.osuosl.org
> > Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
>
> There is a new warning here, at least one. But i40e has so many
> existing warnings with W=1, I can't figure out which one is new :(
>
> You most likely forgot to adjust kdoc somewhere after adding or
> removing a function parameter.

Hmm, yes. A lot of warnings there. I'll see if I can find it. Thanks!
