From: tndave <tushar.n.dave@oracle.com>
Date: Tue, 7 Mar 2017 15:43:16 -0800
Subject: [Intel-wired-lan] Question on ixgbe flow director
Message-ID: <c5c170c0-a024-5cb2-cd39-81b8cfffd8e5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

I have few questions regarding ixgbe flow director.
As per my understanding flow director in ixgbe can work in 2 exclusive ways,
a. Using ATR filters - where flow director is setup in HW by driver
identifying transmit traffic. And based on that, receive traffic of the
same flow get assigned/directed to same queue.

b. Perfect filter, where user can manually program flow director using
ethtool so that receive packets gets directed to specified rx queue
(depending on on how ethtool flow-type and action etc,.); But with
perfect filters there is no intelligence involved alike ATR has on
identifying transit, right?

Few question regarding ixgbe ATR,
1. does ATR works in case if protocol is UDP? (Based on the current
ixgbe_atr() it only supports TCP)
2. Does ATR flow director can be programmed using ethtool?
(As per my understanding only perfect filter can be programmed from
ethtool, is that so?)

Thanks in advance,
-Tushar

