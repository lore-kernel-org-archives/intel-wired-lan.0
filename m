From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Mon, 6 Aug 2018 10:22:10 +0200
Subject: [Intel-wired-lan] [PATCH v8 bpf-next 00/10] veth: Driver XDP
In-Reply-To: <20180803114538.382664c8@redhat.com>
References: <1533283098-2397-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
 <20180803114538.382664c8@redhat.com>
Message-ID: <82583528-9c49-5db8-db11-04d501ca0bfc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2018-08-03 11:45, Jesper Dangaard Brouer wrote:
> On Fri,  3 Aug 2018 16:58:08 +0900
> Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp> wrote:
> 
>> This patch set introduces driver XDP for veth.
>> Basically this is used in conjunction with redirect action of another XDP
>> program.
>>
>>    NIC -----------> veth===veth
>>   (XDP) (redirect)        (XDP)
>>
> 
> I'm was playing with V7 on my testlab yesterday and I noticed one
> fundamental issue.  You are not updating the "ifconfig" stats counters,
> when in XDP mode.  This makes receive or send via XDP invisible to
> sysadm/management tools.  This for-sure is going to cause confusion...
> 
> I took a closer look at other driver. The ixgbe driver is doing the
> right thing.  Driver i40e have a bug, where RX/TX stats are swapped
> getting (strange!).  

Indeed! Thanks for finding/reporting this! I'll have look!


Bj?rn

> The mlx5 driver is not updating the regular RX/TX
> counters, but A LOT of other ethtool stats counters (which are the ones
> I usually monitor when testing).
> 
> So, given other drivers also didn't get this right, we need to have a
> discussion outside your/this patchset.  Thus, I don't want to
> stop/stall this patchset, but this is something we need to fixup in a
> followup patchset to other drivers as well.
> 
> Thus, I'm acking the patchset, but I request that we do a joint effort
> of fixing this as followup patches.
> 
> Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
> 
