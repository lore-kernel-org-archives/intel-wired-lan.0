From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Fri, 17 Jan 2020 13:32:07 +0100
Subject: [Intel-wired-lan] zero-copy between interfaces
In-Reply-To: <14f9e1bf5c3a41dbaec53f83cb5f0564@isi.edu>
References: <14f9e1bf5c3a41dbaec53f83cb5f0564@isi.edu>
Message-ID: <CAJ+HfNhdPEe34DVUAj4eHxLkBUSTo2CXbLHoWu+dwFCp753oMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 13 Jan 2020 at 01:28, Ryan Goodfellow <rgoodfel@isi.edu> wrote:
>
[...]
>
> I could not get zero-copy to work with the i40e driver as it would crash. I've
> attached the corresponding traces from dmesg.

Thanks Ryan! I had a look at the crash, and it's in the XDP setup:

i40e_xdp_setup:
...
 for (i = 0; i < vsi->num_queue_pairs; i++)
     WRITE_ONCE(vsi->rx_rings[i]->xdp_prog, vsi->xdp_prog);

and the vsi->rx_ring[0] is NULL. This is clearly broken.

It would help with more lines from your dmesg: the cut i40e log hints
that something is really broken:

[  328.579154] i40e 0000:b7:00.2: failed to get tracking for 256
queues for VSI 0 err -12
[  328.579280] i40e 0000:b7:00.2: setup of MAIN VSI failed
[  328.579367] i40e 0000:b7:00.2: can't remove VEB 162 with 0 VSIs left

Is it possible to dig out the complete log?

Thanks!
Bj?rn
