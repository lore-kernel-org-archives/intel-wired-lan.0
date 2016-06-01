From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 1 Jun 2016 18:31:08 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Correct reporting of
	timestamping for x550
In-Reply-To: <1464799843-2589-1-git-send-email-anthony.l.nguyen@intel.com>
References: <1464799843-2589-1-git-send-email-anthony.l.nguyen@intel.com>
Message-ID: <1464805868.2626.4.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-06-01 at 09:50 -0700, Tony Nguyen wrote:
> Update ixgbe_ethtool_get_ts_info() to show that x550 supports
> hardware
> timestamping of all packets.
> 
> Reported-by: Guy Harris <guy@alum.mit.edu>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Thanks Tony!

Regards,
Jake
