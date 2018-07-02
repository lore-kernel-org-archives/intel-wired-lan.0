From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 2 Jul 2018 23:27:03 +0000
Subject: [Intel-wired-lan] [PATCH] fq_codel: fix NULL pointer deref in
 fq_codel_reset
In-Reply-To: <CANn89iLL1_KnRi5a2oZfvc2rxCuGc5CfgyRWEkdx4d3kK6wpwg@mail.gmail.com>
References: <20180608000636.4338-1-jacob.e.keller@intel.com>
 <02874ECE860811409154E81DA85FBB5884BC1945@ORSMSX115.amr.corp.intel.com>
 <CANn89iLL1_KnRi5a2oZfvc2rxCuGc5CfgyRWEkdx4d3kK6wpwg@mail.gmail.com>
Message-ID: <02874ECE860811409154E81DA85FBB5884BDDA14@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Eric Dumazet [mailto:edumazet at google.com]
> Sent: Friday, June 08, 2018 8:01 AM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: Re: [PATCH] fq_codel: fix NULL pointer deref in fq_codel_reset
> 
> Not sure this is the right fix.
> 
> It is very strange that
> 
> ->init()   (failure) -> reset()  ,  then ->destroy()
> 
> Why reset() is called before a destroy, I have no idea.
> 
> Anyway you must send patches to netdev@
> 
> Thanks.

If you have a better suggestion, I'm all ears.

I've heard that we should set qflows_cnt to 0 instead of checking the null pointer directly. I'm fine with that solution too.

I'd be fine removing the reset() call also, if you think that's better. I don't know if that would adversely impact the other schedulers though.

Thanks,
Jake
 

