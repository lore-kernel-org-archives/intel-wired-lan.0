From: Skidmore, Donald C <donald.c.skidmore@intel.com>
Date: Thu, 8 Sep 2016 00:27:12 +0000
Subject: [Intel-wired-lan] Question about 4 TX/RX queues and ixgbe
In-Reply-To: <A5A784DD-DB62-4511-8D8C-0A1CBCC23250@purestorage.com>
References: <A5A784DD-DB62-4511-8D8C-0A1CBCC23250@purestorage.com>
Message-ID: <F6FB0E698C9B3143BDF729DF2228664696AE8088@ORSMSX116.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Ruslan Nikolaev
> Sent: Wednesday, September 07, 2016 4:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] Question about 4 TX/RX queues and ixgbe
> 
> I just want to follow up on the question regarding 2 queues per VF limit in
> IXGBE. According to the reply by Donald, it seems like the limit is due to limited
> number of interrupts, however:
> 
> 1. Why is it allowed to use 4 TX/RX queues per VF if RSS (for the physical
> function) > 4? The condition in the code to enable 2-queue mode is only when
> rss_i < 4.

We support two queue allocations in SR-IOV mode which is what the conditionals you are looking@here.  You can see the options in the MRQC register from the data sheet.  The two in question are:

1010b = SR-IOV and RSS - 32 pools, 4 RSS
1011b = SR-IOV and RSS - 64 pools, 2 RSS

This allows our PF to have the max queues available, since it has to use a queue pool just like all the VF's.  So limiting the PF to just use one RSS queue really doesn't buy you anything when it comes to the number of queues the VF can support.

> 2. We do not necessarily need separate interrupts for RX, we just need 4 TX
> but are going to use just one 1 RX. Is it still a problem to use the proposed
> change?

In both drivers ixgbe/ixgbevf Rx and Tx queues are paired together.  If you want to write a driver pair that only has one RX queue and 4 TX queues that all share the interrupt you I imagine it could be done. But currently ixgbe/ixgbevf assume the queues are paired together and thus wouldn't work without a major refactor of the code in both drivers.  Likewise I'm not sure what would be gained by having multiple TX queues but only one RX?  But like I mentioned, I have never ran the driver in that mode either. :) 

> 
> Thank you!
> Ruslan
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
