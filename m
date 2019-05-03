From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 3 May 2019 10:19:47 -0700
Subject: [Intel-wired-lan] i40e X722 RSS problem with NAT-Traversal
 IPsec packets
In-Reply-To: <20190503151421.akvmu77lghxcouni@csclub.uwaterloo.ca>
References: <20190501205215.ptoi2czhklte5jbm@csclub.uwaterloo.ca>
 <CAKgT0UczVvREiXwde6yJ8_i9RT2z7FhenEutXJKW8AmDypn_0g@mail.gmail.com>
 <20190502151140.gf5ugodqamtdd5tz@csclub.uwaterloo.ca>
 <CAKgT0Uc_OUAcPfRe6yCSwpYXCXomOXKG2Yvy9c1_1RJn-7Cb5g@mail.gmail.com>
 <20190502171636.3yquioe3gcwsxlus@csclub.uwaterloo.ca>
 <CAKgT0Ufk8LXMb9vVWfvgbjbQFKAuenncf95pfkA0P1t-3+Ni_g@mail.gmail.com>
 <20190502175513.ei7kjug3az6fe753@csclub.uwaterloo.ca>
 <20190502185250.vlsainugtn6zjd6p@csclub.uwaterloo.ca>
 <CAKgT0Uc_YVzns+26-TL+hhmErqG4_w4evRqLCaa=7nME7Zq+Vg@mail.gmail.com>
 <20190503151421.akvmu77lghxcouni@csclub.uwaterloo.ca>
Message-ID: <CAKgT0UcV2wCr6iUYktZ+Bju_GNpXKzR=M+NLfKhUsw4bsJSiyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, May 3, 2019 at 8:14 AM Lennart Sorensen
<lsorense@csclub.uwaterloo.ca> wrote:
>
> On Thu, May 02, 2019 at 01:59:46PM -0700, Alexander Duyck wrote:
> > If I recall correctly RSS is only using something like the lower 9
> > bits (indirection table size of 512) of the resultant hash on the
> > X722, even fewer if you have fewer queues that are a power of 2 and
> > happen to program the indirection table in a round robin fashion. So
> > for example on my system setup with 32 queues it is technically only
> > using the lower 5 bits of the hash.
> >
> > One issue as a result of that is that you can end up with swaths of
> > bits that don't really seem to impact the hash all that much since it
> > will never actually change those bits of the resultant hash. In order
> > to guarantee that every bit in the input impacts the hash you have to
> > make certain you have to gaps in the key wider than the bits you
> > examine in the final hash.
> >
> > A quick and dirty way to verify that the hash key is part of the issue
> > would be to use something like a simple repeating value such as AA:55
> > as your hash key. With something like that every bit you change in the
> > UDP port number should result in a change in the final RSS hash for
> > queue counts of 3 or greater. The downside is the upper 16 bits of the
> > hash are identical to the lower 16 so the actual hash value itself
> > isn't as useful.
>
> OK I set the hkey to
> aa:55:aa:55:aa:55:aa:55:aa:55:aa:55:aa:55:aa:55:aa:55:aa:55:aa:55:aa:55:aa:55:aa:55:aa:55:aa:55:aa:55:aa:55:aa:55:aa:55:aa:55:aa:55:aa:55:aa:55:aa:55:aa:55
> and still only see queue 0 and 2 getting hit with a couple of dozen
> different UDP port numbers I picked.  Changing the hash with ethtool to
> that didn't even move where the tcp packets for my ssh connection are
> going (they are always on queue 2 it seems).

The TCP flow could be bypassing RSS and may be using ATR to decide
where the Rx packets are processed. Now that I think about it there is
a possibility that ATR could be interfering with the queue selection.
You might try disabling it by running:
    ethtool --set-priv-flags <iface> flow-director-atr off

> Does it just not hash UDP packets correctly?  Is it even doing RSS?
> (the register I checked claimed it is).

The problem is RSS can be bypassed for queue selection by things like
ATR which I called out above. One possibility is that if the
encryption you were using was leaving the skb->encapsulation flag set,
and the NIC might have misidentified the packets as something it could
parse and set up a bunch of rules that were rerouting incoming traffic
based on outgoing traffic. Disabling the feature should switch off
that behavior if that is in fact the case.

> This system has 40 queues assigned by default since that is how many
> CPUs there are.  Changing it to a lower number didn't make a difference
> (I tried 32 and 8).

You are probably fine using 40 queues. That isn't an even power of two
so it would actually improve the entropy a bit since the lower bits
don't have a many:1 mapping to queues.
