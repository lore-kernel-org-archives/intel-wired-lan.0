From: Li,Rongqing <lirongqing@baidu.com>
Date: Wed, 13 Jan 2021 01:36:58 +0000
Subject: [Intel-wired-lan] [PATCH] igb: avoid premature Rx buffer reuse
In-Reply-To: <CAKgT0UccR7Mh4efd+d193bvQNP2-QMdBxP0uk0__0Z+dYepNjg@mail.gmail.com>
References: <1609990905-29220-1-git-send-email-lirongqing@baidu.com>
 <CAKgT0Ucar6h-V2pQK6Gx4wrwFzJqySfv-MGXtW1yEc6Jq3uNSQ@mail.gmail.com>
 <65a7da2dc20c4fa5b69270f078026100@baidu.com>
 <CAKgT0UccR7Mh4efd+d193bvQNP2-QMdBxP0uk0__0Z+dYepNjg@mail.gmail.com>
Message-ID: <005b033dad0a47d7858a9d71d20acda0@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> Sent: Wednesday, January 13, 2021 5:23 AM
> To: Li,Rongqing <lirongqing@baidu.com>
> Cc: Netdev <netdev@vger.kernel.org>; intel-wired-lan
> <intel-wired-lan@lists.osuosl.org>; Bj?rn T?pel <bjorn.topel@intel.com>
> Subject: Re: [PATCH] igb: avoid premature Rx buffer r 
> Okay, this explanation makes much more sense. Could you please either include
> this explanation in your patch, or include a reference to this patch as this
> explains clearly what the issue is while yours didn't and led to the confusion as I
> was assuming the freeing was happening closer to the t0 case, and really the
> problem is t1.
> 
> Thanks.
> 
> - Alex


Ok, I will send V2

Thanks

-Li
