From: William Kucharski <william.kucharski@oracle.com>
Date: Tue, 22 May 2018 12:00:09 -0600
Subject: [Intel-wired-lan] Regression: Approximate 34% performance hit in
 receive throughput over ixgbe seen due to build_skb patch
Message-ID: <A940030A-CDBF-41CD-816F-0BBC76E7C4F4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

A performance hit of approximately 34% in receive numbers for some packet sizes is
seen when testing traffic over ixgbe links using the network test netperf.

Starting with the top of tree commit 7addb3e4ad3db6a95a953c59884921b5883dcdec,
a git bisect narrowed the issue down to:

commit 6f429223b31c550b835b4f066ac034d0cf0cc71e

    ixgbe: Add support for build_skb

    This patch adds build_skb support to the Rx path.  There are several
    advantages to this change.

    1.  It avoids the memcpy and skb->head allocation for small packets which
        improves performance by about 5% in my tests.
    2.  It avoids the memcpy, skb->head allocation, and eth_get_headlen
        for larger packets improving performance by about 10% in my tests.
    3.  For VXLAN packets it allows the full header to be in skb->data which
        improves the performance by as much as 30% in some of my tests.

Netperf was sourced from:

    https://hewlettpackard.github.io/netperf/

Two machines were directly connected via ixgbe links.

The process "netserver" was started on 10.196.11.8, and running this test:

# netperf -l 60 -H 10.196.11.8 -i 10,2 -I 99,10 -t UDP_STREAM -- -m 64 -s 32768 -S 32768

showed that on machines without the patch, we typically see performance
like:

Socket  Message  Elapsed      Messages
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

 65536      64   60.00     35435847      0     302.38    <-- SEND
 65536           60.00     35391087            302.00    <-- RECEIVE

or

Socket  Message  Elapsed      Messages                
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

 65536      64   60.00     33708816      0     287.65
 65536           60.00     33706010            287.62


However, on machines with the patch, receive performance is seen to fall by an
average of 34%, e.g.:

Socket  Message  Elapsed      Messages
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

 65536      64   60.00     35179881      0     300.20
 65536           60.00     21418471            182.77

or

Socket  Message  Elapsed      Messages                
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

 65536      64   60.00     36937716      0     315.20
 65536           60.00     16838656            143.69

     William Kucharski
     william.kucharski@oracle.com



