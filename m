From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Thu, 17 Mar 2016 15:41:17 -0400
Subject: [Intel-wired-lan] [E1000-devel] i40e card Tx resets
In-Reply-To: <20160317122814.00000adf@unknown>
References: <56E7A7B6.5030209@gmail.com> <56E7CE18.9020004@gmail.com>
 <20160315105433.GC11063@oracle.com> <56E8D0C5.307@gmail.com>
 <20160316032523.GC19052@oracle.com> <56E94786.9090701@gmail.com>
 <20160316143654.GD21307@oracle.com> <56EA1481.80600@gmail.com>
 <20160317185614.GA14078@oracle.com>
 <20160317122814.00000adf@unknown>
Message-ID: <20160317194117.GN25656@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On (03/17/16 12:28), Jesse Brandeburg wrote:
> We can ask on netdev if the driver should defend against this kind of
> input to hard_start_xmit (transmit routine), but the driver doesn't
> check the maximum length of the skb to see if it is invalid, because
> the stack can never build (only pktgen can) these invalid SKBs.
> 
> The issue is that pktgen builds skb->data with a contiguous buffer of
> whatever size transmit requested, (regardless of MTU) and then sends it
> straight to the transmit routine, no segmentation flags, no MSS set.

I see. And after you mentioned it, I checked with ixgbe, sure 
enough, that also results in a tx-hang for the pktgen test case
(whereas there were no issues with the (rds-stress , ixgbe) test.

I would surmise that pktgen is a bit of an outlier, more interesting
to focus on those cases that use the regular stack.

I dont know if dpdk can create the same issues as pktgen?

> we don't need to bring it up on netdev.  We have a way to troubleshoot
> MDDs that I can send to you, if you want to do the work.  Otherwise we
> need to have some time to reproduce here.

yes, I can do the work, since I already have this nicely set up.
Just need some hings on how to trouble-shoot the mdd.

--Sowmini

