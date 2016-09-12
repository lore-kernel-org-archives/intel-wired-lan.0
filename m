From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Mon, 12 Sep 2016 16:46:08 -0700
Subject: [Intel-wired-lan] [net-next PATCH v3 2/3] e1000: add initial
	XDP support
In-Reply-To: <20160912230745.GA24171@ast-mbp.thefacebook.com>
References: <20160912220312.5610.77528.stgit@john-Precision-Tower-5810>
 <20160912221351.5610.29043.stgit@john-Precision-Tower-5810>
 <1473720399.18970.91.camel@edumazet-glaptop3.roam.corp.google.com>
 <20160912230745.GA24171@ast-mbp.thefacebook.com>
Message-ID: <1473723968.18970.111.camel@edumazet-glaptop3.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2016-09-12 at 16:07 -0700, Alexei Starovoitov wrote:

> yep. there are various ways to shoot yourself in the foot with xdp.
> The simplest program that drops all the packets will make the box unpingable.

Well, my comment was about XDP_TX only, not about XDP_DROP or driving a
scooter on 101 highway ;)

This XDP_TX thing was one of the XDP marketing stuff, but there is
absolutely no documentation on it, warning users about possible
limitations/outcomes.

BTW, I am not sure mlx4 implementation even works, vs BQL :

mlx4_en_xmit_frame() does not call netdev_tx_sent_queue(),
but tx completion will call netdev_tx_completed_queue() -> crash

Do we have one test to validate that a XDP_TX implementation is actually
correct ?



