From: Kurt Kanzenbach <kurt@linutronix.de>
Date: Wed, 21 Apr 2021 08:35:06 +0200
Subject: [Intel-wired-lan] [PATCH net v2] igb: Fix XDP with PTP enabled
In-Reply-To: <c1eed5fe05a59f86ff868580e3ae89e251f498ec.camel@intel.com>
References: <20210419072332.7246-1-kurt@linutronix.de>
 <c1eed5fe05a59f86ff868580e3ae89e251f498ec.camel@intel.com>
Message-ID: <874kg0b0x1.fsf@kurt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>> +		/* pull rx packet timestamp if available */
>> +		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP))
>> {
>> +			timestamp = igb_ptp_rx_pktstamp(rx_ring-
>> >q_vector,
>> +							pktbuf);
>
> The timestamp should be checked for failure and not adjust these values
> if the timestamp was invalid.

OK. I'll adjust it.

Thanks,
Kurt
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210421/b45d280f/attachment.asc>
