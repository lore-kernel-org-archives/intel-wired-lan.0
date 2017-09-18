From: David Miller <davem@davemloft.net>
Date: Mon, 18 Sep 2017 09:34:36 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH RFC V1 net-next 0/6] Time based packet
	transmission
In-Reply-To: <cover.1505719061.git.rcochran@linutronix.de>
References: <cover.1505719061.git.rcochran@linutronix.de>
Message-ID: <20170918.093436.1069699729581966538.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Richard Cochran <rcochran@linutronix.de>
Date: Mon, 18 Sep 2017 09:41:15 +0200

>   - The driver does not handle out of order packets.  If user space
>     sends a packet with an earlier Tx time, then the code should stop
>     the queue, reshuffle the descriptors accordingly, and then
>     restart the queue.

The user should simply be not allowed to do this.

Once the packet is in the device queue, that's it.  You cannot insert
a new packet to be transmitted before an already hw queued packet,
period.

Any out of order request should be rejected with an error.

I'd say the same is true for requests to send packets timed
in the past.
