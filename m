From: tndave <tushar.n.dave@oracle.com>
Date: Wed, 8 Mar 2017 11:30:54 -0800
Subject: [Intel-wired-lan] Question on ixgbe flow director
In-Reply-To: <CAKgT0UfT9zdzPHQawFtGZf9k1mwHG5_jZorXNDsoiOrUfNnZJw@mail.gmail.com>
References: <c5c170c0-a024-5cb2-cd39-81b8cfffd8e5@oracle.com>
 <CAKgT0UfT9zdzPHQawFtGZf9k1mwHG5_jZorXNDsoiOrUfNnZJw@mail.gmail.com>
Message-ID: <5e81301b-f660-43a5-3400-8cbf7d3a77aa@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 03/08/2017 07:39 AM, Alexander Duyck wrote:
> On Tue, Mar 7, 2017 at 3:43 PM, tndave <tushar.n.dave@oracle.com>
> wrote:
>> Hi,
>>
>> I have few questions regarding ixgbe flow director. As per my
>> understanding flow director in ixgbe can work in 2 exclusive ways,
>>  a. Using ATR filters - where flow director is setup in HW by
>> driver identifying transmit traffic. And based on that, receive
>> traffic of the same flow get assigned/directed to same queue.
>
> So ATR for ixgbe uses the Flow Director signature filters. Basically
> the signature filters are purely hash based filters.  The easiest way
> to think of it is it is essentially a beefed up version of RSS.
Alex,

Thanks for the info.
>
>> b. Perfect filter, where user can manually program flow director
>> using ethtool so that receive packets gets directed to specified
>> rx queue (depending on on how ethtool flow-type and action etc,.);
>> But with perfect filters there is no intelligence involved alike
>> ATR has on identifying transit, right?
>
> You are right.  The perfect match filters are the ones we configure
> via ethtool.  You are correct in that ATR logic is not involved so
> there is no matching up an Rx flow to a Tx flow.
>
>> Few question regarding ixgbe ATR, 1. does ATR works in case if
>> protocol is UDP? (Based on the current ixgbe_atr() it only
>> supports TCP)
>
> It could, but the software for doing ATR flow identification,
> ixgbe_atr(), only works on TCP.  The reasoning behind it is that Flow
> Director doesn't filter fragmented frames and UDP can be fragmented.
So we could just add code in ixgbe_atr() for non-fragmented udp packets!
However question is if it is going to work w.r.t ATR? TCP is connected
stream vs udp is stateless and single udp socket can talk to multiple
endpoints.

>
>> 2. Does ATR flow director can be programmed using ethtool? (As per
>> my understanding only perfect filter can be programmed from
>> ethtool, is that so?)
>
> You can enable/disable the ATR filters via the NTUPLE feaure flag.
> Basically it toggles between ATR mode, and NTUPLE mode.  In NTUPLE
> mode the perfect filters are enabled and can be configured via
> ethtool.
Got it.

Thanks.

-Tushar
>
>> Thanks in advance, -Tushar
>
> Hope that helps.
>
> - Alex
>
