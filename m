From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 24 Aug 2018 14:15:16 -0700
Subject: [Intel-wired-lan] ixgbe and packet steering
In-Reply-To: <c956c4e6-86bc-bda6-43a7-5cddac043f3c@oracle.com>
References: <c956c4e6-86bc-bda6-43a7-5cddac043f3c@oracle.com>
Message-ID: <20180824141516.000055db@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 24 Aug 2018 09:21:34 -0700 Shannon wrote:
> Is there any particular reason that ixgbe doesn't call 
> skb_record_rx_queue()?  It looks like i40e, igb, and fm10k all call it, 
> but I don't see it in ixgbe's flow.

I can't think of any reason except if it is done as part of another
call.

