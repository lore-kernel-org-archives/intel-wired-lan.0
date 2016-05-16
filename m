From: ethan zhao <ethan.zhao@oracle.com>
Date: Mon, 16 May 2016 10:59:51 +0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: take online CPU number as MQ
 max limit when alloc_etherdev_mq()
In-Reply-To: <CAKgT0UeiEW21E7A9fnt_BUCppopns-E2w1WbwF-8A6sCZkJ8rQ@mail.gmail.com>
References: <1463118995-31763-1-git-send-email-ethan.zhao@oracle.com>
 <CAKgT0UeiEW21E7A9fnt_BUCppopns-E2w1WbwF-8A6sCZkJ8rQ@mail.gmail.com>
Message-ID: <573937A7.9010405@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alexander,

On 2016/5/14 0:46, Alexander Duyck wrote:
> On Thu, May 12, 2016 at 10:56 PM, Ethan Zhao <ethan.zhao@oracle.com> wrote:
>> Allocating 64 Tx/Rx as default doesn't benefit perfomrnace when less
>> CPUs were assigned. especially when DCB is enabled, so we should take
>> num_online_cpus() as top limit, and aslo to make sure every TC has
>> at least one queue, take the MAX_TRAFFIC_CLASS as bottom limit of queues
>> number.
>>
>> Signed-off-by: Ethan Zhao <ethan.zhao@oracle.com>
> What is the harm in allowing the user to specify up to 64 queues if
> they want to?  Also what is your opinion based on?  In the case of RSS

  There is no module parameter to specify queue number in this upstream 
ixgbe
   driver.  for what to specify more queues than num_online_cpus() via 
ethtool ?
  I couldn't figure out the benefit to do that.

  But if DCB is turned on after loading, the queues would be 64/64, that 
doesn't
  make sense if only 16 CPUs assigned.
> traffic the upper limit is only 16 on older NICs, but last I knew the
> latest X550 can support more queues for RSS.  Have you only been
> testing on older NICs or did you test on the latest hardware as well?
   More queues for RSS than num_online_cpus() could bring better 
performance ?
   Test result shows false result.  even memory cost is not an issue for 
most of
   the expensive servers, but not for all.

>
> If you want to control the number of queues allocated in a given
> configuration you should look at the code over in the ixgbe_lib.c, not
   Yes,  RSS,  RSS with SRIOV, FCoE, DCB etc uses different queues 
calculation algorithm.
   But they all take the dev queues allocated in alloc_etherdev_mq() as 
upper limit.

  If we set 64 as default here, DCB would says "oh, there is 64 there, I 
could use it"
> ixgbe_main.c.  All you are doing with this patch is denying the user
> choice with this change as they then are not allowed to set more
   Yes, it is purposed to deny configuration that doesn't benefit.
> queues.  Even if they find your decision was wrong for their
> configuration.
>
> - Alex
>
  Thanks,
  Ethan
