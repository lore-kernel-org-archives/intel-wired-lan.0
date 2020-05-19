From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 19 May 2020 19:06:26 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next v3 07/15] i40e: separate
 kernel allocated rx_bi rings from AF_XDP rings
In-Reply-To: <20200519095539.570323c8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20200519085724.294949-8-bjorn.topel@gmail.com>
 <202005192351.j1H08VpV%lkp@intel.com>
 <c81b36a0-11dd-4b7f-fad8-85f31dced58c@intel.com>
 <20200519095539.570323c8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <CAJ+HfNiunSSR8yY3_wHdxW71kmxMXhsRg2TRv+OVvSg9UZCFWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 19 May 2020 at 18:55, Jakub Kicinski <kuba@kernel.org> wrote:
>
[...]
>
> While at it I also get this on patch 11 (gcc-10, W=1):
>
> drivers/net/ethernet/mellanox/mlx5/core/en_main.c: In function mlx5e_alloc_rq:
> drivers/net/ethernet/mellanox/mlx5/core/en_main.c:376:6: warning: variable num_xsk_frames set but not used [-Wunused-but-set-variable]
>    376 |  u32 num_xsk_frames = 0;
>        |      ^~~~~~~~~~~~~~

Ah, yes. Thanks!

I'll wait until tomorrow for more input, and then do a respin.


Bj?rn
