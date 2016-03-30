From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Wed, 30 Mar 2016 13:15:04 -0700
Subject: [Intel-wired-lan] [net PATCH] i40e/i40evf: Limit TSO to 7
 descriptors for payload instead of 8 per packet
In-Reply-To: <20160330200959.GI27540@oracle.com>
References: <20160330064213.12927.46852.stgit@localhost.localdomain>
 <20160330170011.GB27540@oracle.com>
 <CAKgT0UdTgaeamyLetGPK0mqMNS-80BTc8t-WdSGJuuLDfz4JOg@mail.gmail.com>
 <20160330172001.GD27540@oracle.com>
 <CAKgT0Ufb-_X-DD2jYkVJQwLZ-JBfWD2Biuhi6YaxWBeNy9K2fQ@mail.gmail.com>
 <20160330124135.000054c6@unknown> <20160330200959.GI27540@oracle.com>
Message-ID: <1459368904.6473.207.camel@edumazet-glaptop3.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-03-30 at 16:09 -0400, Sowmini Varadhan wrote:
> On (03/30/16 12:41), Jesse Brandeburg wrote:
> > This gets "Even Uglier", I've turned off all offloads at my receiver,
> > enabled calling skb_linearize on *all* frames, which works fine for
> > scp, but the receiver shows > MSS sized frames on the wire for
> > rds-stress traffic.
> 
> fwiw, I was not able to reproduce this tx issue with iperf/netperf
> etc either (I tried various perumtations of bidir, req-resp etc). One
> difference between the rds-stress invocation and the other callers
> is that this comes down via tcp_sendpage(), I dont know if there
> is something in the sendpage path that i40e does not anticipate. 

You might try netperf -t TCP_SENDFILE -- -m 150

to let netperf use sendfile() on small frags.



