From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 15 Mar 2016 23:25:23 -0400
Subject: [Intel-wired-lan] [E1000-devel] i40e card Tx resets
In-Reply-To: <56E8D0C5.307@gmail.com>
References: <20160314214333.GP5084@oracle.com> <56E7A7B6.5030209@gmail.com>
 <56E7CE18.9020004@gmail.com> <20160315105433.GC11063@oracle.com>
 <56E8D0C5.307@gmail.com>
Message-ID: <20160316032523.GC19052@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On (03/16/16 11:19), zhuyj wrote:
> 
> Thanks for your reply.
> Yesterday I made tests with rds-tools. It is very pity that I can
> not reproduce my problem with rds-tools.
> 
> But with pktgen tools, I can reproduce this problem easily. And I
> found that if I set the packet size to 17792 or less than this size,
> this problem would not occur. But if I set the packet size > 17792,
> for example 17793, my problem would occur.

I think it might have to do with number of sockets/cpu/cores and
the irq balancing issues.

> As such, maybe the packet size triggers my problem. I am not sure
> that the packet size will trigger your size.

In my case I did try against netperf request-response (but that is
single threaded) and iperf (but that is unidirectional, i.e.,
it is not a bidirectional request-response test)

perhaps if you share the pktgen config (did you change the
code itself)? some of the i40e experts at intel (who are also
on the to/cc lists of this mail) can try it out themselves? 

I still think that the fundamental problem can be identified
by looking for what's causing the mdd event. 

It must be some type of bug, because ixgbe works fine for me,
and this seems like a regression on that performance.

--Sowmini

