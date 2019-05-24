From: Gustavo A. R. Silva <gustavo@embeddedor.com>
Date: Fri, 24 May 2019 08:40:05 -0500
Subject: [Intel-wired-lan] [PATCH 1/6] igb: mark expected switch
 fall-through
In-Reply-To: <4fd1c087e5a19eea44521abc6b8d1213bca3ec22.camel@intel.com>
References: <20190329233850.29630-1-jeffrey.t.kirsher@intel.com>
 <b5f1f0c0-e27b-f861-c36e-35e493f45dff@embeddedor.com>
 <dd2974a0-b559-cfd1-c3d8-0839594ef03c@embeddedor.com>
 <4fd1c087e5a19eea44521abc6b8d1213bca3ec22.camel@intel.com>
Message-ID: <0485c47e-b444-27e2-5634-77d1a0db65ca@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jeff,

On 5/16/19 2:17 PM, Jeff Kirsher wrote:
> On Wed, 2019-05-08 at 12:59 -0500, Gustavo A. R. Silva wrote:
>> Hi Jeff,
>>
>> I wonder if there is any chance for this series to be queued up for
>> 5.2-rc1.
> 
> Possibly, but since the nature of your patch is to just modify a code
> comment because the tools used to check are not sophisticated enough to
> realize the code comment already clearly states "Fall through ...", I
> do not feel this is *really* necessary to get into 'net'.  If I have
> other 'fixes' in my queue that need to get pushed, I may add this
> change to the series.  I have not decided yet whether it warrants being
> in 'net' or could wait till 'net-next'.
> 

I get it, net-next is fine. However, I noticed this series is still in
net-next/dev-queue.

There are only 6 of these fall-through warnings left in linux-next. Half
of them are fixed by this series. We want to add -Wimplicit-fallthrough
to the Makefile and start testing it in linux-next. And it'd be of great
help if you can move this series to your net-next/master, so it can be
merged into linux-next and be part of the test. :)

Thanks!
--
Gustavo
