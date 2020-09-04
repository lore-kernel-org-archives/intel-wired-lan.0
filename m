From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Fri, 4 Sep 2020 16:27:51 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 0/6] xsk: exit NAPI loop when
 AF_XDP Rx ring is full
In-Reply-To: <20200904135332.60259-1-bjorn.topel@gmail.com>
References: <20200904135332.60259-1-bjorn.topel@gmail.com>
Message-ID: <20200904162751.632c4443@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri,  4 Sep 2020 15:53:25 +0200
Bj?rn T?pel <bjorn.topel@gmail.com> wrote:

> On my machine the "one core scenario Rx drop" performance went from
> ~65Kpps to 21Mpps. In other words, from "not usable" to
> "usable". YMMV.

We have observed this kind of dropping off an edge before with softirq
(when userspace process runs on same RX-CPU), but I thought that Eric
Dumazet solved it in 4cd13c21b207 ("softirq: Let ksoftirqd do its job").

I wonder what makes AF_XDP different or if the problem have come back?

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

