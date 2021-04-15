From: Kurt Kanzenbach <kurt@linutronix.de>
Date: Thu, 15 Apr 2021 15:20:02 +0200
Subject: [Intel-wired-lan] [PATCH net] igb: Fix XDP with PTP enabled
In-Reply-To: <20210415145011.6734d3fb@carbon>
References: <20210415092145.27322-1-kurt@linutronix.de>
 <20210415140438.60221f21@carbon> <874kg7hhej.fsf@kurt>
 <20210415145011.6734d3fb@carbon>
Message-ID: <87v98nfzwd.fsf@kurt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu Apr 15 2021, Jesper Dangaard Brouer wrote:
> I have a project involving i225+igc (using TSN).  And someone suggested
> that I also looked at i210 for TSN.  I've ordered hardware that have
> i210 on motherboard (and I will insert my i225 card) so I have a system
> with both chips for experimenting with TSN.  I guess, I would have
> discovered this eventually when I got the hardware.  Thanks for saving
> me from this mistake. Thanks!

Well, both cards are interesting for TSN. However, the i225 has some
advanced features in contrast to the i210. For instance, it supports
time aware scheduling (IEEE 802.1Qbv) in hardware through the Linux
TAPRIO interface.

Thanks,
Kurt
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210415/872458bd/attachment-0001.asc>
