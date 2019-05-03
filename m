From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Date: Fri, 3 May 2019 16:59:35 -0400
Subject: [Intel-wired-lan] i40e X722 RSS problem with NAT-Traversal
 IPsec packets
In-Reply-To: <CAKgT0UcV2wCr6iUYktZ+Bju_GNpXKzR=M+NLfKhUsw4bsJSiyA@mail.gmail.com>
References: <CAKgT0UczVvREiXwde6yJ8_i9RT2z7FhenEutXJKW8AmDypn_0g@mail.gmail.com>
 <20190502151140.gf5ugodqamtdd5tz@csclub.uwaterloo.ca>
 <CAKgT0Uc_OUAcPfRe6yCSwpYXCXomOXKG2Yvy9c1_1RJn-7Cb5g@mail.gmail.com>
 <20190502171636.3yquioe3gcwsxlus@csclub.uwaterloo.ca>
 <CAKgT0Ufk8LXMb9vVWfvgbjbQFKAuenncf95pfkA0P1t-3+Ni_g@mail.gmail.com>
 <20190502175513.ei7kjug3az6fe753@csclub.uwaterloo.ca>
 <20190502185250.vlsainugtn6zjd6p@csclub.uwaterloo.ca>
 <CAKgT0Uc_YVzns+26-TL+hhmErqG4_w4evRqLCaa=7nME7Zq+Vg@mail.gmail.com>
 <20190503151421.akvmu77lghxcouni@csclub.uwaterloo.ca>
 <CAKgT0UcV2wCr6iUYktZ+Bju_GNpXKzR=M+NLfKhUsw4bsJSiyA@mail.gmail.com>
Message-ID: <20190503205935.bg45rsso5jjj3gnx@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, May 03, 2019 at 10:19:47AM -0700, Alexander Duyck wrote:
> The TCP flow could be bypassing RSS and may be using ATR to decide
> where the Rx packets are processed. Now that I think about it there is
> a possibility that ATR could be interfering with the queue selection.
> You might try disabling it by running:
>     ethtool --set-priv-flags <iface> flow-director-atr off

Hmm, I thought I had killed ATR (I certainly meant to), but it appears
I had not.  I will experiment to see if that makes a difference.

> The problem is RSS can be bypassed for queue selection by things like
> ATR which I called out above. One possibility is that if the
> encryption you were using was leaving the skb->encapsulation flag set,
> and the NIC might have misidentified the packets as something it could
> parse and set up a bunch of rules that were rerouting incoming traffic
> based on outgoing traffic. Disabling the feature should switch off
> that behavior if that is in fact the case.
> 
> You are probably fine using 40 queues. That isn't an even power of two
> so it would actually improve the entropy a bit since the lower bits
> don't have a many:1 mapping to queues.

I will let you know Monday how my tests go with atr off.  I really
thought that was off already since it was supposed to be.  We always
try to turn that off because it does not work well.

-- 
Len Sorensen
