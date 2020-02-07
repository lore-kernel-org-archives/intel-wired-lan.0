From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Date: Fri, 7 Feb 2020 16:51:09 -0500
Subject: [Intel-wired-lan] i40e X722 RSS problem with NAT-Traversal
 IPsec packets
In-Reply-To: <CAKgT0Ue1M8_30PVPmoJy_EGo2mjM26ecz32Myx-hpnuq_6wdjw@mail.gmail.com>
References: <CAKgT0Ucd0s_0F5_nwqXknRngwROyuecUt+4bYzWvp1-2cNSg7g@mail.gmail.com>
 <20190517172317.amopafirjfizlgej@csclub.uwaterloo.ca>
 <CAKgT0UdM28pSTCsaT=TWqmQwCO44NswS0PqFLAzgs9pmn41VeQ@mail.gmail.com>
 <20190521151537.xga4aiq3gjtiif4j@csclub.uwaterloo.ca>
 <CAKgT0UfpZ-ve3Hx26gDkb+YTDHvN3=MJ7NZd2NE7ewF5g=kHHw@mail.gmail.com>
 <20190521175456.zlkiiov5hry2l4q2@csclub.uwaterloo.ca>
 <CAKgT0UcR3q1maBmJz7xj_i+_oux_6FQxua9DOjXQSZzyq6FhkQ@mail.gmail.com>
 <20190522143956.quskqh33ko2wuf47@csclub.uwaterloo.ca>
 <20190607143906.wgi344jcc77qvh24@csclub.uwaterloo.ca>
 <CAKgT0Ue1M8_30PVPmoJy_EGo2mjM26ecz32Myx-hpnuq_6wdjw@mail.gmail.com>
Message-ID: <20200207215109.ym6evogglt5atbnk@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jun 07, 2019 at 12:32:51PM -0700, Alexander Duyck wrote:
> I had reached out to some folks over in the networking division hoping
> that they can get a reproduction as I don't have the hardware that you
> are seeing the issue on so I have no way to reproduce it.
> 
> Maybe someone from that group can reply and tell us where they are on that?

Well I still never heard anything from anyone.  Just installed 4.10
firmware in case that security fix (the only change to happen in over
12 months) did something, but no.

So all UDP encapsulated IPsec packets still always have RSS value of 0.

I am tempted to write a test to see if all UDP encapsulated IP packets
that are not of one of the explicitly handled types have this problem
since I have a suspicion they do.

-- 
Len Sorensen
