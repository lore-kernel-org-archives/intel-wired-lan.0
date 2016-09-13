From: Tom Herbert <tom@herbertland.com>
Date: Mon, 12 Sep 2016 17:03:25 -0700
Subject: [Intel-wired-lan] [net-next PATCH v3 2/3] e1000: add initial
	XDP support
In-Reply-To: <1473723968.18970.111.camel@edumazet-glaptop3.roam.corp.google.com>
References: <20160912220312.5610.77528.stgit@john-Precision-Tower-5810>
 <20160912221351.5610.29043.stgit@john-Precision-Tower-5810>
 <1473720399.18970.91.camel@edumazet-glaptop3.roam.corp.google.com>
 <20160912230745.GA24171@ast-mbp.thefacebook.com>
 <1473723968.18970.111.camel@edumazet-glaptop3.roam.corp.google.com>
Message-ID: <CALx6S35CE+ZYbGm96Y5YKnTqU0zfhg9_h0VSpD3ot8xB-scdFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Sep 12, 2016 at 4:46 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> On Mon, 2016-09-12 at 16:07 -0700, Alexei Starovoitov wrote:
>
>> yep. there are various ways to shoot yourself in the foot with xdp.
>> The simplest program that drops all the packets will make the box unpingable.
>
> Well, my comment was about XDP_TX only, not about XDP_DROP or driving a
> scooter on 101 highway ;)
>
> This XDP_TX thing was one of the XDP marketing stuff, but there is
> absolutely no documentation on it, warning users about possible
> limitations/outcomes.
>
> BTW, I am not sure mlx4 implementation even works, vs BQL :
>
> mlx4_en_xmit_frame() does not call netdev_tx_sent_queue(),
> but tx completion will call netdev_tx_completed_queue() -> crash
>
> Do we have one test to validate that a XDP_TX implementation is actually
> correct ?
>
Obviously not for e1000 :-(. We really need some real test and
performance results and analysis on the interaction between the stack
data path and XDP data path. The fact that these changes are being
passed of as something only needed for KCM is irrelevant, e1000 is a
well deployed a NIC and there's no restriction that I see that would
prevent any users from enabling this feature on real devices. So these
patches need to be tested and justified. Eric's skepticism in all this
really doesn't surprise me...

Tom

>
>
