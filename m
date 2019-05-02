From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Date: Thu, 2 May 2019 11:11:40 -0400
Subject: [Intel-wired-lan] i40e X722 RSS problem with NAT-Traversal
 IPsec packets
In-Reply-To: <CAKgT0UczVvREiXwde6yJ8_i9RT2z7FhenEutXJKW8AmDypn_0g@mail.gmail.com>
References: <20190501205215.ptoi2czhklte5jbm@csclub.uwaterloo.ca>
 <CAKgT0UczVvREiXwde6yJ8_i9RT2z7FhenEutXJKW8AmDypn_0g@mail.gmail.com>
Message-ID: <20190502151140.gf5ugodqamtdd5tz@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, May 01, 2019 at 03:52:57PM -0700, Alexander Duyck wrote:
> I'm not sure how RSS will do much for you here. Basically you only
> have the source IP address as your only source of entropy when it
> comes to RSS since the destination IP should always be the same if you
> are performing a server role and terminating packets on the local
> system and as far as the ports in your example you seem to only be
> using 4500 for both the source and the destination.

I have thousands of IPsec clients connecting.  Simply treating them as
normal UDP packets would work.  The IP address is different, and often
the port too.

> In your testing are you only looking at a point to point connection
> between two systems, or do you have multiple systems accessing the
> system you are testing? I ask as the only way this should do any
> traffic spreading via RSS would be if the source IPs are different and
> that would require multiple client systems accessing the server.

I tried changing the client IP address and the RSS hash key.  It never
changed to another queue.  Something is broken.

> In the case of other encapsulation types over UDP, such as VXLAN, I
> know that a hash value is stored in the UDP source port location
> instead of the true source port number. This allows the RSS hashing to
> occur on this extra information which would allow for a greater
> diversity in hash results. Depending on how you are generating the ESP
> encapsulation you might look at seeing if it would be possible to have
> a hash on the inner data used as the UDP source port in the outgoing
> packets. This would help to resolve this sort of issue.

Well it works on every other network card except this one.  Every other
intel card in the past we have used had no problem doing this right.

You want all the packets for a given ipsec tunnel to go to the same queue.
That is not a problem here.  What you don't want is every ipsec packet
from everyone going to the same queue (always queue 0).  So simply
treating them as UDP packets with a source and destination IP and port
would work perfectly fine.  The X722 isn't doing that.  It is always
assigning a hash value of 0 to these packets.

-- 
Len Sorensen
