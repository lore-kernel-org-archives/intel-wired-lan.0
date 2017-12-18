From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Mon, 18 Dec 2017 14:05:56 +0100
Subject: [Intel-wired-lan] [bpf-next V1-RFC PATCH 03/14] i40e: setup
 xdp_rxq_info
In-Reply-To: <CAJ+HfNgYvuHP72g04ZH1DR_svQtnSPi1Z_TqLVDvS-L9ijvh=A@mail.gmail.com>
References: <151316391502.14967.13292358380181773729.stgit@firesoul>
 <151316397618.14967.13648763339440521538.stgit@firesoul>
 <CAJ+HfNgYvuHP72g04ZH1DR_svQtnSPi1Z_TqLVDvS-L9ijvh=A@mail.gmail.com>
Message-ID: <20171218140556.51cef95c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 18 Dec 2017 11:52:08 +0100
Bj?rn T?pel <bjorn.topel@gmail.com> wrote:

> > +       /* Flow director side channel does not invoke XDP/bpf */
> > +       if (rx_ring->vsi->type == I40E_VSI_FDIR)
> > +               xdp_rxq_info_type(&rx_ring->xdp_rxq, RXQ_TYPE_SINK);  
> 
> For me, it doesn't make sense to expose the FD Rx ring outside the
> scope of i40e driver. Check against VSI_MAIN in setup/cleanup so the
> FD ring is not exposed outside the driver. Maybe you can get rid of
> the RXQ_TYPE_SINK as well then.

Okay, took this advice and changed patch to instead check against
I40E_VSI_MAIN.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
