From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 9 Jan 2018 07:47:06 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Don't report unsupported
 timestamping filters for X550
In-Reply-To: <20180109113705.8464-1-mlichvar@redhat.com>
References: <20180109113705.8464-1-mlichvar@redhat.com>
Message-ID: <20180109154706.lcvgaqvekslg64ds@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jan 09, 2018 at 12:37:05PM +0100, Miroslav Lichvar wrote:
> The current code enables on X550 timestamping of all packets for any
> filter, which means ethtool should not report any PTP-specific filters
> as supported.

Right.  I keep forgetting the rule about this.  It is found in the
comment on ethtool_ts_info:

 * Drivers should only report the filters they actually support without
 * upscaling in the SIOCSHWTSTAMP ioctl. If the SIOCSHWSTAMP request for
 * HWTSTAMP_FILTER_V1_SYNC is supported by HWTSTAMP_FILTER_V1_EVENT, then the
 * driver should only report HWTSTAMP_FILTER_V1_EVENT in this op.

Acked-by: Richard Cochran <richardcochran@gmail.com>
