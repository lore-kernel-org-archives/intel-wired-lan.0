From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 17 Jan 2019 13:55:07 -0800
Subject: [Intel-wired-lan] [BUG] igb: reconnecting of cable not always
 detected
In-Reply-To: <87603lbelc.fsf@gmail.com>
References: <87h8o0ocul.fsf@gmail.com>
 <CAKgT0Udj+d7yzPN4Jph8uk7Z6fz0oyWrO+6W6CfygSYTkGJ0Xw@mail.gmail.com>
 <877eovobxl.fsf@gmail.com>
 <CAKgT0UdTf5pf53==hB71Ba_N1gJ-TH_3uMajozr1wykLEbK80g@mail.gmail.com>
 <87wowumj21.fsf@gmail.com>
 <CAKgT0Udtw2ZffwmPf16efcKPKz=C0BVZaJ_DofnyF6LxbH_nPw@mail.gmail.com>
 <87603lbelc.fsf@gmail.com>
Message-ID: <CAL3LdT5DV1faoFsX6CH4LRSQa9rn-Eg71sRu64=bs3w7WCGg4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, May 18, 2018 at 12:36 AM Holger Schurig <holgerschurig@gmail.com> wrote:
>
> Alexander Duyck <alexander.duyck@gmail.com> writes:
> > Thanks for the data. It is actually useful. There are a few things
> > that I see that seem to point to an obvious issue.
>
> Any news on this?
>
> A collegue of mine states (I have not checked this) that a kernel
> 4.9.0-6-686 from a Debian Live ISO (debian-live-9.4.0-i386-kde.iso)
> didn't show this behavior, so we have some kind of regression perhaps?

Our validation team was only able to reproduce this once, but is not
able to reproduce the issue again or even consistently to be able to
adequate debug the issue.

Are you still seeing the issue with the latest upstream kernel from
either David Miller's net-next tree or Linus's tree?

-- 
Cheers,
Jeff
