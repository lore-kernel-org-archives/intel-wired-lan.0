From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 15 Mar 2018 18:05:38 +0100
Subject: [Intel-wired-lan] [RFC PATCH 2/2] ixgbe: setup XPS via
 netif_set_xps()
In-Reply-To: <CAKgT0UcoVECKfXBAThcLqb8vRtJetqGjop9pGxNL8Q5rXRtiyg@mail.gmail.com>
References: <cover.1521124830.git.pabeni@redhat.com>
 <384ee099d617f3d3786a618b11cc10616923ec45.1521124830.git.pabeni@redhat.com>
 <CAKgT0UcoVECKfXBAThcLqb8vRtJetqGjop9pGxNL8Q5rXRtiyg@mail.gmail.com>
Message-ID: <1521133538.2681.18.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi, 

On Thu, 2018-03-15 at 09:43 -0700, Alexander Duyck wrote:
> On Thu, Mar 15, 2018 at 8:08 AM, Paolo Abeni <pabeni@redhat.com> wrote:
> > Before this commit, ixgbe with the default setting lacks XPS mapping
> > for CPUs id greater than the number of tx queues.
> > 
> > As a consequence the xmit path for such CPUs experience a relevant cost
> > in __netdev_pick_tx, mainly due to skb_tx_hash(), as reported by the perf
> > tool:
> > 
> > 7.55%--netdev_pick_tx
> >         |
> >         --6.92%--__netdev_pick_tx
> >                   |
> >                   --6.35%--__skb_tx_hash
> >                             |
> >                             --5.94%--__skb_get_hash
> >                                       |
> >                                       --3.22%--__skb_flow_dissect
> > 
> > in the following  scenario:
> > 
> > ethtool -L em1 combined 1
> > taskset 2 netperf -H 192.168.1.1 -t UDP_STREAM -- -m 1
> > MIGRATED UDP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.101.1 () port 0 AF_INET
> > Socket  Message  Elapsed      Messages
> > Size    Size     Time         Okay Errors   Throughput
> > bytes   bytes    secs            #      #   10^6bits/sec
> > 
> > 212992       1   10.00     11497225      0       9.20
> > 
> > After this commit the perf tool reports:
> > 
> > 0.85%--__netdev_pick_tx
> > 
> > and netperf reports:
> > 
> > MIGRATED UDP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.101.1 () port 0 AF_INET
> > Socket  Message  Elapsed      Messages
> > Size    Size     Time         Okay Errors   Throughput
> > bytes   bytes    secs            #      #   10^6bits/sec
> > 
> > 212992       1   10.00     12736058      0      10.19
> > 
> > roughly +10% in xmit tput.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> I think we shouldn't be configuring XPS if number of Tx or Rx queues
> is less than the number of CPUs, or ATR is not enabled.

Thank you for the feedback!

Please note the currently the ixgbe driver is enabling XPS regardless
of the above considerations.

> Really the XPS bits are only really supposed to be used with the ATR
> functionality enabled. If we don't have enough queues for a 1:1
> mapping we should probably not be programming XPS since ATR isn't
> going to function right anyway.

uhm... I don't know the details of ATR, but apparently it is for TCP
only, while the use-case I'm referring to is plain (no tunnel)
unconnected UDP traffic. Am I missing something?

thanks,

Paolo
