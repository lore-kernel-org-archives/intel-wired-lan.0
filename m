From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Fri, 4 Sep 2020 16:32:56 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 0/6] xsk: exit NAPI loop when
 AF_XDP Rx ring is full
In-Reply-To: <20200904162751.632c4443@carbon>
References: <20200904135332.60259-1-bjorn.topel@gmail.com>
 <20200904162751.632c4443@carbon>
Message-ID: <27e05518-99c6-15e2-b801-cbc0310630ef@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2020-09-04 16:27, Jesper Dangaard Brouer wrote:
> On Fri,  4 Sep 2020 15:53:25 +0200
> Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
> 
>> On my machine the "one core scenario Rx drop" performance went from
>> ~65Kpps to 21Mpps. In other words, from "not usable" to
>> "usable". YMMV.
> 
> We have observed this kind of dropping off an edge before with softirq
> (when userspace process runs on same RX-CPU), but I thought that Eric
> Dumazet solved it in 4cd13c21b207 ("softirq: Let ksoftirqd do its job").
> 
> I wonder what makes AF_XDP different or if the problem have come back?
> 

I would say this is not the same issue. The problem is that the softirq 
is busy dropping packets since the AF_XDP Rx is full. So, the cycles 
*are* split 50/50, which is not what we want in this case. :-)

This issue is more of a "Intel AF_XDP ZC drivers does stupid work", than 
fairness. If the Rx ring is full, then there is really no use to let the 
NAPI loop continue.

Would you agree, or am I rambling? :-P


Bj?rn
