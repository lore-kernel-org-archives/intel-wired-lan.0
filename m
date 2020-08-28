From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Date: Fri, 28 Aug 2020 11:56:16 -0400
Subject: [Intel-wired-lan] VRRP not working on i40e X722 S2600WFT
In-Reply-To: <20200827183039.hrfnb63cxq3pmv4z@csclub.uwaterloo.ca>
References: <20200827183039.hrfnb63cxq3pmv4z@csclub.uwaterloo.ca>
Message-ID: <20200828155616.3sd2ivrml2gpcvod@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Aug 27, 2020 at 02:30:39PM -0400, Lennart Sorensen wrote:
> I have hit a new problem with the X722 chipset (Intel R1304WFT server).
> VRRP simply does not work.
> 
> When keepalived registers a vmac interface, and starts transmitting
> multicast packets with the vrp message, it never receives those packets
> from the peers, so all nodes think they are the master.  tcpdump shows
> transmits, but no receives.  If I stop keepalived, which deletes the
> vmac interface, then I start to receive the multicast packets from the
> other nodes.  Even in promisc mode, tcpdump can't see those packets.
> 
> So it seems the hardware is dropping all packets with a source mac that
> matches the source mac of the vmac interface, even when the destination
> is a multicast address that was subcribed to.  This is clearly not
> proper behaviour.
> 
> I tried a stock 5.8 kernel to check if a driver update helped, and updated
> the nvm firware to the latest 4.10 (which appears to be over a year old),
> and nothing changes the behaviour at all.
> 
> Seems other people have hit this problem too:
> http://mails.dpdk.org/archives/users/2018-May/003128.html
> 
> Unless someone has a way to fix this, we will have to change away from
> this hardware very quickly.  The IPsec NAT RSS defect we could tolerate
> although didn't like, while this is just unworkable.
> 
> Quite frustrated by this.  Intel network hardware was always great,
> how did the X722 make it out in this state.

Another case with the same problem on an X710:

https://www.talkend.net/post/13256.html

-- 
Len Sorensen
